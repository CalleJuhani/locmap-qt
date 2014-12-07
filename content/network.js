var base = "http://api.locmap.net/v1/";

function postLogin(credentials, cb) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if(req.readyState === XMLHttpRequest.DONE) {
            cb(req.getResponseHeader("x-access-token"));
        }
    }
    req.open("POST", base + "auth/login");
    req.setRequestHeader('Content-Type', 'application/json');
    req.setRequestHeader('Accept', 'application/json');
    req.send(credentials)
}


function getLocations(cb) {
    var req = new XMLHttpRequest();

    req.onreadystatechange = function() {
        if(req.readyState === XMLHttpRequest.DONE) {
            var res = JSON.parse(req.responseText.toString())
            cb(res.locations);
        }
    }

    req.open("GET", base + "locations");
    req.setRequestHeader('Content-Type', 'application/json');
    req.setRequestHeader('Accept', 'application/json');
    req.send();
}

function putLocation(id, json, token, cb) {
    var req = new XMLHttpRequest();

    req.onreadystatechange = function() {
        if(req.readyState === XMLHttpRequest.DONE) {
            var res = "";
            if (req.status === 400) {
                res = JSON.parse(req.responseText.toString()).message;
            }
            cb(req.status, res);
        }
    }

    req.open("PUT", base + "locations/" + id);
    req.setRequestHeader('Content-Type', 'application/json');
    req.setRequestHeader('Accept', 'application/json');
    req.setRequestHeader('Authorization', 'Bearer ' + token);
    req.send(json);
}

function deleteLocation(id, token, cb) {
    var req = new XMLHttpRequest();

    req.onreadystatechange = function() {
        if(req.readyState === XMLHttpRequest.DONE) {
            var res = JSON.parse(req.responseText.toString())
            cb(res.message);
        }
    }

    req.open("DELETE", base + "locations/" + id);
    req.setRequestHeader('Content-Type', 'application/json');
    req.setRequestHeader('Accept', 'application/json');
    req.setRequestHeader('Authorization', 'Bearer ' + token);
    req.send();
}

function getUsers(token, cb) {
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
    req.setRequestHeader('Authorization', 'Bearer ' + token);
    print('Bearer ' + token);
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

