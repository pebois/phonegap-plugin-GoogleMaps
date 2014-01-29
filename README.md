phonegap-plugin-GoogleMaps
============================

Google Maps phonegap plugin

## Platforms ##

* IOS

## Adding the Google Maps SDK for iOS to your project ##

https://developers.google.com/maps/documentation/ios/start

## Using the plugin ##

### GoogleMaps.showMarkers ###
![screenshot](https://raw.github.com/pebois/phonegap-plugin-GoogleMaps/master/sample1.png)
```js
var markers = [{id:"105",
                title:"Théâtre du Châtelet",
                subtitle:"Spectacle › Théâtre",
                latitude:48.8573679,
                longitude:2.347562},
               {id:"443", 
                title:"Opéra Comique",
                subtitle:"Spectacle › Théâtre",
                latitude:48.8683123,
                longitude:2.34194339999999},
               {id:"130", 
                title:"Théâtre de la Porte Saint-Martin",
                subtitle:"Spectacle › Théâtre",
                latitude:48.8689366,
                longitude:2.35705929999995},
               {id:"113",
                title:"Comedie Bastille",
                subtitle:"Spectacle › Théâtre",
                latitude:48.8588309,
                longitude:2.3701275},
               {id:"97",
                title:"L'Antre Magique",
                subtitle:"Spectacle › Théâtre",
                latitude:48.8774069,
                longitude:2.3373855}];

GoogleMaps.showMarkers(markers, function (marker) {
    // Tapped marker callback
    console.log("Marker [id:"+marker+"] tapped !");
    GoogleMaps.close();
  }, function (msg) {
    // map closed callback
    console.log(msg);
  }
);
```

### GoogleMaps.showPath ###
![screenshot](https://raw.github.com/pebois/phonegap-plugin-GoogleMaps/master/sample3.png)
```js
var markers = [{title:"Départ",
                subtitle:"Saint-Sulpice, 75006 Paris, France",
                latitude:48.8516,
                longitude:2.33114,
                color:"yellow"},
               {title:"Arrivée",
                subtitle:"Rue de Rivoli, 75001 Paris, France",
                latitude:48.8633,
                longitude:2.33346,
                color:"yellow"}];
                
var encPath = "oidiHshfMmAtFGFIDg@e@wA~Bg@Q_Ag@}EiCWScA]{@[aBeAoCiBoC{BsBaBoBuACEACAKBQIGc@|B]Nc@VCAmAk@k@WiB{@KEQFWIYMmCuASIQFKNMHQBOAOIKMOk@G]_AqAU]m@[k@a@SSKb@_BdH";

GoogleMaps.showPath(markers,
                    encPath,
                    function (msg) {
                        console.log(msg);
                    });
```

### GoogleMaps.showPanorama ###
![screenshot](https://raw.github.com/pebois/phonegap-plugin-GoogleMaps/master/sample2.png)
````js
GoogleMaps.showPanorama({latitude:48.8573679, longitude:2.347562},
                        {heading:90, pitch:7, zoom: 0},
                        function (msg) {
                          console.log(msg);
                        });
```

### GoogleMaps.close ###
```js
GoogleMaps.close();
```

## Licence ##
```
The MIT License (MIT)

Copyright (c) 2013 Pierre-Emmanuel Bois

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
