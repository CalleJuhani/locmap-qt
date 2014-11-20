#include <QApplication>
#include <QQmlApplicationEngine>
#include "network.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    Network* nw = new Network();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
