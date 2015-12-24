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
import GCompris 1.0
import QtQuick.Controls 1.0

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

        Image{
            id:bambo1
            source: url + "bambo.svg"
            x:background.width/14+2*circleContent2.width
            y:background.height/2.5
            width:background.width/80
            height:background.height/2
            rotation:90

        }

        Item{
            id:caption1
            GCText{
               id:caption1text
               text:Activity.caption[bar.level-1][0]
               visible:Activity.caption[bar.level-1][0] === "?" ? false : true
               x:background.width/14+2*circleContent2.width
               y:background.height/1.5
            }
            Image{
               id:caption1image
               source:url+"questionmark.svg"
               visible:Activity.caption[bar.level-1][0] === "?" ? true : false
               x:background.width/14+2*circleContent2.width
               y:background.height/1.5

            }

        }

        Image{
            id:bambo2
            source:url + "bambo.svg"
            x:background.width/5.5
            y:background.height/5.5
            height:background.height/1.8
            width:background.width/80
            rotation:40

        }

        Item{
            id:caption2
            x:background.width/7
            y:background.height/2.5
            GCText{
               text:Activity.caption[bar.level-1][1]
               visible:Activity.caption[bar.level-1][1] === "?" ? false : true


            }
            Image{
               source:url+"questionmark.svg"
               visible:Activity.caption[bar.level-1][1] === "?" ? true : false
            }

        }
        Image{
            id:bambo3
            source:url+ "bambo.svg"
            height:background.height/2
            width:background.width/60
            x:background.width/14+background.width/4+(circleContent2.width)
            y:background.height/5
            rotation:150
        }

        Item{
            id:caption3
            y:background.height/2.5
            x:background.width/14+background.width/4+(1.3*circleContent2.width)
            GCText{
               text:Activity.caption[bar.level-1][2]
               visible:Activity.caption[bar.level-1][2] === "?" ? false : true



            }
            Image{
               source:url+"questionmark.svg"
               visible:Activity.caption[bar.level-1][2] === "?" ? true : false
               anchors.top:bambo3.bottom
               anchors.rightMargin: 7

            }

        }

        Item {
            id:circleContent1
            x:background.width/3.6
            y:background.height/10
            width:background.width/9
            height:background.width/9
            Rectangle{
                id:circlef
                width:parent.width
                height:parent.height
                radius:parent.width/2
                border.color:"black"
                border.width:5
                Image{
                    id:pic1
                    source:url+ Activity.CirleContent[items.bar.level-1][0]
                    width:parent.width
                    height:parent.height
                    anchors{
                        horizontalCenter:parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                }

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
                Rectangle{
                    id:circlef1
                    width:parent.width
                    height:parent.height
                    border.color:"black"
                    radius:parent.width/2
                    border.width: 5
                    Image{
                        id:pic2
                        source:url+Activity.CirleContent[items.bar.level-1][1]
                        width:parent.width
                        height:parent.height
                        anchors{
                            horizontalCenter:parent.horizontalCenter
                            verticalCenter: parent.verticalCenter
                        }

                    }
                }
            }


            Item {
                id:circleContent3
                width:background.width/9
                height:background.width/9
                Rectangle{
                    id:cirlef2
                    width:parent.width
                    height:parent.height
                    radius:parent.width/2
                    border.color:"black"
                    border.width: 5
                    Image{
                        id:pic3
                        source:url+Activity.CirleContent[items.bar.level-1][2]
                        width:parent.width
                        height:parent.height
                        anchors{
                            horizontalCenter:parent.horizontalCenter
                            verticalCenter: parent.verticalCenter
                        }

                    }

                }
            }
        }

        Grid {
            columns: 1
            rowSpacing:background.width/10
            x:background.width/1.5
            y:background.height/14
            Button {
                id:button1
                style: GCButtonStyle {}
                width:background.width/5
                height:background.height/6
                text:Activity.Options[items.bar.level-1][0]
                onClicked:{
                    if(button1.text === Activity.answer[bar.level-1]) {
                        bonus.good("lion")
                    }

                }

            }
            Button {
                id:button2
                style: GCButtonStyle {}
                width:background.width/5
                height:background.height/6
                text:Activity.Options[items.bar.level-1][1]
                onClicked:{
                    if(button2.text === Activity.answer[bar.level-1]) {
                        bonus.good("lion")
                    }

                }

            }
            Button {
                id:button3
                style: GCButtonStyle {}
                width:background.width/5
                height:background.height/6
                text:Activity.Options[items.bar.level-1][2]
                onClicked:{
                    if(button3.text === Activity.answer[bar.level-1]) {
                        bonus.good("lion")
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
