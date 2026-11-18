import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.workspaces"

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }
    return null
  }

  function workspaceIds() {
    var values = Hyprland.workspaces.values
    if (root.vertical) {
      var ids = []
      var focusedId = Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1
      for (var i = 0; i < values.length; i++) {
        var w = values[i]
        if (w && w.id > 0 && w.id <= 10) {
          if (w.id === focusedId || (w.toplevels && w.toplevels.values.length > 0)) {
            if (ids.indexOf(w.id) === -1) ids.push(w.id)
          }
        }
      }
      if (ids.indexOf(focusedId) === -1) ids.push(focusedId)
      if (ids.length === 0) ids = [1]
      ids.sort(function(left, right) { return left - right })
      return ids
    }

    var ids = [1, 2, 3, 4, 5]
    for (var i = 0; i < values.length; i++) {
      var id = values[i].id
      if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
    }

    ids.sort(function(left, right) { return left - right })
    return ids
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  implicitWidth: root.vertical ? root.barSize : grid.implicitWidth + Style.space(24)
  implicitHeight: root.vertical ? grid.implicitHeight + Style.space(8) : root.barSize

  Behavior on implicitHeight {
    NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
  }

  GridLayout {
    id: grid
    anchors.centerIn: parent
    columns: root.vertical ? 1 : root.workspaceIds().length
    columnSpacing: root.vertical ? 0 : Style.space(5)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspaceIds()

      WidgetButton {
        required property int modelData

        readonly property var workspace: root.workspaceById(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData

        bar: root.bar
        text: focused ? "\uDB85\uDCFB" : (modelData === 10 ? "0" : String(modelData))
        opacity: occupied || focused ? 1.0 : 0.45
        horizontalMargin: root.vertical ? 4 : 8
        verticalPadding: root.vertical ? 4 : 6
        fixedWidth: root.vertical ? root.barSize : Style.space(26)
        fixedHeight: root.vertical ? Style.space(22) : root.barSize
        onPressed: function() { root.focusWorkspace(modelData) }
      }
    }
  }
}
