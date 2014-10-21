module FormatResponse
    def self.doFormat (success, info, data, meta = nil)
        raise StandardError, "Response format not acceptable, 'success' param is mandatory" unless !success.nil?
        
        if info.nil?
           if success == true 
              info = "The request has been threated successfully" 
           else
              info = "The request has failed"
           end
        end
        
        resp = { :success => success, :info => info, :data => data, :meta => meta } 
    end
    
    def self.success (info, data, meta = nil)
        return :status => 200, :json => doFormat(true, info, data, meta)
    end
    
    def self.failure (info, data, meta = nil)
        return :status => 200, :json => doFormat(false, info, data, meta)
    end
    
    def self.error (status, info, data, meta = nil)
       return :status => status, :json => doFormat(false, info, data, meta)
    end
    
    def self.add_json_options (resp, options)
        resp[:json][:data] = JSON.parse(resp[:json][:data].to_json(options))
    end
end