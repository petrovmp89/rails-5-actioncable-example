App.room = App.cable.subscriptions.create "NewsChannel",
  received: (data) ->
    $('#header h4').html data['header']
    $('#annotation p').html data['annotation']
    $('#date p').html data['date']
    $('#no-news').hide()
