#include "network.h"
#include "QDebug"

/*Network::Network(QObject *parent) : QObject(parent) {
    this->url = QUrl("http://example.com");
    startRequest(this->url);
}*/

Network::Network() {
    this->url = QUrl("http://example.com");
    startRequest(this->url);
}

void Network::startRequest(QUrl url) {
    reply = qnam.get(QNetworkRequest(url));
    connect(reply, SIGNAL(finished()), this, SLOT(httpFinished()));
}

void Network::httpFinished() {

    qDebug() << "httpFinished " << reply->readAll();
}
