angular.module("starterApp").factory('Session', function($location, $http, $q) {
    function redirect(url) {
        url = url || '/';
        $location.path(url);
    }
    
    var service = {
        login: function(user) {
            return $http.post('/login', {user: {email: user.email, password: user.password, rememberme: user.rememberme} })
                .then(function(resp) {
                    service.currentUser = resp;
                    if (service.isAuthenticated()) {
                        $location.path('/');
                    }
                }, function (resp) {
                    // error handling
                });
        },
        register: function (user) {
            return $http.post('/register', { user: { email: user.email, password: user.password, admin: user.admin }})  
                .then(function (resp) {
                    service.currentUser = resp;
                    if (service.isAuthenticated()) {
                        $location.path('/');
                    }
                }, function (resp) {
                   // error handling 
                });
        },
        logout: function(redirectTo) {
            $http.delete('/logout').then(function(resp) {
                service.currentUser = null;
                redirect(redirectTo);
            });
        },
        requestCurrentUser: function() {
            if (service.isAuthenticated()) {
                return $q.when(service.currentUser);
            } else {
                return $http.get('/current_user').then(function(resp) {
                    service.currentUser = resp;
                    return service.currentUser;
                });
            }
        },
        currentUser: null,
        isAuthenticated: function(){
            return !!service.currentUser;
        },
    };
    return service;
});