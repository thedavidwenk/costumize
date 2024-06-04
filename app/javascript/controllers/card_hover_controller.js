import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["card"]

  connect() {
    console.log("Stimulus controller connected");
  }

  addHoverEffect(event) {
    event.currentTarget.classList.add('shadow-lg');
    event.currentTarget.style.cursor = 'pointer';
  }

  removeHoverEffect(event) {
    event.currentTarget.classList.remove('shadow-lg');
  }
}
