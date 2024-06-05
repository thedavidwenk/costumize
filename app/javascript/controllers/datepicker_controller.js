import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["startDate", "endDate", "dateRange"];

  connect() {
    flatpickr(this.dateRangeTarget, {
      mode: "range",
      dateFormat: "d-m-Y",
      onChange: this.updateHiddenFields.bind(this),
    });
  }

  updateHiddenFields(selectedDates) {
    if (selectedDates.length === 2) {
      const [startDate, endDate] = selectedDates;
      this.startDateTarget.value = flatpickr.formatDate(startDate, "d-m-Y");
      this.endDateTarget.value = flatpickr.formatDate(endDate, "d-m-Y");
    } else {
      this.startDateTarget.value = "";
      this.endDateTarget.value = "";
    }
  }
}
