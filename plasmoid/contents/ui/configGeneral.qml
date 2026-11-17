import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_fontSize: fontSize.value
    property alias cfg_bold: bold.checked
    property alias cfg_spacing: spacing.value
    property alias cfg_interval: interval.value

    Kirigami.FormLayout {
        QQC2.SpinBox {
            id: fontSize
            Kirigami.FormData.label: "Text size (pt, 0 = panel default):"
            from: 0; to: 72
        }
        QQC2.CheckBox { id: bold; Kirigami.FormData.label: "Bold:" }
        QQC2.SpinBox {
            id: spacing
            Kirigami.FormData.label: "Space between devices:"
            from: 1; to: 10
        }
        QQC2.SpinBox {
            id: interval
            Kirigami.FormData.label: "Refresh every (seconds):"
            from: 5; to: 3600
        }
        QQC2.Label {
            text: "Choose which devices to show: click the widget, or run <tt>peripheral-battery setup</tt>."
            textFormat: Text.StyledText
            wrapMode: Text.WordWrap
        }
    }
}
