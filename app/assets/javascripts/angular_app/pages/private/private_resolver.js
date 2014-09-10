var privateResolver = {
    resolve: {
        viewModel: ['$http', function ($http) {
            return $http.get('/private').then();
        }]
    }
};
