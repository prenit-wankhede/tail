class LogsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "logs"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
