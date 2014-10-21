angular.module('starterApp').constant('memberResolver', {
   resolve: {
        viewModel: ['MemberResource', '$route', function (MemberResource, $route) {
            var id = $route.current.params.id || 'new';
            return MemberResource.read({id: id}).$promise.then();
        }]
    },
    resolveIndex: {
         viewModel: ['MemberResource', 'indexLimit', function (MemberResource, indexLimit) {
            return  MemberResource.retrieveAll({limit: indexLimit}).$promise.then();
        }],
        config: ['indexLimit', 'Session', 'MemberResource', function (indexLimit, Session, MemberResource) {
            return {
                name: 'Members',
                resource: MemberResource.retrieveAll,
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
