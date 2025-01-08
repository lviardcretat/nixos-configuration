import { App, Astal, Gdk, Widget } from "astal/gtk3"
import { bind, Variable } from "astal"

const time = bind(Variable("").poll(5000, 'date +"%H:%M"'));
const date = bind(Variable("").poll(5000, 'date +"%A %d %B"'));
const marginHeight: number = Math.floor(Gdk.Screen.height() * 0.1);
const marginWidth: number = Math.floor(Gdk.Screen.width() * 0.025);

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
            onDestroy(self) {
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
                    )
                ),
                centerWidget: new Widget.Box(),
                endWidget: new Widget.Box()
            }
        ),
    )
}
