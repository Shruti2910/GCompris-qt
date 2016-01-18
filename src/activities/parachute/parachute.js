/* GCompris - parachute.js
 *
 *   Copyright (C) 2015 Rajdeep Kaur <rajdeep1994@gmail.com>
 *
 *    Authors:
 *    Bruno Coudoin <bruno.coudoin@gcompris.net> (GTK+ version)
 *    Rajdeep kaur <rajdeep51994@gmail.com> (Qt Quick port)
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

.pragma library
.import QtQuick 2.0 as Quick
.import GCompris 1.0 as GCompris 
.import "qrc:/gcompris/src/core/core.js" as Core


var currentLevel = 0
var numberOfLevel = 4
var items
var checkPressed = false
var uppressed
var downpressed
var Oneclick
var winlose
var minitux="minitux.svg"
var parachutetux="parachute.svg"
var tuxImageStatus =1

function start(items_) {
    items = items_
    currentLevel = 0

    initLevel()
}

function stop() {
    items.loop.stop()
    items.loopcloud.restart()
    items.animationboat.stop()
}

function initLevel() {
    items.bar.level = currentLevel + 1
    checkPressed = false
    winlose = false
    Oneclick = false
    tuxImageStatus = 1
    items.ok.visible = false
    items.loop.restart()
    items.tuxX.restart()
    items.loopcloud.restart()
    items.animationboat.restart()

}

function onLose(){
   checkPressed =false
   winlose = false
   Oneclick = false
   tuxImageStatus = 1
   items.loop.stop()
   items.loopcloud.restart()
   items.animationboat.stop()
   items.tuxX.stop()
   items.tuxY.stop()
   items.tuxXWithY.stop()
   items.tux.visible = false

    items.loop.restart()
    items.tuxX.restart()
    items.loopcloud.restart()
    items.animationboat.restart()

}

function processPressedKey(event) {
    switch(event.key) {
    case Qt.Key_Up : event.accepted = true;
          items.tux.state = "Upressed"
          break;
    case Qt.Key_Down : event.accepted = true;
           items.tux.state = "Downpressed"
           break;
    }


}

function processReleasedKey(event) {
   switch(event.key) {
    case Qt.Key_Up : event.accepted = true;
         items.tux.state ="relesed";
         break;
    case Qt.Key_Down : event.accepted = true;
        items.tux.state = "relesed"
        break;
    }

}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel ) {
        currentLevel = 0
    }
    items.keyunable.visible=false
    items.ok.visible = false
    winlose = false
    Oneclick = false
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1
    }
    items.keyunable.visible=false
    initLevel();
}

