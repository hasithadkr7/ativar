// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

import { Maskito } from '@maskito/core';
import { maskitoNumberOptionsGenerator } from '@maskito/kit';

const amountMask = (prefix) => maskitoNumberOptionsGenerator({
  decimalZeroPadding: true,
  precision: 2,
  decimalSeparator: ',',
  min: 0,
  prefix,
});

const brlMask = amountMask("R$");
const usdMask = amountMask("U$");
const eurMask = amountMask("€");

const brl = document.querySelector(".amount-brl")
const usd = document.querySelector(".amount-usd")
const eur = document.querySelector(".amount-eur")

if (brl) new Maskito(brl, brlMask);
if (usd) new Maskito(usd, usdMask);
if (eur) new Maskito(eur, eurMask);

const unitMask = maskitoNumberOptionsGenerator({
  decimalZeroPadding: true,
  precision: 2,
  decimalSeparator: ',',
  min: 0,
  suffix: 'Kg',
});

const units = document.querySelector(".unit")
if (units) new Maskito(units, unitMask);

topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { params: { _csrf_token: csrfToken } })
liveSocket.connect()
window.liveSocket = liveSocket

