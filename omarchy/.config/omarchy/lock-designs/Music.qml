// Customized copy of the Music design, merged with Dayline's day-progress line.
// Edit it here or with:
// omarchy-shell lock editDesign my-music
import QtQuick
import QtQuick.Effects
import Quickshell.Services.Mpris
import qs.Commons
import qs.Commons as Commons
import "../plugins/io.github.sirjul1337.lock-explorer/designs"

DesignBase {
	id: lock
	inputItem: field.input

	readonly property var players: Mpris.players ? Mpris.players.values : []
	readonly property var player: {
		var withTitle = null
		for (var i = 0; i < players.length; i++) {
			var p = players[i]
			if (!p || !p.trackTitle) continue
			if (p.playbackState === MprisPlaybackState.Playing) return p
			if (!withTitle) withTitle = p
		}
		return withTitle
	}
	readonly property bool hasMedia: player !== null
	readonly property bool playing: player && player.playbackState === MprisPlaybackState.Playing
	readonly property string title: player ? player.trackTitle : ""
	readonly property string artist: player ? (player.trackArtist || "") : ""
	readonly property string album: player ? (player.trackAlbum || "") : ""
	readonly property string artUrl: player ? (player.trackArtUrl || "") : ""
	readonly property string identity: player ? (player.identity || "") : ""

	readonly property int lineWidth: 640
	readonly property real dayFraction: (now.getHours() * 3600 + now.getMinutes() * 60 + now.getSeconds()) / 86400

	Wallpaper { anchors.fill: parent; lock: lock; blur: 1.0; dim: 0.25; vignette: false }

	Image {
		id: art
		anchors.fill: parent
		source: lock.artUrl
		visible: false
		fillMode: Image.PreserveAspectCrop
		asynchronous: true
		sourceSize.width: 512
		sourceSize.height: 512
	}
	MultiEffect {
		anchors.fill: art
		source: art
		visible: lock.hasMedia && art.status === Image.Ready
		blurEnabled: true
		blur: 1.0
		blurMax: 96
		blurMultiplier: 2
		brightness: -0.35
		saturation: 0.2
	}

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onClicked: { lock.wakeRequested(); lock.forcePasswordFocus() }
		onPositionChanged: lock.wakeRequested()
	}

	Text {
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.margins: 56
		text: Qt.formatTime(lock.now, "HH:mm")
		color: Commons.Color.lock.text
		font.family: Style.font.family
		font.pixelSize: Math.round(Style.font.baseSize * 4)
		font.weight: Font.DemiBold
	}
	Text {
		anchors.top: parent.top
		anchors.right: parent.right
		anchors.margins: 56
		text: Qt.formatDate(lock.now, "dddd d MMMM")
		color: lock.withAlpha(Commons.Color.lock.text, 0.7)
		font.family: Style.font.family
		font.pixelSize: Style.font.title
		font.letterSpacing: 2
	}

	Column {
		anchors.centerIn: parent
		spacing: 30

		Rectangle {
			anchors.horizontalCenter: parent.horizontalCenter
			width: nowPlaying.implicitWidth + 60
			height: nowPlaying.implicitHeight + 48
			radius: 22
			color: lock.withAlpha(Commons.Color.lock.background, 0.7)
			border.width: 1
			border.color: lock.withAlpha(Commons.Color.lock.text, 0.12)
			layer.enabled: true
			layer.effect: MultiEffect { shadowEnabled: true; shadowColor: Qt.rgba(0, 0, 0, 0.5); shadowBlur: 1.0; shadowVerticalOffset: 10 }

			Row {
				id: nowPlaying
				anchors.centerIn: parent
				spacing: 26

				Rectangle {
					width: 150; height: 150; radius: 14
					color: lock.withAlpha(Commons.Color.lock.text, 0.08)
					clip: true
					anchors.verticalCenter: parent.verticalCenter
					Image {
						anchors.fill: parent
						source: lock.artUrl
						fillMode: Image.PreserveAspectCrop
						asynchronous: true
						visible: lock.hasMedia && status === Image.Ready
					}
					Text {
						anchors.centerIn: parent
						visible: !(lock.hasMedia && lock.artUrl.length > 0)
						text: "󰎆"
						color: lock.withAlpha(Commons.Color.lock.text, 0.4)
						font.family: Style.font.family
						font.pixelSize: Math.round(Style.font.baseSize * 4)
					}
				}

				Column {
					anchors.verticalCenter: parent.verticalCenter
					spacing: 6
					width: 380
					Text {
						text: lock.hasMedia ? (lock.playing ? "󰐊 NOW PLAYING" : "󰏤 PAUSED") : "󰝛 NOTHING PLAYING"
						color: Commons.Color.lock.borderActive
						font.family: Style.font.family
						font.pixelSize: Style.font.caption
						font.letterSpacing: 3
					}
					Text {
						width: parent.width
						text: lock.hasMedia ? lock.title : lock.greeting() + ", " + lock.userName
						color: Commons.Color.lock.text
						font.family: Style.font.family
						font.pixelSize: Style.font.display
						font.weight: Font.DemiBold
						elide: Text.ElideRight
						maximumLineCount: 2
						wrapMode: Text.Wrap
					}
					Text {
						width: parent.width
						text: lock.hasMedia ? lock.artist + (lock.album ? " · " + lock.album : "") : "Start something and it shows up here"
						color: lock.withAlpha(Commons.Color.lock.text, 0.7)
						font.family: Style.font.family
						font.pixelSize: Style.font.subtitle
						elide: Text.ElideRight
					}
					Text {
						visible: lock.hasMedia && lock.identity.length > 0
						text: lock.identity
						color: lock.withAlpha(Commons.Color.lock.text, 0.45)
						font.family: Style.font.family
						font.pixelSize: Style.font.caption
					}
				}
			}
		}

				// --- Day progress line, taken from Dayline design ---
		Item {
			anchors.horizontalCenter: parent.horizontalCenter
			width: lock.lineWidth
			height: 64

			Rectangle {
				id: track
				anchors.top: parent.top
				width: parent.width
				height: 6
				radius: 3
				color: lock.withAlpha(Commons.Color.lock.text, 0.2)
				Rectangle {
					width: parent.width * lock.dayFraction
					height: parent.height
					radius: 3
					color: Commons.Color.lock.borderActive
				}
				Rectangle {
					x: parent.width * lock.dayFraction - 7
					y: -4
					width: 14; height: 14; radius: 7
					color: Commons.Color.lock.text
					border.width: 3
					border.color: Commons.Color.lock.borderActive
				}
			}

			Item {
				id: hourLabels
				anchors.top: track.bottom
				anchors.topMargin: 8
				width: parent.width
				height: 16

				Repeater {
					model: ["00", "06", "12", "18", "24"]
					Text {
						required property int index
						required property string modelData
						text: modelData
						color: lock.withAlpha(Commons.Color.lock.text, 0.5)
						font.family: Style.font.family
						font.pixelSize: Style.font.caption
						x: index === 0 ? 0
							: index === 4 ? hourLabels.width - width
							: (hourLabels.width * index / 4) - width / 2
					}
				}
			}

			Text {
				anchors.top: hourLabels.bottom
				anchors.topMargin: 12
				anchors.horizontalCenter: parent.horizontalCenter
				text: Math.round(lock.dayFraction * 100) + "% of the day"
				color: lock.withAlpha(Commons.Color.lock.text, 0.7)
				font.family: Style.font.family
				font.pixelSize: Style.font.subtitle
				font.letterSpacing: 1
			}
		}
		// --- end day progress line ---

		PasswordField {
			id: field
			lock: lock
			anchors.horizontalCenter: parent.horizontalCenter
			width: 400
			height: 54
			radius: 27
			placeholder: "Password"
			color: lock.withAlpha(Commons.Color.lock.background, 0.7)
		}
	}
}