import { Widget } from "astal/gtk3"
import { bind } from "astal"
import Network from "gi://AstalNetwork"

const wifi = Network.get_default().wifi!

export default function Wifi(): Widget.Button {
    return new Widget.Button(
        { 
            className: "wifi_button",
            onClicked: () => print('hello'),
        },
        wifi ?
        new Widget.Icon(
            { 
                tooltipText: bind(wifi, "ssid").as(String),
                className: 'wifi_icon',
                icon: bind(wifi, "iconName")
            }
        ) :
        new Widget.Icon(
            { 
                tooltipText: 'Wifi désactivé',
                className: 'wifi_icon',
                icon: 'network-wireless-offline-symbolic'
            }
        )
    )
}
