#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "ribbonui.h"
#include "ribbonuitemplate_version.h"

#ifdef RIBBONUI_BUILD_STATIC_LIB
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
#define Q_IMPORT_QML_PLUGIN(PLUGIN) \
Q_IMPORT_PLUGIN(PLUGIN)
extern void qml_static_register_types_RibbonUI();
#endif
Q_IMPORT_QML_PLUGIN(RibbonUIPlugin)
#endif

int main(int argc, char *argv[])
{
    RibbonUI::init(); // Must set before QGuiApplication
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    RibbonUI::registerTypes(nullptr);
#ifdef RIBBONUI_BUILD_STATIC_LIB
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    qml_static_register_types_RibbonUI();
#endif
#endif
    const QUrl url("qrc:/qt-project.org/imports/"+QString(RIBBONTEMPLATE_URI)+"/template.qml"); // Edit your main page here
    engine.rootContext()->setContextProperty("RibbonTemplateUri", QString(RIBBONTEMPLATE_URI)); // Edit your custom app uri here
    engine.rootContext()->setContextProperty("RibbonTemplateVersion", RIBBONUITEMPLATE_VERSION); // Edit your app version here
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
