import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price"
export default class extends Controller {
  static targets = ["fee", "profit"]

  connect() {
    const input = document.getElementById("item-price")
    if (input) this.recalc({ target: input }) // 初期表示時に反映
  }

  recalc(e) {
    const v = parseInt(e.target.value, 10)
    if (Number.isNaN(v) || v < 300 || v > 9999999) { this.feeTarget.textContent="-"; this.profitTarget.textContent="-"; return }
    const fee = Math.floor(v * 0.1)
    this.feeTarget.textContent = fee; this.profitTarget.textContent = v - fee
  
  }
}
