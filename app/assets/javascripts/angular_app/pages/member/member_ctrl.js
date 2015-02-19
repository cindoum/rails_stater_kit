angular.module("starterApp").controller('MemberCtrl', ['$scope', 'viewModel', '$route', '$http', 'Session', '$location', function($scope, viewModel, $route, $http, Session, $location) {
    var _init = function () {
         $scope.member = viewModel.data || {};
         $scope.meta = viewModel.meta;
         $scope.member._isAdmin = _convertRoleMaskToIsAdmin($scope.member.roles_mask);
         $scope.isCurrentUserAdmin = Session.isAdmin();
         
         if ($scope.meta.is_new == true) { $scope.member.is_enable = true; }
    };
    
    var _convertRoleMaskToIsAdmin = function (role) {
        if (role == null) return false;
        else if (role == 2) return false;
        else if (role == 1) return true;
        else return false
    };
    
    var _convertIsAdminToRoleMask = function (isAdmin) {
        return isAdmin == true ? 1 : 2;  
    };
    
    $scope.save = function () {
        $scope.member.roles_mask = _convertIsAdminToRoleMask($scope.member._isAdmin);
        
        if ($scope.meta.is_new == false) {
            $http.put('/members', { user: $scope.member}).then(function (resp) {
                $route.reload();
            });
        }
        else {
            $http.post('/members', { user: $scope.member}).then(function (resp) {
                $location.path('/member/'  + resp.meta.id);
            });   
        }
    };
    
    _init();
}]);