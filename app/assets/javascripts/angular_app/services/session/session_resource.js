angular.module('starterApp').factory('SessionResource', ['$resource', function ($resource) {
    return $resource('', {}, {
        login: { method: 'POST', url: '/login' },
        register: { method: 'POST', url: '/register' },
        logout: { method: 'DELETE', url: '/logout' },
        getCurrentUser: { method: 'GET', url: '/current_user' }
    });
}]);