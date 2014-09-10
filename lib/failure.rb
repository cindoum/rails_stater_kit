class Failure < Devise::FailureApp
    def respond
        resp = {
            "success" => false,
            "info" =>"Acess denied" ,
            "data" => nil
        }.to_json
        
        self.status = 401
        self.content_type = 'json'
        self.response_body = resp
    end
end