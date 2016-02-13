/* GCompris - parachute.qml
 *
 * Copyright (C) 2015 Rajdeep Kaur <rajdeep51994@gmail.com>
 *
 * Authors:
 *   Bruno Coudoin <bruno.coudoin@gcompris.net> (GTK+ version)
 *   Rajdeep kaur<rajdeep51994@gmail.com> (Qt Quick port)
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

import QtQuick 2.1
import GCompris 1.0
import QtGraphicalEffects 1.0
import "../../core"
import "qrc:/gcompris/src/core/core.js" as Core
import "parachute.js" as Activity

ActivityBase {
    id: activity

    property real velocityX
    property real velocityY
    
    property string dataSetUrl: "qrc:/gcompris/src/activities/parachute/resource/"
    
    onStart: focus = true
    onStop: {}

    pageComponent: Image {

        id: background
        source: activity.dataSetUrl + "back.svg"
        fillMode: Image.PreserveAspectCrop
        sourceSize.width: parent.width
        anchors.fill: parent

        signal start
        signal stop

        Component.onCompleted: {
            activity.start.connect(start)
            activity.stop.connect(stop)
        }
        
        onStart: {  }
        onStop: { Activity.stop() }

        // Add here the QML items you need to access in javascript
        QtObject {
            id: items
            property Item main : activity.main
            property alias background: background
            property alias animationheli: animationheli
            property alias animationcloud: animationcloud
            property alias bar: bar
            property alias bonus: bonus
            property alias animationboat: animationboat
            property alias keyunable: keyunable
            property alias ok: ok
            property alias loop: loop
            property alias loopcloud: loopcloud
            property alias tuxX: tuxX
            property alias tux: tux
            property alias tuximage: tuximage
            property alias helimotion: helimotion

        }

        IntroMessage {
            id:message
            onIntroDone: {
                Activity.start(items)
            }

            intro: [
                qsTr("The red boat moves in the water from left to right."),
                qsTr("Penguin Tux falls off from the plane, to land on the boat safely. "),
                qsTr("The purpose of the game is to determine the exact time when"
                     + "he should fall off from the plane, in order to safely get to the boat. "),
                qsTr("Tux also carries a parachute, that lets him prevent free fall under gravity, that is dangerous."
                     +"Tux falls off when the player left clicks on the plane."),
                qsTr("His speed can be controlled by the player by pressing UP and DOWN arrow keys,"
                     + "such that Tux is saved from falling in water. "),
                qsTr("Help Tux save his life!")
            ]
            z: 20

            anchors {
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 5
                left: parent.left
                leftMargin: 5
            }
        }

        GCText {
            id: keyunable
            anchors.centerIn: parent
            fontSize: largeSize
            visible: false
            text: qsTr("Control fall speed with up and down arrow keys")
        }


        Item {
            id: helimotion
            width: (bar.level===1?background.width/6:bar.level===2?background.width/4:bar.level===3?background.width/11:bar.level===4?background.width/7:background.width/7)
            height: (bar.level===1?background.height/6:bar.level===2?background.height/4:bar.level===3?background.height/11:bar.level===4?background.height/7:background.height/7)
            x: -width
            Rectangle {
                id: forhover
                width: (bar.level===1?background.width/6:bar.level===2?background.width/4:bar.level===3?background.width/11:bar.level===4?background.width/7:background.width/7)
                height: (bar.level===1?background.height/6:bar.level===2?background.height/4:bar.level===3?background.height/11:bar.level===4?background.height/7:background.height/7)
                visible: false
                border.width: 7
                radius: 20
                border.color: "#A80000"
                color: "#500000"
            }
            Image {
                id: helicopter
                source: activity.dataSetUrl + "tuxplane.svg"
                width: (bar.level === 1?background.width/6:bar.level === 2?background.width/4:bar.level === 3?background.width/11:bar.level === 4?background.width/7:background.width/7)
                height: (bar.level === 1?background.height/6:bar.level === 2?background.height/4:bar.level === 3?background.height/11:bar.level === 4?background.height/7:background.height/7)
                MouseArea {
                    id:mousei
                    hoverEnabled: true
                    anchors.fill: parent
                    onEntered: {
                        forhover.visible = true
                    }
                    onExited: {
                        forhover.visible = false
                    }
                    onClicked: {
                        if(Activity.Oneclick === false) {
                            tuximage.visible=true
                            tux.y = helimotion.y
                            tuxX.stop()
                            /*     activity.audioEffects.play(activity.dataSetUrl+"youcannot.wav");
                            sound file is not supporting in linux please do remove it before the merge */
                            Activity.tuxImageStatus = 1
                            Activity.Oneclick = true;
                            velocityX = Activity.velocityX
                            velocityY = Activity.velocityY[bar.level-1]
                            tux.state = "Released"

                        }
                    }

                }
            }
            SequentialAnimation {
                id: loop
                loops: Animation.Infinite
                PropertyAnimation {
                    id: animationheli
                    target: helimotion
                    properties: "x"
                    from: -helimotion.width
                    to: background.width
                    duration: (bar.level === 1 ? 20000 : bar.level === 2 ? 16000 : bar.level === 3 ? 12000 : bar.level === 4 ? 10000 : 9000)
                    easing.type: Easing.Linear
                }
            }
        }


        Item {
            id: tux
            width: tuximage.width
            height: tuximage.height
            x: -helimotion.width
            Rectangle {
                id: tuximagehover
                width: tuximage.width
                height: tuximage.height
                visible: false
                border.width: 7
                radius: 20
                border.color: "#A80000"
                color: "#500000"
                opacity: 90
            }
            Image {
                id: tuximage
                source: activity.dataSetUrl + Activity.minitux
                visible: false
                MouseArea {
                    id: tuxmouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if(Activity.tuxImageStatus === 1) {
                            if(tuximagehover.visible === true) {
                                tuximagehover.visible = false
                            }

                            keyunable.visible = true
                            tuximage.source = activity.dataSetUrl + Activity.parachutetux
                            Activity.tuxImageStatus = 2

                        }
                    }
                    onEntered: {
                        if(Activity.tuxImageStatus === 1) {
                            tuximagehover.visible = true
                        }
                    }
                    onExited: {
                        tuximagehover.visible = false
                    }
                }
            }

            onYChanged: {
                console.log(tux.y)
                if( (tux.y > background.height/1.5)&& Activity.tuxImageStatus === 1 ) {
                    activity.audioEffects.play(activity.dataSetUrl + "bubble.wav" )
                    tux.state = "finished"
                    Activity.tuxImageStatus = 0
                    Activity.onLose()
                }

                if((tux.y>background.height/1.5 && Activity.tuxImageStatus === 2) && ((tux.x>boatmotion.x) && (tux.x<boatmotion.x+boatmotion.width))){
                    tux.state = "finished"
                    Activity.tuxImageStatus = 0
                    Activity.onWin()
                }

                else if((tux.y>background.height/1.5 && Activity.tuxImageStatus === 2) && ((tux.x<boatmotion.x)||(tux.x>boatmotion.x+boatmotion.width))){
                    activity.audioEffects.play(activity.dataSetUrl + "bubble.wav" )
                    tux.state = "finished"
                    Activity.tuxImageStatus = 0
                    Activity.onLose()
                }

            }

            SequentialAnimation {
                id: tuxX
                loops: Animation.Infinite
                PropertyAnimation {
                    target: tux
                    properties: "x"
                    from: -helimotion.width
                    to: background.width
                    duration: (bar.level === 1 ? 20000 : bar.level === 2 ? 16000 : bar.level === 3 ? 12000 : bar.level === 4 ? 10000 : 9000)
                }
            }

            states: [
                State{
                    name:"rest"
                    PropertyChanges {
                        target: tux
                        y:helimotion.y

                    }
                },

                State {
                    name: "UpPressed"
                    PropertyChanges {
                        target: tux
                        y:background.height/1.3
                        x:(tux.x + 2)
                    }

                },
                State {
                    name: "DownPressed"
                    PropertyChanges {
                        target: tux
                        y:(tux.y + 200)
                        x:(tux.x + 2)
                    }
                },
                State {
                    name: "Released"
                    PropertyChanges {
                        target: tux
                        y:(tux.y + 3)
                        x:(tux.x + 2)
                    }

                },
                State {
                    name: "finished"
                    PropertyChanges {
                        target: tux

                    }
                }

            ]

            Behavior on x {
                SmoothedAnimation { velocity:velocityX  }
            }
            Behavior on y {
                SmoothedAnimation { velocity:velocityY }
            }


        }

        Keys.onReleased: {
            if((Activity.tuxImageStatus === 1)||(Activity.tuxImageStatus ===2)) {
               tux.state = "Released"
               velocityY = Activity.velocityY[bar.level-1]
            }

        }

        Keys.onUpPressed: {
            if(Activity.tuxImageStatus === 2) {
                  tux.state = "Uppressed"
                  velocityY = velocityY/2
               }
        }

        Keys.onDownPressed: {
            if(Activity.tuxImageStatus === 2) {
                    tux.state = "Downpressed"
            }

        }



        Item {
            id: cloudmotion
            width: cloud.width
            height: height.height
            Image {
                id: cloud
                source: activity.dataSetUrl + "cloud.svg"
                y: background.height/7
            }
            SequentialAnimation {
                id:loopcloud
                loops: Animation.Infinite

                PropertyAnimation {
                    id: animationcloud
                    target: cloudmotion
                    properties: "x"
                    from: Math.random() > 0.2 ? background.width : -cloud.width
                    to: animationcloud.from === background.width ? -cloud.width : background.width
                    duration: (bar.level === 1 ? 19000 : bar.level === 2 ? 15000 : bar.level === 3 ? 11000 : bar.level === 4 ? 9000 : 9000)
                    easing.type: Easing.Linear
                }

                PropertyAnimation {
                    id: animationcloud1
                    target: cloudmotion
                    properties: "x"
                    from: background.width
                    to: -cloud.width
                    duration: (bar.level === 1 ? 19000 : bar.level === 2 ? 15000 : bar.level === 3 ? 11000 : bar.level === 4 ? 9000 : 9000)
                    easing.type: Easing.Linear
                }

                PropertyAnimation {
                    id: animationcloud2
                    target: cloudmotion
                    properties: "x"
                    from: -cloud.width
                    to: background.width
                    duration: (bar.level === 1 ? 19000 : bar.level === 2 ? 15000 : bar.level === 3 ? 11000 : bar.level === 4 ? 9000 : 9000)
                    easing.type: Easing.Linear
                }

                PropertyAnimation {
                    id: animationcloud3
                    target: cloudmotion
                    properties: "x"
                    from: background.width
                    to: -cloud.width
                    duration: (bar.level === 1 ? 19000 : bar.level === 2 ? 15000 : bar.level === 3 ? 11000 : bar.level === 4 ? 9000 : 9000)
                    easing.type: Easing.Linear
                }

                PropertyAnimation {
                    id: animationcloud4
                    target: cloudmotion
                    properties: "x"
                    from: -cloud.width
                    to: background.width
                    duration: (bar.level === 1 ? 19000 : bar.level === 2 ? 15000 : bar.level === 3 ? 11000 : bar.level === 4 ? 9000 : 9000)
                    easing.type: Easing.Linear
                }
            }
        }


        Item {
            id: boatmotion
            width: background.width/4
            height: background.height/4
            Image {
                id: boat
                source: activity.dataSetUrl + "fishingboat.svg"
                y: (bar.level === 1 ? background.height/1.4 : bar.level==2 ? background.height/1.4 : bar.level ===3 ? background.height/1.4:bar.level === 4?background.height/1.4:background.height/1.3 )
                width: (bar.level === 1 ? background.width/4 : bar.level==2 ? background.width/4.5 : bar.level ===3 ? background.width/5:bar.level === 4?background.width/5.1:background.width/5.1 )
                height: background.height/4

            }
            PropertyAnimation {
                id: animationboat
                target: boatmotion
                properties: "x"
                from: -boat.width
                to: background.width-2.5*boat.width
                duration: (bar.level === 1 ? 24000 : bar.level === 2 ? 20500 : bar.level === 3 ? 19000 : bar.level === 4 ? 17000 : 9000)
                easing.type: Easing.Linear
            }
        }

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
        }

        BarButton {
            id: ok
            source: "qrc:/gcompris/src/core/resource/bar_ok.svg";
            sourceSize.width: 75 * ApplicationInfo.ratio
            visible: false
            anchors.right: background.right
            onClicked: {
                Activity.loseflag = true
                Activity.nextLevel()
            }
        }

        Bonus {
            id: bonus
            onWin: ok.visible = true
        }

    }

}

