angular.module("starterApp").factory('Session', ['$location', 'SessionResource', '$q', function($location, SessionResource, $q) {
    function redirect(url) {
        url = url || '/';
        $location.path(url);
    }
    
    var service = {
        login: function(user) {
            return SessionResource.login({user: {email: user.email, password: user.password, rememberme: user.rememberme} }).$promise.then(function (resp) {
                service.currentUser = resp;
                if (service.isAuthenticated()) {
                    $location.path('/');
                }
            });
        },
        register: function (user) {
            return SessionResource.register({ user: { email: user.email, password: user.password, admin: user.admin }}).$promise.then(function (resp) {
                service.currentUser = resp;
                if (service.isAuthenticated()) {
                    $location.path('/');
                }
            });
        },
        logout: function(redirectTo) {
            return SessionResource.logout().$promise.then(function (resp) {
                service.currentUser = null;
                redirect(redirectTo);
            });
                    },
        requestCurrentUser: function() {
            if (service.isAuthenticated()) {
                return $q.when(service.currentUser);
            } else {
                return SessionResource.getCurrentUser().$promise.then(function (resp) {
                    service.currentUser = resp;
                    return service.currentUser;
                });
            }
        },
        isAdmin: function () {
            return service.currentUser != null && service.currentUser.roles_mask == 1;
        },
        isAuthenticated: function(){
            return !!service.currentUser;
        },
        currentUser: null,
    };
    return service;
}]);