---
layout: post
title: BPM 2 Ms Calculator
date: 2018-01-08T20:22:17.000Z
categories: code
synopsis: a simple bpm to ms calculator
last-modified-date: '2021-06-12T16:39:45+01:00'

---

<script>
/*
  BPM to MS
*/
var noteNames = [
  ["maxima", "dottedmaxima", 8],
  ["long", "dottedlong", 4],
  ["breve", "dottedbreve", 2],
  ["semibreve", "dottedsemibreve", 1],
  ["minim", "dottedminim", .5],
  ["crotchet", "dottedcrotchet", .25],
  ["quaver", "dottedquaver", .125],
  ["squaver", "dottedsquaver", .0625],
  ["dsquaver", "dotteddsquaver", .03125],
  ["hdsquaver", "dottedhdsquaver", .015625],
  ["shdsquaver", "dottedshdsquaver", .0078125],
  ["dshdsquaver", "dotteddshdsquaver", .00390625]
];
function bpmFromSlider() {
  //it was a slider, now it's a textbox.
  var bpm = parseInt(document.getElementById("bpmSlider").value);
   if(!(typeof bpm==='number' && bpm >0 )) {
     bpm=9999999999; // a big enough number to make all of the calculated table values zero
     document.getElementById("bpmSlider").classList.add("entryError");

   }
   else {
     document.getElementById("bpmSlider").classList.remove("entryError");
   }
  // document.getElementById("bpm").value = bpm;250
  for (var i = 0; i < noteNames.length; i++) {

    // TODO: while loop that checks
    //    typeof = number AND is positive and not zero.
    //      throw inline error if not
    //    ensure length of bpm is not greater than 7 (123.456)
    var elementID = "\"" + noteNames[i][0] + "\"";
    var dottedelementID = "\"" + noteNames[i][1] + "\"";
    document.getElementById(noteNames[i][0]).innerHTML = ((60/bpm) *noteNames[i][2]* 4000).toFixed(3);
    document.getElementById(noteNames[i][1]).innerHTML = ((60/bpm) *noteNames[i][2]* 6000).toFixed(3); //dotted noted = 1.5 length of undotted
  }
}

</script>

## BPM to milisecond calculator

The below table displays the note lengths for a given BPM (beats per minute). The system will not return note lengths for non-numeric values, or negative numbers

<input id="bpmSlider" placeholder="BPM" value="120" onchange="bpmFromSlider();" onkeypress="this.onchange();" onpaste="this.onchange();" oninput="this.onchange();">

<table id="noteTable">
  <tbody>
    <thead>
      <th>Note Name</th>
      <th>Note Value</th>
      <th>Note duration (ms)</th>
      <th>Dotted note duration (ms)</th>
    </thead>
    <tr>
      <td>Maxima</td>
      <td>8</td>
      <td id="maxima"></td>
      <td id="dottedmaxima"></td>
    </tr>
    <tr>
      <td>Long</td>
      <td>4</td>
      <td id="long"></td>
      <td id="dottedlong"></td>
    </tr>
    <tr>
      <td>Breve</td>
      <td>2</td>
      <td id="breve"></td>
      <td id="dottedbreve"></td>
    </tr>
    <tr>
      <td>SemiBreve</td>
      <td>1</td>
      <td id="semibreve"></td>
      <td id="dottedsemibreve"></td>
    </tr>
    <tr>
      <td>Minim</td>
      <td>1&frasl;2</td>
      <td id="minim"></td>
      <td id="dottedminim"></td>
    </tr>
    <tr>
      <td>Crotchet</td>
      <td>1&frasl;4</td>
      <td id="crotchet"></td>
      <td id="dottedcrotchet"></td>
    </tr>
    <tr>
      <td>Quaver</td>
      <td>1&frasl;8</td>
      <td id="quaver"></td>
      <td id="dottedquaver"></td>
    </tr>
    <tr>
      <td>SemiQuaver</td>
      <td>1&frasl;16</td>
      <td id="squaver"></td>
      <td id="dottedsquaver"></td>
    </tr>
    <tr>
      <td>Demisemiquaver</td>
      <td>1&frasl;16</td>
      <td id="dsquaver"></td>
      <td id="dotteddsquaver"></td>
    </tr>
    <tr>
      <td>Hemidemisemiquaver</td>
      <td>1&frasl;64</td>
      <td id="hdsquaver"></td>
      <td id="dottedhdsquaver"></td>
    </tr>
    <tr>
      <td>Semihemidemisemiquaver</td>
      <td>1&frasl;128</td>
      <td id="shdsquaver"></td>
      <td id="dottedshdsquaver"></td>
    </tr>
    <tr>
      <td>Demisemihemidemisemiquaver</td>
      <td>1&frasl;256</td>
      <td id="dshdsquaver"></td>
      <td id="dotteddshdsquaver"></td>
    </tr>
  </tbody>
</table>
