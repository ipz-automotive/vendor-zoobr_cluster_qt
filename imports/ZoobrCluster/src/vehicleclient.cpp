#include "vehicleclient.h"
#include <QThread>

QmlMqttSubscription::QmlMqttSubscription(QMqttSubscription *s, VehicleClient *c)
    : sub(s)
    , client(c) {
    connect(sub, &QMqttSubscription::messageReceived, this, &QmlMqttSubscription::handleMessage);
    m_topic = sub->topic();
}

QmlMqttSubscription::~QmlMqttSubscription() {
}

void QmlMqttSubscription::handleMessage(const QMqttMessage &qmsg) {
    client->handleMessage(qmsg.payload(), qmsg.topic());
    emit messageReceived(qmsg.payload());
}

VehicleClient::VehicleClient(QObject *parent)
    : QObject(parent), m_controller{TelemetryController::getInstance()} {
    qDebug() << "VehicleClient: init";
    connect(&m_client, &QMqttClient::hostnameChanged, this, &VehicleClient::hostnameChanged);
    connect(&m_client, &QMqttClient::portChanged, this, &VehicleClient::portChanged);
    connect(&m_client, &QMqttClient::stateChanged, this, &VehicleClient::stateChanged);
    // Mapping topic names to appropriate handler functions
    m_topicHandlers.insert_or_assign(QMqttTopicName("speed"), std::bind(&TelemetryController::receiveSpeed, m_controller, std::placeholders::_1));
    m_topicHandlers.insert_or_assign(QMqttTopicName("rpm"), std::bind(&TelemetryController::receiveRpm, m_controller, std::placeholders::_1));
    m_topicHandlers.insert_or_assign(QMqttTopicName("gear"), std::bind(&TelemetryController::receiveGear, m_controller, std::placeholders::_1));
    m_topicHandlers.insert_or_assign(QMqttTopicName("odo"), std::bind(&TelemetryController::receiveOdo, m_controller, std::placeholders::_1));
    m_topicHandlers.insert_or_assign(QMqttTopicName("range"), std::bind(&TelemetryController::receiveRange, m_controller, std::placeholders::_1));
    m_topicHandlers.insert_or_assign(QMqttTopicName("fuel"), std::bind(&TelemetryController::receiveFuelLevel, m_controller, std::placeholders::_1));
    m_topicHandlers.insert_or_assign(QMqttTopicName("coolant"), std::bind(&TelemetryController::receiveCoolantTemp, m_controller, std::placeholders::_1));
}

QmlMqttSubscription* VehicleClient::subscribe(const QString &topic) {
    qDebug() << "VehicleClient: Subscribe to topic: " + topic;
    auto sub = m_client.subscribe(topic, 0);

    auto result = new QmlMqttSubscription(sub, this);
    m_subs.push_back(result);
    return result;
}

void VehicleClient::setController(TelemetryController* controller) {
    if (m_controller != controller) {
        m_controller = controller;
        emit controllerChanged();
    }
}

TelemetryController* VehicleClient::controller() const {
    return m_controller;
}

QVector<QString> VehicleClient::topics() const {
    QVector<QString> topics;
    for (auto& it : m_topicHandlers) {
        topics.push_back(it.first.name());
    }
    return topics;
}

void VehicleClient::addTopicHandler(const QString &topic, const std::function<void(const QByteArray&)> &func) {
    auto it = m_topicHandlers.find(QMqttTopicName(topic));
    if (it == m_topicHandlers.end()) {
        m_topicHandlers[QMqttTopicName(topic)] = func;
        qDebug() << "VehicleClient: Added a handler to a topic";
    } else {
        qDebug() << "VehicleClient: Failed to add a handler to a topic";
    }
}

void VehicleClient::connectToBroker() {
    qDebug() << "VehicleClient: Connecting to broker";
    m_client.connectToHost();
}

void VehicleClient::disconnectFromBroker() {
    qDebug() << "VehicleClient: Disconnecting from broker";
    m_client.disconnectFromHost();
}

void VehicleClient::subscribeToTopics() {
    qDebug() << "VehicleClient: Subscribing to topics";
    for (auto& topic : topics()) {
        auto ret = subscribe(topic);
    }
}

void VehicleClient::handleMessage(const QByteArray &message, const QMqttTopicName &topic) {
    qDebug() << "VehicleClient: incoming topic:" << topic.name() << ", message:" << QString::fromUtf8(message);
    auto it = m_topicHandlers.find(topic);
    if (it != m_topicHandlers.end()) {
        it->second(message);
        // qDebug() << "VehicleClient: Handling message for " + topic.name() + ": " + QString::fromUtf8(message);
    } else {
        qDebug() << "VehicleClient: Message received on unknown topic " + topic.name() + ": " + QString::fromUtf8(message);
    }
}

const QString VehicleClient::hostname() const {
    return m_client.hostname();
}

void VehicleClient::setHostname(const QString &newHostname) {
    qDebug() << "VehicleClient: Host name set to: " + newHostname;
    m_client.setHostname(newHostname);
}

int VehicleClient::port() const {
    return m_client.port();
}

void VehicleClient::setPort(int newPort) {
    if (newPort < 0 || newPort > std::numeric_limits<quint16>::max()) {
        qWarning() << "Trying to set invalid port number";
        return;
    }
    qDebug() << "VehicleClient: Port set to: " << newPort;
    m_client.setPort(static_cast<quint16>(newPort));
}

QMqttClient::ClientState VehicleClient::state() const {
    return m_client.state();
}

void VehicleClient::setState(const QMqttClient::ClientState &newState) {
    qDebug() << "VehicleClient: State set to: " << newState;
    m_client.setState(newState);
}

