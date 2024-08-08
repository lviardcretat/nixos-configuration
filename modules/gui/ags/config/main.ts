
import brightness from "./brightness.ts";

const time = Variable("", {
    poll: [5000, 'date +"%H:%M"'],
});
const date = Variable("", {
    poll: [5000, 'date +"%A %d %B"'],
});

const audio = await Service.import('audio')
/** @param {'speaker' | 'microphone'} type */
const VolumeSlider = (type = 'speaker') => Widget.Slider({
    hexpand: true,
    drawValue: false,
    onChange: ({ value }) => audio[type].volume = value,
    value: audio[type].bind('volume'),
});

const Bar = (monitor: number) => Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ['left', 'top', 'bottom'],
    layer: 'top',
    exclusivity: 'ignore',
    child: Widget.Box({
        class_name: 'container',
        spacing: 8,
        homogeneous: false,
        vertical: true,
        children: [
            Widget.Box({
                spacing: 8,
                homogeneous: false,
                vertical: true,
                children: [
                    Widget.Label({ label: date.bind() }),
                    Widget.Label({ label: time.bind() }),
                ]
            }),
            Widget.Box({
                spacing: 8,
                homogeneous: false,
                vertical: false,
                children: [
                    Widget.Slider({
                        on_change: self => brightness.screen_value = self.value,
                        value: brightness.bind('screen_value'),
                    }),
                    Widget.Box({
                        spacing: 8,
                        homogeneous: true,
                        vertical: true,
                        children: [
                            Widget.Label({
                                label: 'some text to show',
                                justification: 'center'
                            }),
                            Widget.Label({
                                label: 'some text to show 2',
                                justification: 'center'
                            })
                        ]
                    }),
                    VolumeSlider('speaker'),
                ]
            })
        ]
    })
})

App.config({
    windows: [Bar(0)]
})
export { }

