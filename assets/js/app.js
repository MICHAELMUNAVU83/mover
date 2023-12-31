// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

let Hooks = {};

Hooks.Map = {
  mounted() {
    const input1 = document.getElementById("location1");
    const input2 = document.getElementById("location2");

    const options = {
      types: ["(cities)"],
      componentRestrictions: { country: "ke" },
    };

    autocomplete1 = new google.maps.places.Autocomplete(input1, options);
    autocomplete1.addListener("place_changed", () => {
      console.log("place changed");
      const place1 = autocomplete1.getPlace();

      document.getElementById("latitude_from").value =
        place1.geometry.location.lat();
      document.getElementById("longitude_from").value =
        place1.geometry.location.lng();
    });

    autocomplete2 = new google.maps.places.Autocomplete(input2, options);
    autocomplete2.addListener("place_changed", () => {
      console.log("place changed");
      const place2 = autocomplete2.getPlace();
      console.log(place2);

      document.getElementById("latitude_to").value =
        place2.geometry.location.lat();
      document.getElementById("longitude_to").value =
        place2.geometry.location.lng();
    });
  },
  updated() {
    const input1 = document.getElementById("location1");
    const input2 = document.getElementById("location2");

    const options = {
      types: ["(cities)"],
      componentRestrictions: { country: "ke" },
    };

    autocomplete1 = new google.maps.places.Autocomplete(input1, options);
    autocomplete1.addListener("place_changed", () => {
      console.log("place changed");
      const place1 = autocomplete1.getPlace();

      document.getElementById("latitude_from").value =
        place1.geometry.location.lat();
      document.getElementById("longitude_from").value =
        place1.geometry.location.lng();
    });

    autocomplete2 = new google.maps.places.Autocomplete(input2, options);
    autocomplete2.addListener("place_changed", () => {
      console.log("place changed");
      const place2 = autocomplete2.getPlace();
      console.log(place2);

      document.getElementById("latitude_to").value =
        place2.geometry.location.lat();
      document.getElementById("longitude_to").value =
        place2.geometry.location.lng();
    });
  },
};

let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: { _csrf_token: csrfToken },
});

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
