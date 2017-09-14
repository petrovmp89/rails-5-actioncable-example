App.room = App.cable.subscriptions.create "NewsChannel",
  received: (data) ->
    $('#header').html data['header']
    $('#annotation').html data['annotation']
    $('#date').html data['date']
    $('#no-news').hide()
