import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.ping()
    this.interval = setInterval(() => this.ping(), 30000)
  }

  disconnect() {
    clearInterval(this.interval)
  }

  ping() {
    const token = document.querySelector('meta[name="csrf-token"]')?.content
    if (!token) return
    fetch("/heartbeat", {
      method: "POST",
      headers: { "X-CSRF-Token": token }
    })
  }
}
