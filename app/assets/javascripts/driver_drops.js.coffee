# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
 
window.addBranchLink = ->
  for t in $('#chart').find('text[text-anchor="end"]')
    branch = t.innerHTML;
    t.textContent = ("<a href='/driver_drop/1/'>#{branch}</a>") ;
    #alert("#{t.textContent}");     
