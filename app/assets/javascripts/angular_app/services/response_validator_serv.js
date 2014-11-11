angular.module("starterApp").factory('ResponseValidator', function() {
    var validator = {
        validate: function (resp) {
            if (resp != null && resp.connection_id == null) {
                if (resp.success == null) {
                    throw 'Response is not formatted. Response must contain a success param'
                }
                else if (resp.success == true) {
                    return { data: resp.data, meta: resp.meta }
                }
                else if (resp.success == false) {
                    //log error plus send to toastr (with resp.info)
                    alert(resp.info);
                }
                else {
                    throw 'Response is not formatted. Success param must be a boolean'
                }
            }
            
            return null;
        }
    }
    
    return validator;
});