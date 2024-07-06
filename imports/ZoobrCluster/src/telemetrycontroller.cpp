#include "telemetrycontroller.h"
#include <QDebug>



TelemetryController* TelemetryController::s_instance = nullptr;

TelemetryController::TelemetryController(QObject *parent)
    : QObject{parent} {

}

TelemetryController* TelemetryController::getInstance() {
    if(s_instance)
        return s_instance;

    auto instance = new TelemetryController();
    s_instance = instance;
    return  instance;
}

float TelemetryController::speed() const {
    return m_speed;
}

float TelemetryController::rpm() const {
    return m_rpm;
}

int TelemetryController::gear() const {
    return m_gear;
}

float TelemetryController::odo() const {
    return m_odo;
}

float TelemetryController::range() const {
    return m_range;
}

float TelemetryController::fuelLevel() const {
    return m_fuelLevel;
}

float TelemetryController::coolantTemp() const {
    return m_coolantTemp;
}


void TelemetryController::setSpeed(float speed) {
    if (m_speed != speed) {
        m_speed = speed;
        emit speedChanged(speed);
    }
}

void TelemetryController::setRpm(float rpm) {
    if (m_rpm != rpm) {
        m_rpm = rpm;
        emit rpmChanged(rpm);
    }
}

void TelemetryController::setGear(int gear) {
    if (m_gear != gear) {
        m_gear = gear;
        emit gearChanged(gear);
    }
}

void TelemetryController::setOdo(float odo) {
    if (m_odo != odo) {
        m_odo = odo;
        emit odoChanged(odo);
    }
}

void TelemetryController::setRange(int range) {
    if (m_range != range) {
        m_range = range;
        emit rangeChanged(range);
    }
}

void TelemetryController::setFuelLevel(float fuel_level) {
    if (m_fuelLevel != fuel_level) {
        m_fuelLevel = fuel_level;
        emit fuelLevelChanged(fuel_level);
    }
}

void TelemetryController::setCoolantTemp(float coolant_temp) {
    if (m_coolantTemp != coolant_temp) {
        m_coolantTemp = coolant_temp;
        emit coolantTempChanged(coolant_temp);
    }
}

// handle Message
void TelemetryController::receiveSpeed(const QByteArray &message) {
    bool ok;
    float value = message.toFloat(&ok);
    if (ok) {
        setSpeed(value);
    }
}

void TelemetryController::receiveRpm(const QByteArray &message) {
    bool ok;
    float value = message.toFloat(&ok);
    if (ok) {
        setRpm(value);
    }
}

void TelemetryController::receiveGear(const QByteArray &message) {
    bool ok;
    int value = message.toInt(&ok);
    if (ok) {
        setGear(value);
    }
}

void TelemetryController::receiveOdo(const QByteArray &message) {
    bool ok;
    float value = message.toFloat(&ok);
    if (ok) {
        setOdo(value);
    }
}

void TelemetryController::receiveRange(const QByteArray &message) {
    bool ok;
    int value = message.toInt(&ok);
    if (ok) {
        setRange(value);
    }
}

void TelemetryController::receiveFuelLevel(const QByteArray &message) {
    bool ok;
    float value = message.toFloat(&ok);
    if (ok) {
        setFuelLevel(value);
    }
}

void TelemetryController::receiveCoolantTemp(const QByteArray &message) {
    bool ok;
    float value = message.toFloat(&ok);
    if (ok) {
        setCoolantTemp(value);
    }
}
