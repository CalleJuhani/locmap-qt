var base = "http://api.locmap.net/v1/";
var login = "http://api.locmap.net/v1/auth/login";

function request(verb, endpoint) {
    var BASE = "http://api.locmap.net/v1"
    print('request: ' + verb + ' ' + BASE + (endpoint?'/' + endpoint:''))
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        print('xhr: on ready state change: ' + xhr.readyState)
        if(xhr.readyState === XMLHttpRequest.DONE) {
            print(xhr.responseText.toString());
        }
    }
    xhr.open(verb, BASE + (endpoint?'/' + endpoint:''));
    xhr.setRequestHeader('Content-Type', 'application/json');
    //xhr.setRequestHeader('Accept', 'application/json');
    //var data = obj?JSON.stringify(obj):''
    xhr.send()
}

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

function Response(statuscode, headers, body) {
    this.statuscode = statuscode;
    this.headers = headers;
    this.body = body;
}

