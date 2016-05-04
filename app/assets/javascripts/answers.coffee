# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    # alert "The answer was deleted."

  $(".answer .form-horizontal").hide()

  $(".answer-edit").on "click", ->
    answer = $(@).closest(".answer")
    answer.find(".form-horizontal").toggle()
    answer.find("p.body").toggle()
    if $(@).hasClass("btn-warning")
      $(@).removeClass("btn-warning").addClass("btn-primary")
      $(@).html('Отмена')
    else
      $(@).removeClass("btn-primary").addClass("btn-warning")
      $(@).html('Редактировать')

$(document).ready(ready)
$(document).on('page:load', ready)
