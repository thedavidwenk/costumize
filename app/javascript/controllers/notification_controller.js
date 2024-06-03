import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove();
    }, 5000);
  }
}
