import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort"
export default class extends Controller {
  connect() {
    console.log('controller sort connected')
  }
  static targets = ["sortable"];

  sort(event) {
    event.preventDefault();
    const column = event.target.dataset.column;
    const order = event.target.dataset.order;
    const rows = Array.from(this.sortableTarget.querySelectorAll("tbody tr"));

    const sortedRows = rows.sort((a, b) => {
      const aText = a.querySelector(`[data-column="${column}"]`).innerText;
      const bText = b.querySelector(`[data-column="${column}"]`).innerText;
      return order === "asc" ? aText.localeCompare(bText) : bText.localeCompare(aText);
    });
    sortedRows.forEach((row, index) => {
      row.classList.remove('odd', 'even');
      row.classList.add(index % 2 === 0 ? 'odd' : 'even');
    });

    this.sortableTarget.querySelector("tbody").append(...sortedRows);
    event.target.dataset.order = order === "asc" ? "desc" : "asc";
  }

}
