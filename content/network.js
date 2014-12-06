var base = "http://api.locmap.net/v1/";
var login = "http://api.locmap.net/v1/auth/login";

function post(url, json, cb) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if(req.readyState === XMLHttpRequest.DONE) {
            print(req.getResponseHeader("x-access-token"));

            print(req.status);
            cb(req.responseText.toString())
        }
    }
    req.open("POST", url);
    req.setRequestHeader('Content-Type', 'application/json');
    req.setRequestHeader('Accept', 'application/json');
    //var data = obj?JSON.stringify(obj):''
    req.send(json)
}


function getUsers(cb) {
    var req = new XMLHttpRequest();

    req.onreadystatechange = function() {
        if(req.readyState === XMLHttpRequest.DONE) {
            var res = JSON.parse(req.responseText.toString())
            cb(res.users);
        }
    }

    req.open("GET", base + "users");
    req.setRequestHeader('Content-Type', 'application/json');
    req.setRequestHeader('Accept', 'application/json');
    req.send();
}


function deleteUser(id, cb) {
    var req = new XMLHttpRequest();

    req.onreadystatechange = function() {
        if(req.readyState === XMLHttpRequest.DONE) {
            cb();
        }
    }

    req.open("DELETE", base + "users/" + id);
    req.setRequestHeader('Content-Type', 'application/json');
    req.setRequestHeader('Accept', 'application/json');
    req.send();

}

