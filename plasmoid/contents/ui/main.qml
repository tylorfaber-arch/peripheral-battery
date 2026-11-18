import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PC3
import org.kde.plasma.plasma5support as P5

PlasmoidItem {
    id: root
    property var items: []
    property string details: ""
    readonly property string cmd: "peripheral-battery --widget"

    preferredRepresentation: fullRepresentation
    toolTipMainText: "Peripheral Battery"
    toolTipSubText: details + "\nClick to choose devices"

    fullRepresentation: PC3.Label {
        text: root.items.length ? root.items.join(" ".repeat(Plasmoid.configuration.spacing)) : "🔋 …"
        font.pointSize: Plasmoid.configuration.fontSize > 0 ? Plasmoid.configuration.fontSize
                                                              : PC3.Label.font.pointSize
        font.bold: Plasmoid.configuration.bold
        Layout.minimumWidth: implicitWidth
        Layout.alignment: Qt.AlignVCenter
        MouseArea {
            anchors.fill: parent
            onClicked: runner.connectSource(
                "konsole -e peripheral-battery setup || xdg-terminal-exec peripheral-battery setup")
        }
    }

    // The executable engine runs a command once per connect, so a Timer
    // disconnects and reconnects it to read fresh values.
    P5.DataSource {
        id: poll
        engine: "executable"
        onNewData: (source, data) => {
            disconnectSource(source)
            const lines = data.stdout.trim().split("\n")
            if (lines[0]) root.items = lines[0].split(/\s{2,}/)
            root.details = lines.slice(1).join("\n")
        }
    }

    function refresh() {
        poll.disconnectSource(root.cmd)
        poll.connectSource(root.cmd)
    }

    Timer {
        interval: Math.max(5, Plasmoid.configuration.interval) * 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }

    P5.DataSource {
        id: runner
        engine: "executable"
        onNewData: (source, data) => {
            disconnectSource(source)
            root.refresh()
        }
    }
}
