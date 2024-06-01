import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["results", "name", "category", "size", "availableDate"]

  connect() {
    console.log("SearchController connected");
    const form = this.element.querySelector('form'); // This variable is  used throughout the code to refer to the search form
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

    const url = form.action; // the "form" variable was set  on line #21, form.action retrieves the URL to which the form is set to submit its data
    // "input->search#search" defines the form action in our _search.html.erb file
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
        this.resultsTarget.innerHTML = html; // This ensures that only the "data-search-target="results" div in the index.html.erb file changes
      })
      .catch(error => {
        console.error("Error:", error);
      });
  }

  allFieldsEmpty(form) { // Checking if all fields in a form are empty
    const formData = new FormData(form); // Creates a FormData object from the given "form" element
    for (const value of formData.values()) { // This is a loop that iterates over each value in the FormData object and yields the values of the form fields
      if (value.trim() !== "") { // This removes any whitespace from both ends of the string and checks whether it is empty
        return false;
      }
    }
    return true;
  }

  // Referring to formData.values(), these are the values in formData:

  // name field: " " (string with spaces)
  // category field: "" (empty string)
  // size field: "" (empty string)
  // available_date field: "" (empty string)

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
