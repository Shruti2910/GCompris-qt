/* GCompris - intro_gravity.qml
*
* Copyright (C) 2015 Siddhesh suthar <siddhesh.it@gmail.com>
*
* Authors:
*   Bruno Coudoin <bruno.coudoin@gcompris.net> and Matilda Bernard (GTK+ version)
*   Siddhesh suthar <siddhesh.it@gmail.com> (Qt Quick port)
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation; either version 3 of the License, or
*   (at your option) any later version.
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with this program; if not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.2
import QtQuick.Controls 1.2
import GCompris 1.0

import "../../core"
import "intro_gravity.js" as Activity

ActivityBase {
    id: activity

    onStart: focus = true
    onStop: {}

    property int oldWidth: width
    onWidthChanged: {
        // Reposition planets and asteroids, same for height
        Activity.repositionObjectsOnWidthChanged(width / oldWidth)
        oldWidth = width
    }

    property int oldHeight: height
    onHeightChanged: {
        // Reposition planets and asteroids, same for height
        Activity.repositionObjectsOnHeightChanged(height / oldHeight)
        oldHeight = height
    }


    pageComponent: Image {
        id: background
        anchors.fill: parent
        source: Activity.url+"drawing.svg"
        sourceSize.width: parent.width
        fillMode: Image.PreserveAspectCrop

        signal start
        signal stop

        Component.onCompleted: {
            activity.start.connect(start)
            activity.stop.connect(stop)
        }

        // Add here the QML items you need to access in javascript
        QtObject {
            id: items
            property Item main: activity.main
            property alias background: background
            property alias bar: bar
            property alias bonus: bonus
            property alias planetLeft: planetLeft
            property alias planetRight: planetRight
            property alias scaleLeft: sliderLeft.value
            property alias scaleRight: sliderRight.value
            property alias spaceship: spaceship
            property alias shuttle: shuttle
            property alias shuttleMotion: shuttleMotion
            property alias timer: timer
            property alias arrow: arrow
            property alias asteroidCreation: asteroidCreation
            property GCAudio audioEffects: activity.audioEffects

        }

        onStart: Activity.start(items,message)
        onStop: Activity.stop()

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level | reload }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
            onReloadClicked: Activity.initLevel()
         }

        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextLevel)
        }

        Message {
            id: message
            anchors {
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 5
                left: parent.left
                leftMargin: 5
            }
        }

        Image {
            id: planetLeft
            source: Activity.url + "saturn.svg"
            x: 70
            y: parent.height/2 - 80
            Behavior on scale{
                NumberAnimation{ duration: 100 }
            }
        }

        Slider {
            id: sliderLeft
            x: 20
            y: background.height/2 - sliderLeft.height
            width: 10
            height: planetLeft.height
            activeFocusOnPress: true
            orientation: Qt.Vertical
            value: 1.5
            maximumValue: 2.0
            minimumValue: 1.0
            onValueChanged:{
                planetLeft.scale = value
            }

        }

        Image {
            id: planetRight
            source: Activity.url + "neptune.svg"
            x: parent.width - 130
            y: parent.height/2 - 80
            Behavior on scale{
                NumberAnimation{ duration: 100 }
            }
        }


        Slider{
            id: sliderRight
            x: planetRight.x + planetRight.width + 20
            y: background.height/2 - sliderRight.height
            width: 10
            height: planetRight.height
            activeFocusOnPress: true
            orientation: Qt.Vertical
            value: 1.5
            maximumValue: 2.0
            minimumValue: 1.0
            onValueChanged:{
                planetRight.scale = value
            }
        }

        Image {
            id: spaceship
            source: Activity.url +"tux_spaceship.png"
            x: parent.width/2
            y: parent.height/2 - height +10

        }

        //for drawing the line to show force magnitude and direction
        Image {
            id: arrow
            x: spaceship.x - spaceship.width ; y: spaceship.y -80
            width: parent.width/30; height: parent.height/60
            scale : 1
            source: Activity.url +"arrowright.svg"
            Behavior on scale {
                NumberAnimation{ duration: 48 }
            }
        }

        Image {
            id: shuttle
            x:  background.width/2 - shuttle.width - spaceship.width -10

            y: background.height + shuttle.height
            source: Activity.url + "space_shuttle.svg"
            z: 10

            NumberAnimation {
                id: shuttleMotion
                target: shuttle
                property: "y"
                to: 0 - shuttle.height
                duration: 40000 / (Activity.currentLevel+1)
            }
        }

        Timer {
            id: timer
            interval: 16
            running: false
            repeat: true
            onTriggered: {
                Activity.movespaceship()
                Activity.handleCollisionWithAsteroid()
            }
        }

        Timer {
            id: asteroidCreation
            running: false
            repeat: true
            interval: 10200 - (bar.level * 200)
            onTriggered: Activity.createAsteroid()
        }

    }
}
