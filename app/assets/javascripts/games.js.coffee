$ ->
  $('.ag').popover({placement: 'top'})
  $('.hg').popover({placement: 'top'})

  $game = $('.game')
  $game.on 'mouseover', ->
    $game.removeClass('selectedGame')
    $(this).addClass('selectedGame')