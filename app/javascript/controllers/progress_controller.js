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
    console.log('progress connected')
  }
  disconnect() {
    console.log('progress controller disconnected')

  }
  updateProgressBar() {
    const totalQuestions = this.totalQuestionsValue
    console.log('totalQuestions ')
    console.log(totalQuestions)
    const currentQuestionNumber =this.currentQuestionNumberValue
    console.log('currentQuestionNumber ')
    console.log(currentQuestionNumber)
    const progress = (currentQuestionNumber / totalQuestions) * 100
    this.barTarget.style.width = `${progress}%`
    this.barTarget.setAttribute("aria-valuenow", progress)
  }
}
