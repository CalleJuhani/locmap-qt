#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
#include <QWidget>
#include <QNetworkAccessManager>
#include <QUrl>
#include <QNetworkReply>

class Network : public QObject
{
    Q_OBJECT
public:
    //explicit Network(QObject *parent = 0);
    void startRequest(QUrl url);
    Network();

private:
    QNetworkAccessManager qnam;
    QNetworkReply *reply;
    QUrl url;

public slots:
    void httpFinished();

};

#endif // NETWORK_H
