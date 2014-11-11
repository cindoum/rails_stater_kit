class Failure < Devise::FailureApp
    def respond
        self.status = 401
        self.content_type = 'json'
        self.response_body = FormatResponse.doFormat(false, "Access denied", nil)
    end
end