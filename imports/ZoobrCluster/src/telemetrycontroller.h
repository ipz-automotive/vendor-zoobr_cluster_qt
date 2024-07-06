#ifndef TELEMETRYCONTROLLER_H
#define TELEMETRYCONTROLLER_H

#include <QObject>
#include <qqml.h>

class TelemetryController : public QObject {
    Q_OBJECT
    QML_SINGLETON
    QML_ELEMENT
    Q_PROPERTY(float speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(float rpm READ rpm WRITE setRpm NOTIFY rpmChanged)
    Q_PROPERTY(int gear READ gear WRITE setGear NOTIFY gearChanged)
    Q_PROPERTY(float odo READ odo WRITE setOdo NOTIFY odoChanged)
    Q_PROPERTY(float range READ range WRITE setRange NOTIFY rangeChanged)
    Q_PROPERTY(float fuelLevel READ fuelLevel WRITE setFuelLevel NOTIFY fuelLevelChanged)
    Q_PROPERTY(float coolantTemp READ coolantTemp WRITE setCoolantTemp NOTIFY coolantTempChanged)
public:
    explicit TelemetryController(QObject *parent = nullptr);
    Q_INVOKABLE static TelemetryController* getInstance();
    float speed() const;
    float rpm() const;
    int gear() const;
    float odo() const;
    float range() const;
    float fuelLevel() const;
    float coolantTemp() const;

    void setSpeed(float speed);
    void setRpm(float rpm);
    void setGear(int gear);
    void setOdo(float odo);
    void setRange(int range);
    void setFuelLevel(float fuel_level);
    void setCoolantTemp(float coolant_temp);

    void receiveSpeed(const QByteArray &message);
    void receiveRpm(const QByteArray &message);
    void receiveGear(const QByteArray &message);
    void receiveOdo(const QByteArray &message);
    void receiveRange(const QByteArray &message);
    void receiveFuelLevel(const QByteArray &message);
    void receiveCoolantTemp(const QByteArray &message);

signals:
    void speedChanged(float speed);
    void rpmChanged(float rpm);
    void gearChanged(int gear);
    void odoChanged(float odo);
    void rangeChanged(int range);
    void fuelLevelChanged(float fuelLevel);
    void coolantTempChanged(float coolantTemp);
private:

    Q_DISABLE_COPY(TelemetryController);
    static TelemetryController *s_instance;
    float m_speed{0};
    float m_rpm{0};
    int m_gear{-2};
    float m_odo{0};
    int m_range{100};
    float m_fuelLevel{1};
    float m_coolantTemp{1};
};

#endif // TELEMETRYCONTROLLER_H
