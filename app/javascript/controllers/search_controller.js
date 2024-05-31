import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["results"]

  connect() {
    console.log("SearchController connected");
  }

  search(event) {
    event.preventDefault();

    const url = this.element.action;
    const params = new URLSearchParams(new FormData(this.element)).toString();

    fetch(`${url}?${params}`, {
      headers: {
        "X-Requested-With": "XMLHttpRequest"
      }
    })
      .then(response => response.text())
      .then(html => {
        this.resultsTarget.innerHTML = html;
      })
      .catch(error => {
        console.error("Error:", error);
      });
  }
}
