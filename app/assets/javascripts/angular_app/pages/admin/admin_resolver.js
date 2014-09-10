var adminResolver = {
    resolve: {
        viewModel: ['$http', function ($http) {
            return $http.get('/admin').then();
        }]
    }
};
