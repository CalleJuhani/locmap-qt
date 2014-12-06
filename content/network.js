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
            //var res = new Response(req.status, req.getAllResponseHeaders(), req.responseText);
            var res = JSON.parse(req.responseText.toString())
            print(res.users);
            //print(req.status);
            cb(res.users);
        }
    }

    req.open("GET", base + "users");
    req.setRequestHeader('Content-Type', 'application/json');
    req.setRequestHeader('Accept', 'application/json');
    req.send();
}

function Response(statuscode, headers, body) {
    this.statuscode = statuscode;
    this.headers = headers;
    this.body = body;
}

