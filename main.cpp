#include <QApplication>
#include <QQmlApplicationEngine>
#include "sortfilterproxymodel.h"
#include <QtQml/qqml.h>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<SortFilterProxyModel>("SortFilterProxyModel", 0, 1, "SortFilterProxyModel");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));
    return app.exec();
}
