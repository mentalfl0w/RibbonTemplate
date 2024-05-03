#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "ribbonui.h"
#include "definitions.h"

#ifdef RIBBONUI_BUILD_STATIC_LIB
Q_IMPORT_QML_PLUGIN(RibbonUIPlugin)
#endif

int main(int argc, char *argv[])
{
    RibbonUI::init(); // Must set before QGuiApplication
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    RibbonUI::registerTypes(&engine);
    const QUrl url("qrc:/qt/qml/"+QString(RIBBONTEMPLATE_URI)+"/qml/template.qml"); // Edit your main page here
    engine.rootContext()->setContextProperty("RibbonTemplateUri", QString(RIBBONTEMPLATE_URI)); // Edit your custom app uri here
    engine.rootContext()->setContextProperty("RibbonTemplateVersion", VER_JOIN(RIBBONTEMPLATE_VERSION)); // Edit your app version here
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
