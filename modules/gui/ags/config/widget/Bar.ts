import { App, Astal, Gdk, Widget } from "astal/gtk3"
import { bind, Variable } from "astal"
import MprisPlayers from "./MediaPlayer";
import Wp from "gi://AstalWp"
import Wifi from "./Wifi";

const time = bind(Variable("").poll(5000, 'date +"%H:%M"'));
const date = bind(Variable("").poll(5000, 'date +"%A %d %B"'));
const marginHeight: number = Math.floor(Gdk.Screen.height() * 0.1);
const marginWidth: number = Math.floor(Gdk.Screen.width() * 0.025);
const speaker = Wp.get_default()?.audio.defaultSpeaker!


export default function MainWindow(gdkmonitor: Gdk.Monitor): Widget.Window {
    return new Widget.Window(
        {
            className: "MainWindow",
            gdkmonitor: gdkmonitor,
            exclusivity: Astal.Exclusivity.EXCLUSIVE,
            anchor: Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM,
            application: App,
            keymode: Astal.Keymode.ON_DEMAND,
            visible: true,
            onDestroy(self: any) {
                self.hide()
                return true
            },
        },
        new Widget.CenterBox(
            {
                className: 'container',
                homogeneous: false,
                vertical: true,
                css: `min-width: ${Math.floor(Gdk.Screen.width() * 0.3)}px; padding: ${marginHeight}px ${marginWidth}px ${marginHeight}px ${marginWidth}px;`,
                startWidget: new Widget.Box(
                    {
                        homogeneous: false,
                        vertical: true,
                        className: "header_container",
                    },
                    new Widget.Box(
                        {
                            homogeneous: false,
                            vertical: true,
                            className: "date_container",
                        },
                        new Widget.Label(
                            {
                                label: time,
                                className: "time",
                                css: 'font-size: 500%',
                            }
                        ),
                        new Widget.Label(
                            {
                                label: date,
                                className: "date",
                                css: 'font-size: 150%',
                            }
                        )
                    ),
                    new Widget.Box(
                        {
                            homogeneous: false,
                            vertical: true,
                            className: "searchbar_container"
                        },
                        new Widget.Entry(
                            {
                                className: 'searchbar',
                                placeholderText: 'Search',
                                visibility: true,
                                // onAccept: ({ text }) => print(text),
                            }
                        )
                    ),
                ),
                centerWidget: new Widget.Box(
                    {
                        vertical: true,
                        css: `min-height: ${Math.floor(Gdk.Screen.height() * 0.3 - marginHeight * 2)}px`
                    },
                    new Widget.Label({ label: " " }),
                ),
                endWidget: new Widget.Box(
                    {
                        homogeneous: false,
                        vertical: false,
                        className: "footer_container",
                    },
                    new Widget.Slider(
                        {
                            vertical: true,
                            className: "brightness_slider",
                            drawValue: false,
                            inverted: true,
                            tooltipText: "Luminosité",
                        }
                    ),
                    new Widget.Box(
                        {
                            className: "buttons_container",
                            homogeneous: true,
                            vertical: true,
                            spacing: 25,
                            hexpand: true,
                        },
                        MprisPlayers(),
                        new Widget.Box(
                            {
                                className: "buttons_container_line_1",
                                homogeneous: true,
                                vertical: false,
                                spacing: 50,
                            },
                            Wifi(),
                            new Widget.Button(
                                {
                                    className: "bluetooth_button",
                                    onClicked: () => print('hello'),
                                },
                                new Widget.Icon({ icon: 'image-missing-symbolic' })
                            )
                        ),
                        new Widget.Box(
                            {
                                className: "buttons_container_line_2",
                                homogeneous: true,
                                vertical: false,
                                spacing: 50,
                            },
                            new Widget.Button(
                                {
                                    className: "shutdown_button",
                                    onClicked: () => print('hello'),
                                },
                                new Widget.Icon({ icon: 'image-missing-symbolic' })
                            ),
                            new Widget.Button(
                                {
                                    className: "reboot_button",
                                    onClicked: () => print('hello'),
                                },
                                new Widget.Icon({ icon: 'image-missing-symbolic' })
                            ),
                        ),
                    ),
                    new Widget.Slider({
                        className: "sound_slider",
                        drawValue: false,
                        vertical: true,
                        tooltipText: "Volume",
                        inverted: true,
                        value: bind(speaker, "volume"),
                        onDragged: ({ value }) => speaker.volume = value
                    })
                )
            }
        ),
    )
}
