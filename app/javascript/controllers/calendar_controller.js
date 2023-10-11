// import { Controller } from "@hotwired/stimulus"
// import { Calendar } from "@fullcalendar/core";
// import dayGridPlugin from "@fullcalendar/daygrid";
// import interactionPlugin, { Draggable } from '@fullcalendar/interaction';

// // Connects to data-controller="calendar"
// export default class extends Controller {
//   static targets = ["calendar"];

//   connect() {

//     console.log(this.calendarTarget)

//     document.addEventListener('DOMContentLoaded', function() {
//       let draggableEl = document.getElementById('mydraggable');
//       let calendarEl = document.getElementById('calendar');

//       const calendar = new FullCalendar.Calendar(calendarEl, {
//         // initialView: 'timeGridDay' #listWeek
//         plugins: [ interactionPlugin ],
//         droppable: true,
//         initialView: 'resourceTimelineMonth'
//       });
//       calendar.render();

//       new Draggable(draggableEl, {
//         eventData: {
//           title: 'my event',
//           duration: '02:00'
//         }
//       });
//     });
//   }
// }
