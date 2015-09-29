---
title: Outlook Accessibility and aria-labelledby
filename: a11ywin-outlook-aria-labelledby
pubdate: 20150614
author: 'Patrick Fox'
summary: 'The Outlook Web App is a great example of a highly usable and accessible web experience, and an #a11ywin'
---

<h2 data-page-title>Outlook Accessibility and aria-labelledby</h2>

<span class="summary">The Outlook Web App is a great example of a highly usable and accessible web experience, and an __#a11ywin__.</span>

Email inboxes are surely familiar to all of us: scads of information, some of it important, most of it junk or outdated information. Aside from the sheer number of email in an inbox(mine currently has over 2000), summarizing and presenting the information contained in an individual email is a formidable task alone. The information contained in a single email or email thread comprises about a dozen data points:
- sender
- recipient(s)
- subject
- received/sent time stamp
- draft indicator
- priority indicator
- conversation indicator (indicates conversation/thread vs. single email)
- attachments indicator
- read/unread indicator
- draft indicator

Navigating through and understanding all of this information is potentially cumbersome and presents a significant usability challenge for users of any ability.


###Visual vs. Spoken Summary

Visually, all of the pertinent information is represented in a convenient, efficient manner that allows for quick understanding of each email and email thread's purpose.

![Outlook Inbox detail with icons indicating read check mark, replied to arrow, important flag, and email thread caret](https://lh3.googleusercontent.com/-48J2SEjvw_8/VW2_CF-YxzI/AAAAAAAACts/U-5IgDe9-x4/s0/owa-email-inbox.png)


The sender, subject, timestamp and summary of the email body are prominently displayed, along with icons to indicate priority, replies, drafts, attachments, etc.

For screen reader users, navigating through all of these elements is easily cumbersome and inefficient. One solution is to summarize the content for each inbox item in a consistent and understandable format. By adding `aria-labelledby` to an element, an efficient summary is created using other content in the page, thus negating the need to navigate through each child element. 


####How Aria-Labelledby works

`aria-labelledby` works by referencing the ID's of one or more DOM elements. Each referenced element's content is spoken in the order as specified in the ID list. In this way, `aria-labelledby` attribute allows developers to specify a pattern from which a sequence of content is spoken, and thus curate to efficient and accessible spoken summaries.


###Example Email

The HTML markup shown below is the outer container for an individual email item. the `aria-labelledby` attribute references 14 ID's. 


![HTML code for an Outlook email item showing a div element and its aria-labelledby attribute with 14 IDs](https://lh3.googleusercontent.com/nUd9RRaQVT9djehDL1PxOx4ubSvWev7ulVDZClQ7xf0=s0)

The following table shows each referenced element ID, it's corresponding content and any icons or other visual translations.

| ID			| Content			| Icon/Visual
|---            |---                |
| `_ariaId_65.conversationprefix` | "Conversation Collapsed," | Right or Down Caret
| `_ariaId_65.uread`              |	"" | Subject and time are blue vs. gray
| `_ariaId_65.draft`              |	"Draft in conversation," | "[Draft]" in red
| `_ariaId_65.from`              |	"From Patrick Fox," | 50% larger text
| `_ariaId_65.to`              |	"To Patrick Fox" | not visible
| `_ariaId_65.importance`              |	"" | Red flag icon
| `_ariaId_65.flag`              |	"Flagged item Active," | (none)
| `_ariaId_65.categories`              |	"" | (none)
| `_ariaId_65.attachments`              |	"(if present) Attachment, " | Paper clip icon
| `_ariaId_65.subject`              |	"Subject Breakfast Tacos in the kitchen" | (none)
| `_ariaId_65.empty_subject`              |	"(if empty) Empty Subject, " | Indicates empty subject
| `_ariaId_65.date`              |	"Last message 9:43p. Replied, " | Left grey arrow
| `_ariaId_65.smallicon`              |	"(if meeting) Appointment, " | Calendar icon
| `_ariaId_65.preview`              |	"Get 'em while they're hot!" | (none)


####Commas
By adding commas to the text, screen readers will add friendly pauses, significantly improving the spoken experience.

###Spoken Helper Text
Additional label text to make the summary more understandable as a spoken message was added. For example, "From" is added to the sender copy, which reads as "From Patrick Fox".

####The End Result

Upon navigating to this email item, the screen reader will announce the following:
> Conversation Collapsed, Draft in conversation, From Patrick Fox, To Patrick Fox, Flagged item Active, Subject Breakfast Tacos in the kitchen, Last message 9:43p. Replied, Get 'em while they're hot!

Without this `aria-labelledby` summary, the user would hear only the text that is visible, which isn't terrible, but the user misses out on pauses, icons and visual indicators(unless they have alt or aria-label copy), and helper text("From", "To", "Subject", etc.).

> Draft Patrick Fox Breakfast tacos in the kitchen 9:43p Get' em while they're hot, son!


----------

###Accessibility vs. Complexity

Accessibility inevitably adds some amount of complexity to the UI, but great care should be taken to find the most efficient and maintainable solution.

####Unnecessary Complexity?

Each of the 14 ID's listed above corresponds to a unique DOM element, whose purpose is solely to hold content for use by `aria-labelledby`. None of these elements are used for the visually displayed content  - all referenced elements are `display:none;`. This specific implementation adds hundreds of elements to the page and requires the creation of hundreds of unique ID's. Both of these add up to code bloat(and potential performance issues) and overly complex and inefficeint code. Minimizing the number of DOM nodes is a core web performance optimization best practice.

From my personal accessibility rule book:

> Do not compromise code performance, simplicity and maintainability to achieve accessibility.


####A Better Approach: Aria-Label

Even though the point of this article is to demonstrate the awesomeness of `aria-labelledby`, a far more elegant implementation that provides the same experience would be to create the same summary and to use `aria-label` instead. `aria-label` provides a similar means of labeling UI elements, but takes a static string of text vs. a sequence of ID's.

Example:

    <button aria-label="Conversation Collapsed, Draft in conversation, From Patrick Fox, To Patrick Fox, Flagged item Active, Subject Breakfast Tacos in the kitchen, Last message 9:43p. Replied, Get 'em while they're hot!" ...>...</button>

![VoiceOver console showing the spoken summary:  Conversation Collapsed, Draft in conversation, From Patrick Fox, To Patrick Fox, Flagged item Active, Subject Breakfast Tacos in the kitchen, Last message 9:43p. Replied, Get 'em while they're hot!](https://lh3.googleusercontent.com/-su2vJUNNDd4/VW4Miqz-rdI/AAAAAAAACuI/2nZGsrX-eg0/s0/owa-email-spoken.png)

For this scenario, using `aria-label` vs. `aria-labelledby` provides a far simpler approach but accomplishes the same goal.



###Summary

`aria-labelledby` provides a powerful means to associate multiple pieces of visible content with another UI element. In this way, `aria-labelledby` enables other UI elements to speak for the labelled element.

> ####__Aria-Labelledby Best Practices__
> - Rely on a foundation of solid content and copy 
> - Use `aria-labelledby`, sparingly, to improve the spoken user experience of complex UI elements
> - Content referenced by `aria-labelledby` should already be visible
> - Minimize the creation of supporting HTML elements - it's OK to have a few extra elements, though
> - IE requires the `aria-labelledby` element to be either natively focusable or programmatically focusable via `tabindex="-1"` - see: http://www.paciellogroup.com/blog/2014/06/aria-labelledby-aria-describedby-support-popular-windows-browsers/

