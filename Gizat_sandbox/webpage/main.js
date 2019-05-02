/*  Add Mapbox GL map.  */

mapboxgl.accessToken = 'pk.eyJ1IjoiZ2l6YXQiLCJhIjoiY2p1aGxtcmZvMHdweDRlcGc5a3FtNHEzNCJ9.fQdCmtjK2tILII9Vka1XVQ';

// This adds the map to your page
var map = new mapboxgl.Map({
    // container id specified in the HTML
    container: 'map-canvas',
    // style URL
    style: 'mapbox://styles/mapbox/light-v10',
    // initial position in [lon, lat] format
    center: [-2.402105,53.130688],
    // initial zoom
    zoom: 5.5
});

// Add zoom and rotation controls to the map.
map.addControl(new mapboxgl.NavigationControl());

map.on('load', function() {
    map.addSource('cropfields', {
        'type': 'geojson',
        'data': 'http://localhost:8000/20-55-cropfields.geojson'
    });

    map.addSource('wqSamples', {
      'type': 'geojson',
      'data': 'http://localhost:8000/nitrates.geojson'
    });
  
    map.addLayer({
        'id': 'cropfieldsLayer',
        'type': 'fill-extrusion',
        'source': 'cropfields',
        'layout': {
          'visibility': 'visible'
        },

        'paint': {
          'fill-extrusion-color': {
            'property': 'A99G1',
            'stops': [
              [0, 'white'],
              [140, '#BFDF2D'],
              [271, '#A4BF26'],
              [600, '#889F20'],
              [1294, '#526013']
            ]
          },
          'fill-extrusion-opacity': 0.8,
          'fill-extrusion-base': 0
        }
    });
    

    map.addLayer({
        'id': 'samplePoints',
        'type': 'circle',
        'source': 'wqSamples',
        'layout': {
          'visibility': 'visible'
        },

        'paint': {
          'circle-color': {
            'property': 'result',
            'type': 'exponential',
            'stops': [
              [0, 'rgba(236,222,239,0)'],
              [1, 'rgb(236,222,239)'],
              [2, 'rgb(208,209,230)'],
              [3, 'rgb(166,189,219)'],
              [4, 'rgb(103,169,207)'],
              [6, 'rgb(28,144,153)'],
              [10, 'rgb(1,108,89)']
            ]
          },

          'circle-radius': {
            'property': 'result',
            'type': 'exponential',
            'stops': [
              [{ zoom: 15, value: 1 }, 5],
              [{ zoom: 15, value: 62 }, 10],
              [{ zoom: 22, value: 1 }, 20],
              [{ zoom: 22, value: 62 }, 50],
            ]
          }
        }
        
    });
});


map.on('click', 'samplePoints', function(e) {
  new mapboxgl.Popup()
    .setLngLat(e.features[0].geometry.coordinates)
    .setHTML('<b>Index:</b> ' + e.features[0].properties.result)
    .addTo(map);
});