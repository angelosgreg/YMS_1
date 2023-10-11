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
    this.markersValue.forEach((marker, index) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html
      // if (index % 2 === 0) {
      //   customMarker.innerHTML = marker.marker_html
      // } else {
      //   customMarker.innerHTML = marker.marker_html2
      // }

      const offset = index * 2;

      console.log(marker.lng, marker.lat, marker.location)
      console.log(offset)

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker, {
          //draggable: true,
          //offset: [0, offset],
          occludedOpacity: 0.5
        }).setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        //.setPitchAlignment('map')
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 30, duration: 0 })
  }

}
