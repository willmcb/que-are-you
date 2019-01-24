App.adding = App.cable.subscriptions.create "AddingChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data.id)

  notify: (id) ->
    @perform 'notify', id: id
