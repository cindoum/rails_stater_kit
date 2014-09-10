WebsocketRails::EventMap.describe do
    subscribe :client_connected, :to => ChatController, :with_method => :client_connected
    subscribe :client_disconnected, :to => ChatController, :with_method => :client_disconnected
    subscribe :broadcast_message, :to => ChatController, :with_method => :broadcast_message_from_client
    subscribe :private_message, :to => ChatController, :with_method => :private_message
    
end
