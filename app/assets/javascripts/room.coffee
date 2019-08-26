# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

max_wait_time = 180000 # millisecond

check_room_member = ->
  setTimeout ->
    exit_room()
  , max_wait_time

exit_room = ->
  if $("#member > .entrant").html() == ""
    alert "マッチング出来ませんでした"
    window.location.href = "/logout"

$(document).ready ->
  check_room_member()
