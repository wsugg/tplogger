# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
 
window.selectHandler = ->
 $(document).ready()
 md = $(chart).mousedown()
 text = $("#chart").find('text[text-anchor="start"]')
 t = text[2].textContent;
 ddrop = $('.drop').children()

 for d in ddrop 
  if d.innerHTML.match(t) 
   #alert("we did it #{d.href}   #{t}")
   d.click()