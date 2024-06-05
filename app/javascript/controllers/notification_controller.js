import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  connect() {
    // This timeout removes the notification after 5 seconds
    const notificationElement = this.element;
    setTimeout(() => {
      notificationElement.remove();
    }, 3000);
  }
}
