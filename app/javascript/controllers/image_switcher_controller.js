// app/javascript/controllers/image_switcher_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["thumbnail", "mainImage"];

  connect() {
    console.log("Image switcher controller connected");
  }

  changeImage(event) {
    const newImageUrl = event.currentTarget.dataset.imageUrl;
    const newImageAlt = event.currentTarget.dataset.imageAlt;
    this.mainImageTarget.src = newImageUrl;
    this.mainImageTarget.alt = newImageAlt;
  }
}
