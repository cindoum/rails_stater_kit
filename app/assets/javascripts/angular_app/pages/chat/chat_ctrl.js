angular.module("starterApp").controller('ChatCtrl', ['$scope', 'ResponseValidator', function($scope, ResponseValidator) {
    var _init = function () {
        $scope.users = [];
        $scope.msgs = [];
        $scope.dispatcher = _initWebSocket()
        _bindWebSocket($scope.dispatcher);
    };
    
    $scope.sendPrivateMessage = function (user) {
        if ($scope.user_message) {
            $scope.user_message = [$scope.user_message.slice(0, 0), '@' + user.user_name + ' ', $scope.user_message.slice(0)].join('');
        }
        else {
            $scope.user_message = '@' + user.user_name + ' ';
        }
        
        user._isOpen = false;
        $('#chat_input').focus();
    };
    
    $scope.seeProfile = function (user) {
        user._isOpen = false;
    };
    
    $scope.talk = function (msg) {
        if (msg) {
            if (msg.indexOf('@') === 0) {
                $scope.dispatcher.trigger('private_message', msg);
            }
            else {
                $scope.dispatcher.trigger('broadcast_message', msg);
            }
            
            $scope.user_message = '';
        }
    };
    
    var _initWebSocket = function () {
        return new WebSocketRails('playgroundonrails-c9-doum.c9.io/websocket');
    };
    
    var _bindWebSocket = function (dispatcher) {
        dispatcher.bind('client_connected', _manageUsers);
        
        dispatcher.bind('client_disconnected', _manageUsers);
        
        dispatcher.bind('broadcast_message', _printMessage);
        
        dispatcher.bind('private_message', _printMessage);
    };
    
    $scope.triggerTalk = function (e) {
        if (e.which == 13) {
            $scope.talk($scope.user_message);
        }
    }
    
    var _manageUsers = function (resp) {
        var data = ResponseValidator.validate(resp);
        if (data != null && data.data != null) {
            data = data.data.data;
            
            var changedUser = _findChangeUser($scope.users, data.users);
            _addUserChangeText(data.users.length > $scope.users.length, changedUser)
            
            $scope.users = data.users;
            $scope.$apply();
        }
    };
    
    var _findChangeUser = function (oldUsers, newUsers, added) {
        if (newUsers.length > $scope.users.length) {
            return _.last(newUsers);
        }
        else {
            for (var i = 0, it = oldUsers.length; i < it; i++) {
                var found = false;
                
                for (var j = 0, jt = newUsers.length; j < jt; j++) {
                    if (oldUsers[i].socket_id == newUsers[j].socket_id) {
                        found = true;
                    }
                }
                
                if (found === false) {
                    return oldUsers[i];
                }
            }
        }
    };
    
    var _printMessage = function (resp) {
        var from;
        var msg;
        var data = ResponseValidator.validate(resp);
        
        if (data != null && data.data != null) {
            data = data.data.data;
            
            if (data.user == null && data.from != null) {
                from = data.from.user_name;
                msg = data.msg
                $scope.msgs.push('<p class="private">- <span class="user_name">' + from + '</span> : ' + msg + '</p>');
            }
            else {
                from = data.user.user_name;
                msg = data.msg;
                $scope.msgs.push('<p>- <span class="user_name">' + from + '</span> : ' + msg + '</p>');
            }
            
            $scope.$apply();
            _scrollMsgWindow();     
        }
    };
    
    var _addUserChangeText = function (added, user, needApply) {
        $scope.msgs.push('<p class="system">- [<span class="user_name">' + user.user_name + '</span> has ' + (added === true ? 'joined' : 'left') + ']</p>');
        
        if (needApply == true) {
            $scope.$apply();
        }
        
        _scrollMsgWindow();
    };
    
    var _scrollMsgWindow = function () {
        var divx = document.getElementById("msg_container");
        divx.scrollTop = divx.scrollHeight;
    };
    
    
    _init();
}]);