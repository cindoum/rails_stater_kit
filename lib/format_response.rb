class FormatResponse
    def self.doFormat (success, info, data, toJson = true)
        raise StandardError, "Response format not acceptable, 'success' param is mandatory" unless !success.nil?
        
        if info.nil?
           if success == true 
              info = "The request has been threated successfully" 
           else
              info = "The request has failed"
           end
        end
        
        resp = { :success => success, :info => info, :data => data } 
        
        if toJson == true
            resp.to_json
        else
            resp
        end
    end
end