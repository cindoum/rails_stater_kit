angular.module("starterApp").factory('Session', function() {
    return $restmod.model('/user');
});