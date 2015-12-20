/* GCompris - family.qml
 *
 * Copyright (C) 2015 RAJDEEP KAUR <rajdeep51994@gmail.com>
 *
 * Authors:
 *   RAJDEEP KAUR <rajdeep51994@gmail.com> (Qt Quick port)
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

import "../../core"
import "family.js" as Activity

ActivityBase {
    id: activity
    property string url : "qrc:/gcompris/src/activities/family/resource/"
    onStart: focus = true
    onStop: {}

    pageComponent: Image  {
        id: background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/gcompris/src/activities/family/resource/background.svg"
        sourceSize.width: parent.width
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
        }

        onStart: { Activity.start(items) }
        onStop: { Activity.stop() }



        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        Item {
            id:circleContent1
            x:background.width/4
            y:background.height/10
            width:background.width/9
            height:background.width/9
            Image{
                id:pic1
                source:url+ Activity.CirleContent[items.bar.level-1][0]
                anchors.fill:parent
            }
        }


        Grid {
            columns:2
            columnSpacing:background.width/4
            x:background.width/14
            y:background.height/1.8
            Item {
                id:circleContent2
                width:background.width/9
                height:background.width/9
                Image{
                    id:pic2
                    source:url+Activity.CirleContent[items.bar.level-1][1]
                    anchors.fill:parent
                }
            }
            Item {
                id:circleContent3
                width:background.width/9
                height:background.width/9
                Image{
                    id:pic3
                    source:url+Activity.CirleContent[items.bar.level-1][2]
                    anchors.fill:parent
                }
            }
        }



        Grid{
            columns: 1
            rowSpacing:background.width/10
            x:background.width/1.5
            y:background.height/14
            Rectangle{
                id : option1
                color:"#00BFFF"
                width:background.width/5
                height:background.height/6
                radius:10
                border.color: "black"
                border.width: 5
                GCText {
                    id:text1
                    color:"black"
                    text:Activity.Options[0]
                    fontSize: largeSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }

                }

                MouseArea{
                    id : optionClick1
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                         option1.color = "#4682B4"
                    }
                    onExited: {
                         option1.color = "#00BFFF"
                    }
                    onClicked: {
                        if(text1.text === Activity.answer[0])
                        {
                            bonus.good("lion");

                        }

                    }
                }

            }

            Rectangle{
                id: option2
                color:"#00BFFF"
                width:background.width/5
                height:background.height/6
                radius:10
                border.color: "black"
                border.width: 5
                GCText{
                    id:text2
                    color:"black"
                    text:Activity.Options[1]
                    fontSize: largeSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }

                    MouseArea{
                        id : optionClick2
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                             option2.color = "#4682B4"
                        }
                        onExited: {
                             option2.color = "#00BFFF"
                        }
                        onClicked: {

                        }
                    }


                }


            }

            Rectangle{
                id: option3
                color:"#00BFFF"
                width:background.width/5
                height:background.height/6
                radius:10
                border.color: "black"
                border.width: 5
                GCText{
                    id:text3
                    color:"black"
                    text:Activity.Options[2]
                    fontSize: largeSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }

                    MouseArea{
                        id : optionClick3
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                             option3.color = "#4682B4"
                        }
                        onExited: {
                             option3.color = "#00BFFF"
                        }
                        onClicked: {

                        }
                    }

                }

            }


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

        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextLevel)
        }
    }

}
