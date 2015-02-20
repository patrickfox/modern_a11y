---
title: Accessible Modals
filename: accessible-modals
pubdate: 20150131 
---

<h2 data-page-title="Accessible Modals">Accessible Modals</h2>


Building accessible modals is easy. A few things to keep in mi


###What is a modal?

For clarification, a modal is a UI component that temporarily interrupts the page context by obscuring the default UI/view and displaying a pertinent message that requires the user's attention,  and , optionally, to select an option.

Modals can be shown on user interaction or programatically.


###Why use a modal???

Modals are an effective way to inform and/or prompt the user while keeping them in the main experience.



### Types of modals

####Informative
Informative modals inform the user of pertinent information.

####Decisive
Decisive modals ask the user to interact with the prompt by choosing an option or providing information via a form field.


###Default modal behaviors

Escape to close
Ability to close modal via the Escape key on informative modals. _Note: If a modal requires user input to proceed, the Escape key behavior should be disabled._


###Modal Example
<button data-opens-modal="test_modal" type="button">Open Modal</button>
<button data-opens-tooltip="test_tooltip" type="button" aria-labelledby="test_tooltip" role="tooltip">Open Tooltip</button>