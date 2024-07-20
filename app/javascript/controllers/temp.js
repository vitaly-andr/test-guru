import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress"
export default class extends Controller {
  static targets = ["bar"]

  connect() {
    console.log("progress-controller connected")
  }

  submit(event) {
    event.preventDefault()
    console.log('Updating progress bar before form submission')

    this.updateProgressBar()

    // Находим форму и отправляем её
    setTimeout(() => {
      this.element.querySelector('form').submit()
    }, 100) // Небольшая задержка для визуального обновления прогресса
  }

  updateProgressBar() {
    const currentQuestionNumber = parseInt(this.data.get("progressCurrentQuestionNumber")) + 1
    const totalQuestions = parseInt(this.data.get("progressTotalQuestions"))
    const progress = (currentQuestionNumber / totalQuestions) * 100
    console.log('Updating progress bar:', progress)

    this.barTarget.style.width = `${progress}%`
    this.barTarget.setAttribute("aria-valuenow", progress)
  }
}
