angular.module("starterApp").controller('LoginCtrl', ['$scope', '$location', 'Session', function($scope, $location, Session) {
    var _init = function () {
        $scope.user = { rememberme: true};
    };
    
    $scope.login = function() {
        Session.login($scope.user);
    };

    $scope.loginOauth = function(provider) {
        window.location.href = '/users/auth/' + provider
    };
    
    _init();
}]);