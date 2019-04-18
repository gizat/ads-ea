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
    map.addSource('20-55-cropfields', {
      'type': 'geojson',
      'data': 'https://github.com/gizat/ads-ea/raw/master/Gizat%20-%20Sandbox/cropfields_4326/20-55-cropfields.json'
      
    });
  
    map.addLayer({
      'id': 'cropfieldsLayer',
      'type': 'fill',
      'source': '20-55-cropfields',
      'layout': {
        'visibility': 'visible'
      },
      
      'paint': {
        'fill-color': 'skyblue',
        'fill-outline-color': 'white',
        'fill-opacity': 0.4
      }
    });
  });




/*

map.on('load', function() {
    map.addSource('counties', {
      'type': 'geojson',
      'data': 'https://ovrdc.github.io/gis-tutorials/tutorial-data/counties.geojson'
    });
  
    map.addLayer({
      'id': 'countiesLayer',
      'type': 'fill',
      'source': 'counties',
      'layout': {
        'visibility': 'visible'
      },
      
      'paint': {
        'fill-color': 'skyblue',
        'fill-outline-color': 'white',
        'fill-opacity': 0.4
      }
    });
  });
  
  */