#ifndef VEHICLECLIENT_H
#define VEHICLECLIENT_H

#include <QObject>
#include <QtMqtt/QMqttClient>
#include <QVector>
#include <QDebug>

#include <map>
#include <functional>

#include "telemetrycontroller.h"

class VehicleClient;

class QmlMqttSubscription : public QObject {
    Q_OBJECT
    Q_PROPERTY(QMqttTopicFilter topic MEMBER m_topic NOTIFY topicChanged)
    QML_UNCREATABLE("Not intended to be creatable")
public:
    QmlMqttSubscription(QMqttSubscription *s, VehicleClient *c);
    ~QmlMqttSubscription();

Q_SIGNALS:
    void topicChanged(QString);
    void messageReceived(const QString &msg);

public slots:
    void handleMessage(const QMqttMessage &qmsg);

private:
    Q_DISABLE_COPY(QmlMqttSubscription)
    QMqttSubscription *sub;
    VehicleClient *client;
    QMqttTopicFilter m_topic;
};

class VehicleClient : public QObject {
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString hostname READ hostname WRITE setHostname NOTIFY hostnameChanged)
    Q_PROPERTY(int port READ port WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(QMqttClient::ClientState state READ state WRITE setState NOTIFY stateChanged)
    Q_PROPERTY(TelemetryController* controller READ controller WRITE setController NOTIFY controllerChanged)
    QML_EXTENDED_NAMESPACE(QMqttClient)
public:
    explicit VehicleClient(QObject *parent = nullptr);

    QVector<QString> topics() const;
    void addTopicHandler(const QString &topic, const std::function<void(const QByteArray&)> &func);

    Q_INVOKABLE void connectToBroker();
    Q_INVOKABLE void disconnectFromBroker();
    Q_INVOKABLE void subscribeToTopics();
    Q_INVOKABLE QmlMqttSubscription* subscribe(const QString &topic);

    const QString hostname() const;
    void setHostname(const QString &newHostname);

    void setController(TelemetryController* controller);
    TelemetryController* controller() const;

    int port() const;
    void setPort(int newPort);


    QMqttClient::ClientState state() const;
    void setState(const QMqttClient::ClientState &newState);
    void handleMessage(const QByteArray &message, const QMqttTopicName &topic);
signals:
    void hostnameChanged();
    void portChanged();
    void stateChanged();
    void controllerChanged();

private:
    TelemetryController* m_controller;
    Q_DISABLE_COPY(VehicleClient)
    QMqttClient m_client;
    QVector<QmlMqttSubscription*> m_subs;
    std::map<QMqttTopicName, std::function<void(const QByteArray&)>> m_topicHandlers;
};

#endif // VEHICLECLIENT_H
