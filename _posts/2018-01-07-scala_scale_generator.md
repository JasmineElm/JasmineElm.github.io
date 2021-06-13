---
layout: post
title: Scala scale generator
date: 2018-01-07T13:50:27.000Z
categories: code
synopsis: javascript Scala scale generator
last-modified-date: '2021-06-12T16:39:32+01:00'

---

<script>
/*
  Generate Scala
*/
    /*Random string, number and bool functions*/
    function randomString(length) {
      var returnString = "";
      /*below variable roughly has letter frequencies matching English language
          should mean that output text is less exotic looking
      */
      var possible = "aaaaaaaaaaaaaaaabbbcccccddddddddeeeeeeeeeeeeeeeeeeeeeeeeefffffgggghhhhhhhhhhhhiiiiiiiiiiiiiijkllllllllmmmmmnnnnnnnnnnnnoooooooooooooooopppqrrrrrrrrrrrrssssssssssstttttttttttttttttttttttuuuuuuvwwwwwxyyyyz";
      for (var i = 0; i < length; i++)
        returnString += possible.charAt(Math.floor(Math.random() * possible.length));
      return returnString;
    }

    function randomBool() {
      var returnBool = Math.random() >= 0.5;
      return returnBool;
    }

    function randomfloat(rangeLower, rangeUpper) {
      /*a variation on the randomInt function*/
        var returnFloat = Math.random()*(rangeUpper-rangeLower)+rangeLower;
        return returnFloat;
    }

    function randomInt(lowerBound, upperBound) {
       var returnInt = Math.ceil(Math.random()*(upperBound-lowerBound)+lowerBound);
       return returnInt;
    }

    function createArray(length) {
      //poached from  https://stackoverflow.com/questions/966225/how-can-i-create-a-two-dimensional-array-in-javascript/966938#966938
      // bizarrely complex to declare multi-dimensional arrays!?!
        var arr = new Array(length || 0),
            i = length;
        if (arguments.length > 1) {
            var args = Array.prototype.slice.call(arguments, 1);
            while(i--) arr[length-1 - i] = createArray.apply(this, args);
        }
        return arr;
    }

    function outputScale(title, notes) {
      var header = "! "+ title +".scl\r!\rScale generated in Javascript\r"+notes+"\r!\r";
      var arrayBredth=2 // how large is the second dimension of the array
      var noteArray=createArray(notes, arrayBredth);
      var noteList = "";
      //Generate the noteList
      for (var i = 0; i < notes; i++) {
        if (randomBool()) {
          key = generateRatio();
          var value = eval(key)*600;//octave = ratio of 2/1, or 1200 cents.  To Convert ratio to cents, multiply by 600.
          noteArray[i][0] = key;
          noteArray[i][1] = value;
        }
        else {
          key = generateCent();
          noteArray[i][0] = key;
          noteArray[i][1] = key;
        }
      }

      //sort the in array based on the second dimension
      noteArray.sort(function(a,b){
        return a[1] - b[1];
      });

      for (var i = 0; i < noteArray.length-1; i++) { //final note will be manually added later
        noteList += noteArray[i][0]+"\r";
      }
      noteList +="2/1" /*final note in scale will beone octabe higher (e.g. ratio: 2/1)*/
      document.getElementById("outScale").innerHTML = header+noteList;
}
    function generateRatio() {
      var maxPossibleDenom = 30;  // local var
      var denom=randomInt(2,maxPossibleDenom);
      var nom = maxPossibleDenom*2; //assigned to 2*theoretical maximum, to trigger while loop
      while (nom>=2*denom) {
        nom=randomInt(1,maxPossibleDenom);
      }
      var key = nom+"/"+denom;
      return key
    }

    function generateCent(inArray) {
      var  key   = randomfloat(0.1,1199.9);
      return key;
    }
    function generateLink(ScaleName) {
      document.getElementById("outScaleLink").setAttribute("download", ScaleName+".scl");
      var txt = document.getElementById('outScale');
      document.getElementById('outScaleLink').onclick = function(code) {
        this.href = 'data:text/plain;charset=utf-8,'
          + encodeURIComponent(txt.value);
      }
    }

    function outScl() {
          var nameError = document.getElementById("nameError");
           nameError.classList.add("hidden");
      // }
      var name = document.getElementById("textbox1").value;
      if (!name || name.length ===0) {
        name = randomString(randomInt(3,8));
        nameError.classList.remove("hidden");
      }
      var lengthError = document.getElementById("lengthError");
       lengthError.classList.add("hidden");
      var scaleLength = parseFloat(document.getElementById("textbox2").value); //using parseInt here would explicitly change the type if it were a float- we don't want that; it'll break the if/else below

      if (!(typeof scaleLength==='number' && (scaleLength%1)===0 && scaleLength >1))
      //value must be
      // + typeof = 'number'
      // + a whole number (modulo 1 = 0)
      // + and greater than 1
      {
        scaleLength = randomInt(3,23);
        lengthError.classList.remove("hidden");
      }

      document.getElementById("outScale").setAttribute("rows", scaleLength+5);//pad five rows to account for header
      outputScale(name, scaleLength);
      generateLink(name);

   }
   </script>

Scala is "[a powerful software tool for experimentation with Musical tunings](http://huygens-fokker.org/scala/)". The tool itself allows users to apply different tuning conventions to electronic instruments. With Scala, users can create, modify, and use complex musical scales.

Scala itself relies on plain text files with an extension of "scl". The rules around the formatting of contents of the file itself are relatively permissive, namely:

- a file may only contain one scale.

- line comments are represented by lines beginning with "!", they are ignored by Scala/compatible software

- the first line that is not a comment should contain a description of the fieldset

- The next non-comment line will contain the number of notes

- Each subsequent line will contain note values
  - the note may be a cent value (e.g. 100.993), or
  - the note may be a ratio (e.g. 1/4)
  - scales may contain a combination of ratios and cent values
  - logically, scales can contain two, or more notes

- any note value without a period will be considered a ratio for instance, 2 would be considered 2⁄1

- ratios contain one slash only

- numerators/denominators may be any positive number up to 2<sup>31</sup>-1

- The first note of 1⁄1 or 0.0 cents is implicit and not in the files.

- ratios and cent values are calculated from the root note

Additionally, to make the output scales usable, I have applied some additional rules:

- the scale will cover a single octave
- the scale will contain at least two notes
- the notes in a scale will be ordered low to high

The below button will generate text in scala ".scl" format. To define a name and/or the number of notes in a scale use the text-boxes. If the boxes are not used, or if they contain invalid values (e.g. if the number of notes box contains letters, or is unusually low/high), random values will be used.

I've also used this code in a twitter bot that will irregularly tweet a scale:
~~[@microscalebot](https://twitter.com/microscalebot).~~

<input type="text" name="name" id="textbox1" placeholder="Scale Name" />
<label for="name" id="nameError" class="blockError"> Name not supplied!</label><br><br>
<input type="text" name="textbox2" placeholder="number of notes" id="textbox2" /><label for="name" id="lengthError" class="blockError"> Number of notes not supplied, or non numeric</label><br><br>
    <input type="submit" name="button" id="button1" onclick="outScl()" value="generate Scale" /> <br>
<textarea id="outScale" name="name" rows="25" cols="80"></textarea><br>
<a href="" id="outScaleLink" download="">download the above scale</a> <br>
