class CommentsController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'
    @stream = SSE.new(response.stream)

    Comment.connection.execute "LISTEN comments"

    main_thread = Thread.current
    locals = main_thread.keys.map { |key| [key, main_thread[key]] }

    listener = Thread.new do
      local_thread = Thread.current
      local_thread.abort_on_exception = true

      locals.each { |k, v| local_thread[k] = v }
      loop do
        Comment.connection.raw_connection.wait_for_notify do |event, pid, id|
          comment = Comment.find(id)
          @stream.write(
            {:html => render_to_string(partial: 'comment', formats: [:html], locals: {comment: comment})}
          )
        end
      end
    end

    start_heartbeat!
    render nothing: true
  rescue IOError
    nil
  ensure
    Comment.connection.execute "UNLISTEN comments"
    Thread.kill(listener) if listener
  end

  def new
    @comment = Comment.new
    @comments = Comment.order('created_at DESC')
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  private

  def start_heartbeat!
    loop do
      # Send heartbeat to unsure client is connected (no other way to know about that)
      @stream.write('heartbeat')
      sleep 5
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
