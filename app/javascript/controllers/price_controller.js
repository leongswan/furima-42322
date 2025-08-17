import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["fee", "profit"]
  static values = { rate: { type: Number, default: 0.1 } }

  connect() {
    this.recalc()
    this._onTurboRender = () => this.recalc()
    document.addEventListener("turbo:render", this._onTurboRender)
  }

  disconnect() {
    document.removeEventListener("turbo:render", this._onTurboRender)
  }

  recalc() {
    const input = document.getElementById("item-price")
    if (!input) return
    const v = parseInt(input.value, 10)
    if (Number.isFinite(v)) {
      const fee = Math.floor(v * this.rateValue)
      this.feeTarget.textContent = fee
      this.profitTarget.textContent = v - fee
    } else {
      this.feeTarget.textContent = ""
      this.profitTarget.textContent = ""
    }
  }
}