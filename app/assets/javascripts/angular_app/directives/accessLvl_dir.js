angular.module("starterApp").directive('accessLevel', ['Session', function(Session) {
    return {
        restrict: 'A',
        link: function($scope, element, attrs) {
            // 0 => notlogged, 1 => Admin, 2 => User
            
            var prevDisp = element.css('display');
            var accessLevel = attrs.accessLevel;
                
            var userRole = Session.currentUser != null ? Session.currentUser.roles_mask : 0;
            $scope.service = Session;

            $scope.$watch('service.currentUser', function(user, oldUser) {
                if(user)
                    userRole = user.roles_mask;
                else
                    userRole = 0;
                updateCSS();
            });

            // Why would we change accessLevel on any element? this is quite static data
            /*attrs.$observe('accessLevel', function(al) {
                if(al) accessLevel = $scope.$eval(al);
                updateCSS();
            });*/

            function updateCSS() {
                if (accessLevel == 0 && userRole == 0) {
                    element.css('display', prevDisp);
                    return;
                }
                
                if (userRole == 1) { //ADMIN
                    if (accessLevel == 1 || accessLevel == 2) {
                        element.css('display', prevDisp);
                    }
                    else {
                        element.css('display', 'none');
                    }
                }
                else if (userRole == 2) { //USER
                    if (accessLevel == 2) {
                        element.css('display', prevDisp);
                    }
                    else {
                        element.css('display', 'none');
                    }
                }
                else {
                    element.css('display', 'none');
                }
            }
        }
    };
}]);