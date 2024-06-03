import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["notice", "alert"];

  connect() {
    console.log("Hello WOrld")
    this.elementTarget.textContent = "";

    const notice = () => {
      setTimeout(() => {
        const notification = document.querySelector('.notification');
        notification.classList.add('d-none');
      }, 5000);
    }
  }
}
