/* GCompris - family.js
 *
 * Copyright (C) 2015 RAJDEEP KAUR <rajdeep51994@gmail.com>
 *
 * Authors:
 *   "RAJDEEP KAUR" <rajdeep51994@gmail.com> (Qt Quick port)
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

var currentLevel = 0
var numberOfLevel = 13
var items

var CirleContent = [  [ "man1.svg","girl1.svg","grandmother.svg"] ,
                      [ "grandpa.svg","girl2.svg","man1.svg" ],
                      [ "girl3.svg","man1.svg","man2.svg"],
                      [ "lady.svg","boy1.svg","lady1.svg"],
                      [ "lady.svg","boy1.svg","girl2.svg"],
                      [ "man1.svg","man2.svg","boy1.svg"],
                      [ "girl3.svg","man1.svg","man2.svg"],
                      [ "grandmother.svg","man1.svg","boy1.svg"],
                      [ "lady.svg","girl1.svg","grandpa.svg"] ,
                      [ "man1.svg","lady1.svg","grandmother.svg"],
                      [ "girl2.svg","man2.svg","grandpa.svg"],
                      [ "girl3.svg","man1.svg","girl2.svg"],
                      [ "man2.svg","girl3.svg","man1.svg"],
] ;
var Options = [[ "Grand Mother","Grand Father","Father" ],
               [ "Grand Mother", "Mother", "Grand Father"],
               [ "Uncle","Aunty","father"],
               [ "Mother","Aunty","GrandMother"],
               [ "Brother","Sister","Cousin"],
               [ "Daughter","Son","Newphew"],
               [ "Newphew","Niece","Daughter"],
               [ "Grand Son", "Son","Son In Law"],
               [ "Grand Daughter","Daughter","Daughter In Law"],
               [ "Mother","Mother in law","Aunty"],
               [ "Father", "Father in Law", "Uncle" ],
               [ "Sister","Cousin","Sister in Law"],
               [ "Brother","Brother in law","Cousin"]
]
var answer = ["Grand Mother","Grand Father","Uncle","Aunty","Cousin","Newphew","Niece","Grand Son","Grand Daughter","Mother in law","Father in Law","Sister in Law","Brother in law"];

var caption = [ ["?","Father","Mother"],
                ["Father","?","Son"],
                ["Brother","Daughter","?"],
                ["Mother","?","Sister"],
                ["?","Mother","Niece"],
                ["Son","Brother","?"],
                ["Brother","?","Father"],
                ["Son","Son","?"],
                ["?","Mother","Father"],
                ["Mother","Husband","?"],
                ["Father","Wife","?"],
                ["?","Wife","Sister"],
                ["?","Husband","Brother"]
        ]



function start(items_) {
    items = items_
    currentLevel = 0

    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1
}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel ) {
        currentLevel = 0
    }
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1
    }
    initLevel();
}
