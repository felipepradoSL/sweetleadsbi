$(document).on 'turbolinks:load', ->
  $(".messages").css 'height', $(window).height()/2
  return


$(document).on 'turbolinks:load', ->
  $('table').excelTableFilter()
  $('.modal').modal()
  $('.tabs').tabs()
  $('.sidenav').sidenav()
  $('.collapsible').collapsible()
  $('.datepicker').datepicker dateFormat: 'dd/mm/yy'
  $('.parallax').parallax()
  $('[data-toggle="tooltip"]').tooltip()
  $('select').formSelect()
  $('.parallax-container').css 'height', 450
  $('.video-parallax-container').height $(window).height()
  M.updateTextFields();
  return



$(document).on 'turbolinks:before-cache', ->
  elem = document.querySelector('#slide-out')
  if elem
    instance = M.Sidenav.getInstance(elem)
  if instance
    instance.destroy()
  return


$(document).on 'turbolinks:before-cache', ->
  M.updateTextFields();
  return