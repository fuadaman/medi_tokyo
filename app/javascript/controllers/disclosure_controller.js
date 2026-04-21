import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "chevron"]
  static values = { exclusive: Boolean }

  toggle() {
    const isOpen = this.element.dataset.open === "true"

    if (this.exclusiveValue && !isOpen) {
      this.dispatch("close", { bubbles: true })
    }

    this.setOpen(!isOpen)
  }

  close() {
    this.setOpen(false)
  }

  setOpen(open) {
    this.element.dataset.open = open
    this.panelTarget.style.maxHeight = open
      ? this.panelTarget.scrollHeight + "px"
      : "0"
    if (this.hasChevronTarget) {
      this.chevronTarget.style.transform = open ? "rotate(180deg)" : "rotate(0deg)"
    }
  }
}
