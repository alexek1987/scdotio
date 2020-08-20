import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 13, duration: 0 });
  map.addControl(new mapboxgl.NavigationControl());
};


const toggleCardHighlighting = (event) => {
  // We select the card corresponding to the marker's id

  const card = document.querySelector(`[data-product-id="${event.currentTarget.dataset.markerId}"]`);
  // Then we toggle the class "highlight github" to the card

  card.classList.toggle('highlight');
  console.log(card)
}


const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '23px';
    element.style.height = '30px';
    new mapboxgl.Marker(element)
    .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup) // add this
      .addTo(map);
    });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');



  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/taylormade38/ckc2vz7k409w01jt8s4dtz8tr'
  });

    // markers
    const markers = JSON.parse(mapElement.dataset.markers);
    const mapMarkers = [];
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      const newMarker = new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
      mapMarkers.push(newMarker)
      // We use the "getElement" funtion provided by mapbox-gl to access to the marker's HTML an set an id
      newMarker.getElement().dataset.markerId = marker.id;
      // Put a microphone on the new marker listening for a mouseenter event
      newMarker.getElement().addEventListener('mouseenter', (e) => toggleCardHighlighting(e) );
      // We put a microphone on listening for a mouseleave event
      newMarker.getElement().addEventListener('mouseleave', (e) => toggleCardHighlighting(e) );
    });

    // addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
    // toggleCardHighlighting(map, markers);
  }
};



export { initMapbox };
