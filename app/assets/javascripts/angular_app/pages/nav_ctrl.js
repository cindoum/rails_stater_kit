angular.module("starterApp").controller('NavCtrl', ['$scope', 'Session', function($scope, Session) {
    var _init = function () {
    };
    
    $scope.logout = function () {
        Session.logout();
    }
    
    _init();
}]);