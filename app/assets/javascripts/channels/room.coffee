App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if 'message' of data && $('#messages').length
      $('#messages').append data['message']
      if $('.message:last > p').hasClass($(".comment .current_id").val())
        $('.message:last > p').addClass("own")
      else
        $('.message:last > p').addClass("other")

    if 'member' of data && $('#member').length
      entrant = $('#member > .entrant').html()
      $('#member').html data['member']
      if $('#member > .entrant').html() != "" && entrant == ""
        alert "チャットが開始されました"
      if $('#member > .entrant').html() == "" && entrant != ""
        alert "相手が退室しました"

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value
    event.target.value = ''
    event.preventDefault()
