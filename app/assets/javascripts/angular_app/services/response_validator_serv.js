angular.module("starterApp").factory('ResponseValidator', ['$injector', function($injector) {
    var validator = {
        validate: function (resp, status) {
            if (resp != null && resp.connection_id == null) {
                if (resp.success == null) {
                    throw 'Response is not formatted. Response must contain a success param'
                }
                else if (resp.success == true) {
                    return { data: { data: resp.data, meta: resp.meta, info: resp.info }}
                }
                else if (resp.success == false) {
                    var options = { 
                      "allowHtml": true,
                      "positionClass": "toast-top-right",
                      "timeOut": "10000",
                      "extendedTimeOut": "10000"
                    }
                    
                    if (status == 500 || status == 401 || status == 403){
                      $injector.invoke(['toastr', function (toastr) {
                          var msg = resp.data;
                          
                          if (resp.meta != null) {
                              if (resp.meta.guid != null) {
                                  msg += '<br /><a target="_blank" href="http://errbitrails.herokuapp.com/locate/' + resp.meta.guid + '">See error detail\'s</a>';
                              }
                          }
                          
                          toastr.error(msg, resp.info, options);
                      }]);
                      
                      if (resp.status == 401) {
                          $location.path('/login');
                      }
                  }
                }
                else {
                    throw 'Response is not formatted. Success param must be a boolean'
                }
            }
            
            return null;
        }
    }
    
    return validator;
}]);