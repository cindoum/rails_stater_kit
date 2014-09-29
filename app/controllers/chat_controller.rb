class ChatController < WebsocketRails::BaseController
    def initialize_session
      @@users_list = Array.new
    end

    def client_connected
        @@users_list.push({:user_name => current_user.user_name, :socket_id => client_id, :id => current_user.id})
        new_message = {:users => @@users_list}
        
        broadcast_message :client_connected, FormatResponse.format_websocket(true, nil, new_message)
    end
    
    def client_disconnected
        @@users_list = @@users_list.reject { |u| u[:socket_id] == client_id }
        new_message = {:users => @@users_list}
        broadcast_message :client_disconnected, FormatResponse.format_websocket(true, nil, new_message)
    end
    
    def broadcast_message_from_client
        msg = message
        from = @@users_list.find { |u| u[:socket_id] == client_id }
        new_message = {:user => from, :msg => msg}
        broadcast_message :broadcast_message, FormatResponse.format_websocket(true, nil, new_message)
    end
    
    def private_message
        user_name_code = message.split(" ").first
        user_name = user_name_code.split("@").last
        
        user = @@users_list.find { |u| u[:user_name] == user_name }
        from = @@users_list.find { |u| u[:socket_id] == client_id }
        socket = WebsocketRails.users[user[:id]]
        
        if user.nil?
            socket.send_message :private_message, FormatResponse.format_websocket(false, nil, nil)
            send_message :private_message, FormatResponse.format_websocket(false, nil, nil)
        else
            str_msg = message.sub user_name_code, ""
            
            resp = FormatResponse.format_websocket(true, nil, {from: from, msg: str_msg}) 
                
            socket.send_message :private_message, resp
            send_message :private_message, resp
        end
    end
end