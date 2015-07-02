---
title: Using Tabindex
filename: using-tabindex
pubdate: 20150702
---

## Using Tabindex

__tl;dr:__ The tabindex attribute is awesome, but resist the urge to use it.


### Understanding Tabindex

An important aspect of web accessibility is ensuring keyboard navigation and managing the user's focus in a page. The tabindex attribute gives developers the ability to make any element focusable. A few reasons why you might want to do this:


| Goal            | Usage     | Recommendation                
|-----------------|-----------|-------------------------------
| Make an element tabbable so that it can receive focus via tab key navigation  | tabindex="0" | Use natively focusable elements(e.g. button, anchor) instead of tabindex="0". In some cases, it is necessary to control the keyboard accessibility of elements prgrammatically. Some widgets(e.g. custom drop down menus) call for arrow navigation to emulate native element behaviors. See http://bit.ly/roving-tabindex for more details.
| Programmatically place focus on something in order to read it's contents or to place the user's focus in a specific place in the UI in order to manage focus | tabindex="-1"| Use sparingly and apply tabindex using a script vs. hard coding it in markup. A useful and elegant method for placing focus on any element is the $.access() function we've created - see http://bit.ly/access_a11y
| Curate a specific tab order | tabindex="{1 or greater}" | __Not recommended__ _Maintaining a logical, non-natural tab order in this manner is dificult, error prone, and an anti-pattern. Don't do this!_ How it works: lower, positive tabindex values receive focus before higher values. After this, any elements with either a tabindex of 0 or that are natively focusable with no tabindex are focusable in the order they appear in the DOM. Elements with the same tabindex will have a tab order based on their DOM order.




### General Rules

- DO NOT use tab index on elements that are not meant to be actionable  - e.g. a heading or div with tabindex
- DO use natively focusable elements (buttons, links) instead of using less semantic elements w/tabindex
- DO NOT ever use tabindex values greater than 0
- DO rely on the natural DOM order to establish the focus order of focusable elements like buttons, links and form fields
- DO use tabindex sparingly; otherwise you may end up with a maintenance nightmare
- DO refrain from using tabindex in an ad hoc manner or hardcoded in HTML; instead, use a script to manage the placement and value of tabindex dynamically


### Overdoing It

A great example of overdoing it can be found on AmericanExpress.com. If you have an Amex account, log in and check out the home page using a screen reader. Start tabbing and you'll see that many things that are not actionable(headings, paragraphs, etc.) are focusable. A DOM query shows 154 elements with tabindex.

When an focusable element receives focus, a screen reader will read its contents aloud. The developers intentions are good(albeit misinformed), as they are attempting to improve the keyboard accessibility of the page by making important copy(heaings, paragraphs, summaries) focusable.


![A screen shot of the American Express web site showing 154 instances of tabidex in the DOM](/img/amex.jpg)


A few problems with this approach:

- Tabbable elements should be actionable(e.g. for making a selection or taking an action); making non-interactive elements tabbable may be confusing to users.
- All page elements are already navigable using a screen reader's built-in virtual cursor navigation. These tools allow users to navigate from element to element, or by element type. The use of tabindex in this way is completely unnecessary.
- All of these tabindex attributes bloat/clutter the DOM, and have the potential to create other issues

