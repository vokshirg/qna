# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

onEditClick = ->
  answer = $(@).closest(".answer")
  $(".answer").not(answer).find(".answer-cancel").click()
  $(@).hide()
  answer.find(".answer-cancel").show()
  answer.find(".form-edit").show()
  answer.find(".body").hide()

onCancelClick = ->
  answer = $(@).closest(".answer")
  $(@).hide()
  answer.find(".answer-edit").show()
  answer.find(".form-edit").hide()
  answer.find(".body").show()

ready = ->
  # $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
  $(".answer-edit").on "click", onEditClick
  $(".answer-cancel").on "click", onCancelClick

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
