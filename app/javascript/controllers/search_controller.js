import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["results", "name", "category", "size", "availableDate"]

  connect() {
    console.log("SearchController connected");
    const form = this.element.querySelector('form');
    if (form) {
      form.addEventListener('input', this.search.bind(this));
    } else {
      console.error("Form element not found");
    }
  }

  search(event) {
    event.preventDefault();
    console.log("Search event triggered");

    const form = event.currentTarget.closest('form');
    if (!form) {
      console.error("Form element not found in search event");
      return;
    }

    if (this.allFieldsEmpty(form)) {
      console.log("All fields are empty, fetching all results");
      this.loadAllResults(form);
      return;
    }

    const url = form.action;
    const params = new URLSearchParams(new FormData(form)).toString();
    console.log(`Fetching results from: ${url}?${params}`);

    fetch(`${url}?${params}`, { // for example: /costumes?category=superhero
      headers: {
        "X-Requested-With": "XMLHttpRequest", // This header tells the server that the request is an AJAX request
        "Accept": "text/javascript" // This one tells the server that we expect text or JS as a response, not a full html page
      }
    })
      .then(response => response.text())
      .then(html => {
        console.log("Received HTML response");
        this.resultsTarget.innerHTML = html;
      })
      .catch(error => {
        console.error("Error:", error);
      });
  }

  allFieldsEmpty(form) {
    const formData = new FormData(form);
    for (const value of formData.values()) {
      if (value.trim() !== "") {
        return false;
      }
    }
    return true;
  }

  loadAllResults(form) {
    const url = form.action;
    console.log(`Loading all results from: ${url}`);

    fetch(url, {
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "Accept": "text/javascript"
      }
    })
      .then(response => response.text())
      .then(html => {
        console.log("Received HTML response for all results");
        this.resultsTarget.innerHTML = html;
      })
      .catch(error => {
        console.error("Error:", error);
      });
  }
}
