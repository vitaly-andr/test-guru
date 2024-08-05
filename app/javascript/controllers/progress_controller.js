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
    console.log('Progress controller connected')

  }

  updateProgressBar() {
    const totalQuestions = this.totalQuestionsValue
    const currentQuestionNumber =this.currentQuestionNumberValue
    const progress = (currentQuestionNumber / totalQuestions) * 100
    this.barTarget.style.width = `${progress}%`
    this.barTarget.setAttribute("aria-valuenow", progress)
  }
}
