module FormatResponse
    def self.doFormat (success, info, data, meta = nil, toJson = true)
        raise StandardError, "Response format not acceptable, 'success' param is mandatory" unless !success.nil?
        
        if info.nil?
           if success == true 
              info = "The request has been threated successfully" 
           else
              info = "The request has failed"
           end
        end
        
        resp = { :success => success, :info => info, :data => data, :meta => meta } 
        
        if toJson == true
            resp.to_json
        else
            resp
        end
    end
    
    def self.success (info, data, meta = nil, toJson = true)
        return :status => 200, :json => doFormat(true, info, data, meta, toJson)
    end
    
    def self.failure (info, data, meta = nil, toJson = true)
        return :status => 200, :json => doFormat(false, info, data, meta, toJson)
    end
    
    def self.error (status, info, data, meta = nil, toJson = true)
       return :status => status, :json => doFormat(false, info, data, meta, toJson)
    end
end