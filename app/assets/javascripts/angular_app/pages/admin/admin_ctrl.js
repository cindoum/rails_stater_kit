angular.module("starterApp").controller('AdminCtrl', ['$scope', 'viewModel', function($scope, viewModel) {
    var _init = function () {
        $scope.users = viewModel;
    };
    
    _init();
}]);