angular.module('starterApp').constant('memberResolver', {
   resolve: {
        viewModel: ['$http', '$route', function ($http, $route) {
            var id = $route.current.params.id || 'new';
            
            return $http.get('/members/' + id).then();
        }]
    },
    resolveIndex: {
         viewModel: ['$http', 'indexLimit', function ($http, indexLimit) {
            return  $http.get('/members', { params: { limit: indexLimit }}).then();
        }],
        config: ['indexLimit', 'Session', function (indexLimit, Session) {
            return {
                name: 'Members',
                url: 'members',
                create: Session.isAdmin(),
                icon: 'users',
                id: 'id',
                entity: 'users',
                columns: [{name: 'Email', field: 'email'}, {name: 'First Name', field: 'first_name'}, {name: 'Last Name', field: 'last_name'}, {name: 'Is Enable', field: 'is_enable', type: 'checkbox'}],
                predicate: 'email',
                pageLimit: indexLimit,
                createLink: true
            }
        }]
    }
});
