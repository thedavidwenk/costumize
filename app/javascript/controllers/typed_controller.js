import { Controller } from "@hotwired/stimulus";
import Typed from "typed.js";

// Connects to data-controller="typed"
export default class extends Controller {
  static targets = ["element"];

  connect() {
    // Clear the initial text content
    this.elementTarget.textContent = "";

    new Typed(this.elementTarget, {
      strings: [
        "Need a costume?",
        "Need a costume? Find the perfect one or share your own with Costumize 🥳"
      ],
      typeSpeed: 20,
      backSpeed: 55,
      startDelay: 300, // Optional: delay before typing starts
      loop: false, // Optional: set to true if you want the text to keep looping
    });
  }
}
