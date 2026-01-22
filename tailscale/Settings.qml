import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Widgets

ScrollView {
  id: root

  property var pluginApi: null
  property var settings: pluginApi?.pluginSettings

  implicitWidth: contentColumn.implicitWidth
  implicitHeight: contentColumn.implicitHeight

  function save() {
    if (pluginApi) {
      pluginApi.saveSettings()
    }
  }

  ColumnLayout {
    id: contentColumn
    width: root.availableWidth
    spacing: Style.marginM

    NText {
      text: pluginApi?.tr("settings.title") || "Tailscale Settings"
      font.pointSize: Style.fontSizeXL
      font.bold: true
    }

    NText {
      text: pluginApi?.tr("settings.description") || "Configure Tailscale status display in the menu bar"
      color: Color.mSecondary
    }

    Item { Layout.preferredHeight: Style.marginL }

    NText {
      text: pluginApi?.tr("settings.refresh-interval") || "Refresh Interval"
      font.bold: true
    }

    NText {
      text: pluginApi?.tr("settings.refresh-interval-desc") || "How often to check Tailscale status (in milliseconds)"
      color: Color.mSecondary
      Layout.fillWidth: true
      wrapMode: Text.Wrap
    }

    NTextInput {
      Layout.fillWidth: true
      text: settings?.refreshInterval?.toString() || "5000"
      placeholderText: "5000"
      validator: IntValidator { bottom: 1000; top: 60000 }
      onTextChanged: {
        if (settings && text) {
          settings.refreshInterval = parseInt(text)
        }
      }
    }

    Item { Layout.preferredHeight: Style.marginL }

    NText {
      text: pluginApi?.tr("settings.display-options") || "Display Options"
      font.bold: true
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.marginM

      NCheckbox {
        id: compactModeCheckbox
        text: pluginApi?.tr("settings.compact-mode") || "Compact Mode"
        checked: settings?.compactMode || false

        onCheckedChanged: {
          if (settings) {
            settings.compactMode = checked
          }
        }
      }

      NText {
        text: pluginApi?.tr("settings.compact-mode-desc") || "Show only icon"
        color: Color.mSecondary
        Layout.fillWidth: true
      }
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.marginM

      NCheckbox {
        id: showIpCheckbox
        text: pluginApi?.tr("settings.show-ip") || "Show IP Address"
        checked: settings?.showIpAddress !== false

        onCheckedChanged: {
          if (settings) {
            settings.showIpAddress = checked
          }
        }
      }

      NText {
        text: pluginApi?.tr("settings.show-ip-desc") || "Display Tailscale IP in bar"
        color: Color.mSecondary
        Layout.fillWidth: true
      }
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.marginM

      NCheckbox {
        id: showPeerCountCheckbox
        text: pluginApi?.tr("settings.show-peers") || "Show Peer Count"
        checked: settings?.showPeerCount !== false

        onCheckedChanged: {
          if (settings) {
            settings.showPeerCount = checked
          }
        }
      }

      NText {
        text: pluginApi?.tr("settings.show-peers-desc") || "Display connected device count"
        color: Color.mSecondary
        Layout.fillWidth: true
      }
    }

    Item { Layout.fillHeight: true }
  }
}
