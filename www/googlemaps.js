//  googlemaps.js
//
//  Created by Pierre-Emmanuel Bois on 08/08/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

var GoogleMaps = {
    markerTappedCallback: null,
    addMarkers: function (markers, tapp_calback, callback) {
        GoogleMaps.markerTappedCallback = tapp_calback;
        cordova.exec(callback, function (err) { console.log(err); }, "GoogleMaps", "addMarkers", [markers]);
    },
    showPanorama: function (coord, opts, callback) {
        cordova.exec(callback, function (err) { console.log(err); }, "GoogleMaps", "showPanorama", [coord, opts]);
    },
    close: function (callback) {
        cordova.exec(callback, function (err) { console.log(err); }, "GoogleMaps", "close", []);
    },
    markerTapped: function (marker) {
        GoogleMaps.markerTappedCallback(marker);
    }
};

module.exports = GoogleMaps;
