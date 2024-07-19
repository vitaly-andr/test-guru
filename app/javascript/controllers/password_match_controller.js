import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password-match"
export default class extends Controller {
  static targets = ["password", "passwordConfirmation", "icon"];

  connect() {
    console.log('password_match controller connected')
  }
  checkMatch() {
    const password = this.passwordTarget.value;
    const passwordConfirmation = this.passwordConfirmationTarget.value;

    if (passwordConfirmation === "") {
      this.iconTarget.innerHTML = "";
      return; // Exit the function early
    }

    if (password === passwordConfirmation) {
      this.iconTarget.innerHTML = "✅";
      this.iconTarget.style.color = "green";
    } else {
      this.iconTarget.innerHTML = "❌";
      this.iconTarget.style.color = "red";
    }
  }
}
