angular.module("starterApp").controller('PrivateCtrl', ['$scope', 'viewModel', function($scope, viewModel) {
    var _init = function () {
         $scope.roles = viewModel.data.data;
    };
    
    _init();
}]);