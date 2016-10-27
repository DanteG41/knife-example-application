source = new EventSource('/comments')

source.onmessage = (event) ->
  console.log(event.data)
  return if event.data == 'heartbeat'
  $('#comments').find('.media-list').prepend($.parseHTML(JSON.parse(event.data)['html']))

jQuery ->
  $('#new_comment').submit ->
    $(this).find("input[type='submit']").val('Sending...').prop('disabled', true)

  return