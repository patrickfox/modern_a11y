---
title: Accessible Modals
filename: accessible-modals
pubdate: 20150131
author: 'Patrick Fox'
draft: true
---

<h2 data-page-title="Accessible Modals">Accessible Modals</h2>


Building accessible modals is easy. A few things to keep in mind:


###Add role=dialog to modal
Outer modal container must have a ```role="dialog"```. When focus is placed on or inside the modal, screen readers will announce a "dialog".


###Use H1 as the first heading
Since the modal is the only active item in the page, use headings starting at H1 to indicate to the user that this is the highest level heading.


###Use aria-labelledby to label the modal
Provide context for the prupose of the modal by using aria-labelledby to assocaite the modal with a heading or other content that speaks to its purpose.

###Isolate the modal from the rest of the UI
This technique relies on aria-hidden="true" to hide the main page content, and a focus listener that returns focus to the modal if the page receives focus.


###Place focus on first focusable element
The first focusable element inside the modal should receive focus.


###Listen for escape key to close modal
Ability to close modal via the Escape key on informative modals. _Note: If a modal requires user input to proceed, the Escape key behavior should be disabled._


###Modal Example
<button data-opens-modal="test_modal" type="button">Open Modal</button>









