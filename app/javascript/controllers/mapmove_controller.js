import { Controller } from "@hotwired/stimulus"

import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/amir003/clmsaang502cc01r44xt44gkp"
      //"mapbox://styles/amir003/clmsafttn02ay01quhr1cdeod"
      //"mapbox://styles/amir003/clmsaang502cc01r44xt44gkp"
      //"mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }))

  }


  #addMarkersToMap() {
    function onDragEnd() {
      const lngLat = this.getLngLat();
      console.log("Marker: ", this.yachtId);
      console.log(`Longitude: ${lngLat.lng} | Latitude: ${lngLat.lat}`);

      const csrfToken = document.querySelector("[name='csrf-token']").content
      fetch(`yachts/${this.yachtId}/update_location`, {
        method: "PATCH",
        credentials: 'same-origin',
        headers: {"Content-Type": "application/json",
                  'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({yacht: {longitude: lngLat.lng, latitude: lngLat.lat}})
      })
        .then(response => response.json())
        .then((data) => {
          console.log(data)

        })

    }
    this.markersValue.forEach((marker, index) => {
      //console.log(marker)
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html2

      const offset = index * 2;

      // Pass the element as an argument to the new marker
      const markerTemp = new mapboxgl.Marker(customMarker, {
        draggable: true,
        //offset: [0, offset],
        occludedOpacity: 0.5,
      }).setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      //.setPitchAlignment('map')
      .addTo(this.map)

      console.log("MARKERTEMP: ", markerTemp);
      console.log("MARKER ID: ", marker.id);
      console.log("MARKER LOCATION: ", marker.location);
      markerTemp.yachtId = marker.id;
      markerTemp.on('dragend', onDragEnd);

    })

  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 30, duration: 0 })
  }

}
