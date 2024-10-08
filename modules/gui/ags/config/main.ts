
import Gdk from "types/@girs/gdk-3.0/gdk-3.0.js";
import brightness from "./brightness.ts";

const time = Variable("", {
    poll: [5000, 'date +"%H:%M"'],
});
const date = Variable("", {
    poll: [5000, 'date +"%A %d %B"'],
});

const audio = await Service.import('audio')
const mpris = await Service.import('mpris')
const marginHeight: number = Math.floor(Gdk.Screen.height() * 0.1);
const marginWidth: number = Math.floor(Gdk.Screen.width() * 0.025);

/** @param {import('types/service/mpris').MprisPlayer} player */
const Player = player => Widget.Button({
    onClicked: () => player.playPause(),
    child: Widget.Label().hook(player, label => {
        const { track_artists, track_title } = player;
        label.label = `${track_artists.join(', ')} - ${track_title}`;
    }),
});

const Bar = (monitor: number) => Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ['left', 'top', 'bottom'],
    layer: 'top',
    exclusivity: 'ignore',
    child: Widget.CenterBox({
        class_name: 'container',
        homogeneous: false,
        vertical: true,
        css: `min-width: ${Math.floor(Gdk.Screen.width() * 0.3)}px; padding: ${marginHeight}px ${marginWidth}px ${marginHeight}px ${marginWidth}px;`,
        startWidget:
            Widget.Box({
                homogeneous: false,
                vertical: true,
                hpack: 'fill',
                vpack: 'fill',
                class_name: "header_container",
                children: [
                    Widget.Box({
                        homogeneous: false,
                        vertical: true,
                        class_name: "date_container",
                        children: [
                            Widget.Label({ 
                                label: time.bind(),
                                class_name: "time",
                                css: 'font-size: 500%',
                            }),
                            Widget.Label({ 
                                label: date.bind(),
                                class_name: "date",
                                css: 'font-size: 150%',
                            }),
                        ]
                    }),
                    Widget.Box({
                        homogeneous: false,
                        vertical: true,
                        class_name: "searchbar_container",
                        children: [
                            Widget.Entry({
                                class_name: 'searchbar',
                                placeholder_text: 'Search',
                                visibility: true, // set to false for passwords
                                onAccept: ({ text }) => print(text),
                            })
                        ]
                    }),
                ]
            }),
        centerWidget: Widget.Box({
                vertical: true,
                css: `min-height: ${Math.floor(Gdk.Screen.height() * 0.3 - marginHeight * 2)}px`,
                children: [Widget.Label({label: " "})],
            }),
        endWidget: Widget.Box({
                homogeneous: false,
                vertical: false,
                hpack: 'fill',
                vpack: 'fill',
                class_name: "footer_container",
                children: [Widget.Slider({
                        vertical: true,
                        class_name: "brightness_slider",
                        drawValue: false,
                        hpack: 'start',
                        on_change: self => brightness.screen_value = self.value,
                        value: brightness.bind('screen_value'),
                    }),
                    Widget.Box({
                        class_name: "buttons_container",
                        homogeneous: true,
                        vertical: true,
                        spacing: 25,
                        hpack: 'fill',
                        hexpand: true,
                        children: [
                            Widget.Box({
                                class_name: "players",
                                children: mpris.bind('players').as(p => p.map(Player))
                            }),
                            Widget.Box({
                                class_name: "buttons_container_line_1",
                                homogeneous: true,
                                vertical: false,
                                spacing: 50,
                                children: [
                                    Widget.Button({
                                        class_name: "wifi_button",
                                        child: Widget.Icon({ icon: 'image-missing-symbolic' }),
                                        onClicked: () => print('hello'),
                                    }),
                                    Widget.Button({
                                        class_name: "bluetooth_button",
                                        child: Widget.Icon({ icon: 'bluetooth-active-symbolic' }),
                                        onClicked: () => print('hello'),
                                    })
                                ]
                            }),
                            Widget.Box({
                                class_name: "buttons_container_line_2",
                                homogeneous: true,
                                vertical: false,
                                spacing: 50,
                                children: [
                                    Widget.Button({
                                        class_name: "shutdown_button",
                                        child: Widget.Icon({ icon: 'system-shutdown-symbolic' }),
                                        onClicked: () => print('hello'),
                                    }),
                                    Widget.Button({
                                        class_name: "reboot_button",
                                        child: Widget.Icon({ icon: 'weather-clear-night-symbolic' }),
                                        onClicked: () => print('hello'),
                                    })
                                ]
                            }),
                        ]
                    }),
                    Widget.Slider({
                        class_name: "sound_slider",
                        drawValue: false,
                        vertical: true,
                        hpack: 'end',
                        onChange: ({ value }) => audio['speaker'].volume = value,
                        value: audio['speaker'].bind('volume'),
                    })
                ]
            })
    })
})

App.config({
    windows: [Bar(0)]
})

export { }

