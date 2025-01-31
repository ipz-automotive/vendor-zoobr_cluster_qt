pragma Singleton
import QtQuick 6.2
// import QtQuick.Studio.Application

QtObject {
    readonly property int width: 1920
    readonly property int height: 540

    readonly property int gaugeSize: 340

    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                            family: Qt.application.font.family,
                                            pixelSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                family: Qt.application.font.family,
                                                pixelSize: Qt.application.font.pixelSize * 1.6
                                              })



    // property StudioApplication application: StudioApplication {
    //     fontPath: Qt.resolvedUrl("../../content/" + relativeFontDirectory)
    // }
}
