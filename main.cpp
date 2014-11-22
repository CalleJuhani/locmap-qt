#include <QApplication>
#include <QQmlApplicationEngine>
#include "network.h"
#include "sortfilterproxymodel.h"
#include <QtQml/qqml.h>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //Network* nw = new Network();
    qmlRegisterType<SortFilterProxyModel>("SortFilterProxyModel", 0, 1, "SortFilterProxyModel");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
