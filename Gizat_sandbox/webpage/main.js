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
  
    map.addLayer({
        'id': 'cropfieldsLayer',
        'type': 'fill-extrusion',
        'source': 'cropfields',
        'layout': {
          'visibility': 'visible'
        },


        'paint': {
          'fill-extrusion-color': {
            'property': 'A1',
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

        /*
        'paint': {
          'fill-color': 'skyblue',
          'fill-outline-color': 'white',
          'fill-opacity': 0.4
        }
        */
    });
});

/*  Add choropleth  */

