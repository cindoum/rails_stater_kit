angular.module("starterApp").controller('RegisterCtrl', ['$scope', '$location', 'Session', function($scope, $location, Session) {
    var _init = function () {
        $scope.user =  {};
        $scope.roles = ['Admin', 'User'];
    };
    
    $scope.register = function() {
        Session.register($scope.user);
    };

    _init();
}]);