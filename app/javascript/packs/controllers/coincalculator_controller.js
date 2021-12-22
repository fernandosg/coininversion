import { Controller } from "stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["url", "type", "inversion"]

  connect() {
  }

  downloadFile(event) {
    let url = this.urlTarget.value
    let type = this.typeTarget.value
    let inversion = this.inversionTarget.value
    let params = new URLSearchParams()
    
    params.append("format", type)
    params.append("inversion", inversion)

    window.location.href = `${url}?${params}`
  }
}
