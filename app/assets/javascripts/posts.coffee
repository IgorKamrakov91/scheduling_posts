change_visibility = (status) ->
  console.log status

  if status == "Scheduled"
    $(".published-field").show()
  else
    $(".published-field").hide()

jQuery ->
  # check the current selected status and show/hide the published at field
  # and do the same thing when the status field changes
  change_visibility $("#post_status :selected").text()

  $("#post_status").on (change), (e) ->
    change_visibility $(this).find(":selected").text()
