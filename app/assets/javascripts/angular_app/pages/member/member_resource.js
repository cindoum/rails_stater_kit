angular.module('starterApp').factory('MemberResource', ['$resource', function ($resource) {
    return $resource('members', {}, {
        retrieveAll: { method: 'GET', url: '/members' },
        read: { method: 'GET', url: '/members/:id' },
        create: { method: 'POST', url: '/members' },
        update: { method: 'PUT', url: '/members' }
    });
}]);