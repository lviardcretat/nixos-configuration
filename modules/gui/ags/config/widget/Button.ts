import { Widget } from "astal/gtk3"

function MyButton(): Widget.Button {
    return new Widget.Button(
        { onClicked: "echo hello" },
        new Widget.Label({ label: "Click me!" }),
    )
}