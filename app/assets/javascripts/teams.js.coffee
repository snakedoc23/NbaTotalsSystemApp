# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.tg').popover({placement: 'top'})
  $('.tg').on 'mouseover', ->
    id = $(this).data('game')
    $('.tg').removeClass('selectedGame').filter ->
      return $(this).data('game') == id 
    .addClass('selectedGame')
  $('.team').on 'mouseover', ->
    $('.team_name').removeClass('selectedGame')
    $(this).find($('.team_name')).addClass('selectedGame')