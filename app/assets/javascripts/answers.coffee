# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

onEditClick = ->
  $(".answer-edit.btn-primary").not(@).click()
  answer = $(@).closest(".answer")
  answer.find(".form-edit").toggle()
  answer.find(".body").toggle()
  if $(@).hasClass("btn-warning")
    $(@).removeClass("btn-warning").addClass("btn-primary")
    $(@).html('Отмена')
  else
    $(@).removeClass("btn-primary").addClass("btn-warning")
    $(@).html('Редактировать')

onUpdate = ->
  $(".answer-edit").on "click", onEditClick

ready = ->
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    # alert "The answer was deleted."

  $(".answer .form-edit").hide()
  $(".answer-edit").on "click", onEditClick

$(document).ready(ready)
$(document).on('page:load', ready)
# $(document).on('page:partial-load', onUpdate)
# $(document).on('page:update', onUpdate)
# $(document).on('page:change', onUpdate)
