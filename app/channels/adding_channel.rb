class AddingChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'adding_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify(id)
    ActionCable.server.broadcast(
      'adding_channel',
      id: id
    )
  end
end
