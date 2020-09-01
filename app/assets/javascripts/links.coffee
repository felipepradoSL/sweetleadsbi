$(document).on 'turbolinks:load', ->
  



  $('.open-dialog').click ->
    title = '/'
    if $(this).text() == 'home'
      title = 'home'
    else if $(this).text() == 'mail'
      title = 'mail'
    else if $(this).text() == 'perm_contact_calendar'
      title = 'calendar'
    else if $(this).text() == 'notifications'
      title = 'notifications'
    else if $(this).text() == 'help'
      title = 'help'
    $( "#dialog" ).dialog
      closeOnEscape: true
      show: { effect: "fade" }
      hide: { effect: "fade" }
      title: title
      position: { my: "top", at: "bottom", of: '.open-dialog' }
    return




  $('.open-dialog').mouseover ->
    $(this).addClass 'animated jello infinite'
    return


  $('.open-dialog').mouseout ->
    $(this).removeClass 'animated jello infinite'
    return











  return

