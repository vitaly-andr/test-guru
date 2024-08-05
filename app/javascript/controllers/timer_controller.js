import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["left", "form"];
    static values = {duration: Number, redirectUrl: String}

    connect() {
        console.log("Timer controller connected");

        this.startTime = Date.now()
        this.timer = this.durationValue * 60 * 1000 // Конвертируем минуты в миллисекунды
        this.updateTimer()
        this.interval = setInterval(() => this.updateTimer(), 1000)

    }

    disconnect() {
        clearInterval(this.interval)
        console.log('Timer controller disconnected')

    }

    updateTimer() {
        const elapsedTime = Date.now() - this.startTime
        const timeLeft = this.timer - elapsedTime
        console.log('Timer controller updating')


        if (timeLeft > 0) {
            const minutes = Math.floor(timeLeft / 1000 / 60);
            const seconds = Math.floor((timeLeft / 1000) % 60);
            this.leftTarget.textContent = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
            return;
        }

        clearInterval(this.interval);
        console.log('Form submitted due to timer');

        this.formTarget.requestSubmit();
        console.log('Form submitted due to timer2');
    }
}
