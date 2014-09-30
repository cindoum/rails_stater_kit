class FormatResponse
    def self.doFormat (success, info, data)
        raise StandardError, "Response format not acceptable, 'success' param is mandatory" unless !success.nil?
        
        if info.nil?
           if success == true 
              info = "The request has been threated successfully" 
           else
              info = "The request has failed"
           end
        end
        
        { :success => success, :info => info, :data => data }.to_json
    end
end