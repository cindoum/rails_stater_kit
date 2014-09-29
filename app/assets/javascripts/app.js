angular.module("starterApp", ['ngRoute', 'templates', 'ngSanitize', 'ui.bootstrap']);

/*starterApp.config(['$locationProvider', function ($locationProvider) {
    $locationProvider.html5Mode(true);
}]);*/

angular.module("starterApp").config(['$routeProvider', '$httpProvider', function($routeProvider, $httpProvider) {
    $routeProvider
        .when('/', { templateUrl: 'angular_app/pages/home.html'})
        .when('/login', { templateUrl: 'angular_app/pages/login/login.html', controller: 'LoginCtrl'})
        .when('/register', { templateUrl: 'angular_app/pages/register/register.html', controller: 'RegisterCtrl'})
        .when('/private', { templateUrl: 'angular_app/pages/private/private.html', controller: 'PrivateCtrl', resolve: privateResolver.resolve })
        .when('/admin', { templateUrl: 'angular_app/pages/admin/admin.html', controller: 'AdminCtrl', resolve: adminResolver.resolve})
        .when('/chat', { templateUrl: 'angular_app/pages/chat/chat.html', controller: 'ChatCtrl'})
        .otherwise({ redirectTo: '/' });
        
    var logsOutUserOn401 = ['$q', '$location', 'ResponseValidator', function ($q, $location, ResponseValidator) {
    var success = function (response) {
        var data = null;
        
        if (response.data.success != null) {
           data = ResponseValidator.validate(response.data);
        } 
        
        return data || response;
    };

    var error = function (response) {
        var data = null;
        
        if (response.data.success != null) {
           data = ResponseValidator.validate(response.data);
        }
        
        if (response.status === 401) {
            $location.path('/login');
        } 
        
        return $q.reject(data || response);
    };

    return function (promise) {
      return promise.then(success, error);
    };
  }];

  $httpProvider.responseInterceptors.push(logsOutUserOn401);
}]);

angular.element(document).ready(function() {
    var req = $.ajax({ url: '/current_user' });
    
    var handler = function (resp) {
        var app = angular.bootstrap(document, ["starterApp"]);
        var session = app.get('Session');
        var root = app.get('$rootScope');
        var $location = app.get('$location');
        
        if (resp.data) {
          session.currentUser = resp.data;
        }
        else {
          session.currentUser = null;
        }
        
        var anonRoutes = ['/login', '/register', '/'];
        var userRoutes = ['/private', '/chat'];
        var adminRoutes = ['/admin'];
        
        root.$on('$routeChangeStart', function (event, next, current) {
            if (anonRoutes.indexOf($location.url()) == -1 && !session.isAuthenticated()) {
                $location.path('/login');
            }
            else if(session.isAuthenticated()) {
                var mask = session.currentUser.roles_mask;
            
                if (mask > 1 && adminRoutes.indexOf($location.url()) != -1) {
                    $location.path('/');
                }
            }
        });
          
        root.$apply(); 
    };
    
    req.done(handler);
    req.fail(handler);
});
