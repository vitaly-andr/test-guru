import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress"
export default class extends Controller {
  static values = {
    currentQuestionNumber: Number,
    totalQuestions: Number
  }

  static targets = ["bar"]

  connect() {
    this.updateProgressBar()
  }

  updateProgressBar() {
    const totalQuestions = this.totalQuestionsValue
    const currentQuestionNumber =this.currentQuestionNumberValue
    const progress = (currentQuestionNumber / totalQuestions) * 100
    this.barTarget.style.width = `${progress}%`
    this.barTarget.setAttribute("aria-valuenow", progress)
  }
}
