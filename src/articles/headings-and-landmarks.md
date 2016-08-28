---
title: Headings and Landmarks
filename: headings-and-landmarks
author: 'Patrick Fox'
pubdate: 20160826
summary: 'An important aspect of web accessibility is ensuring keyboard navigation and managing the users focus in a page. The tabindex attribute gives developers the ability to make any element focusable.'
---

## Headings and Landmarks

A fundamental aspect of web accessibility is the ability to efficiently identify the purpose, functionality and structure of the content on a web page. Proper design and implementation of headings and ARIA landmark regions ensures that all users can more efficiently understand, navigate and accomplish what they need to do.

### Improving Navigation and Discoverability

The goal of headings and landmarks is to establish structural hierarchy for page content and UI, with the goal of improving a user's ability to discover page content, functionality and overall purpose, and to improve navigation for screen reader users. Screen readers provide tools to discover and navigate page content via landmarks and headings. Just as sighted users can scan a page by identifying page sections and headings, screen readers provide summaries of headings and landmarks on a page, and provide vision-impaired users the ability to virtually scan and move focus to page content via landmark regions and headings.

##3 Landmarks

The goal of landmarks is to designate the key sections of the UI and to improve screen reader navigation. Properly implemented, landmarks enable users to more easily find and navigate to the important sections of the page UI. At a minimum, each page or view should have 1 `banner`, `main` and `contentinfo` section. Optionally, pertinent navigation, site search and/or complementary sections should be designated.

Landmarks are coded by using a combination of an appropriate/semantic HTML element (often an HTML5 sectioning element) with the role attribute and relevant landmark value.

| UI Purpose		| Landmark Role w/Sectioning Element	| Usage		| Description           	|
|------------------------------------------------------|
| Page header 		| `<header role="banner">`			| *required*, 1 per page   			| *A region that contains mostly site-oriented content, rather than page-specific content.* | 
| Main content		| `<main role="main">`				| *required*, 1 per page 				| *The main content of a document.* |
| Footer			| `<footer role="contentinfo">`		| *required*, 1 per page 		| *A large perceivable region that contains information about the parent document.* | 
| Complementary content		| `<section role="complementary">`		| optional, 0 or more per page, use with label | *A supporting section of the document, designed to be complementary to the main content at a similar level in the DOM hierarchy, but remains meaningful when separated from the main content.* |
| Navigation group		| `<nav role="navigation">`		| optional, 0 or more per page, use to designate a group of related navigation links, use with label | *A collection of navigational elements (usually links) for navigating the document or related documents.*|
| Site Search		| `<div role="search">`			| optional, 0 or more per page | *A landmark region that contains a collection of items and objects that, as a whole, combine to create a search facility* |

UX designers should determine the pertinent sections of content, assign landmark roles to those sections and capture this detail the wireframe documentation. It is important to reserve landmarks usage for the most important, top-level sections of the UI.


#### Labeled Landmarks

Generic landmarks with one or more instances present on a page, like navigation or complementary regions, should use labels to provide better descriptions and to differentiate their purpose. For example, using `role="navigation"` on an element will make it discoverable as a "navigation landmark" but if multiple navigation regions exist on a page, they will all be announced as "navigation landmark" making their specific purpose unknown. Using either the `aria-label` or `aria-labelledby` attribute, generic landmarks should be labeled to differentiate their purpose. E.g. "Site navigation landmark", "Manage account navigation landmark" or "Search Results navigation landmark".


#### Landmark Best Practices


##### Design

- **Document landmark use in wireframe docs** - Wireframes must clearly outline the strategy for consistent and proper implementation of landmarks across an application.
- **Use landmarks sparingly** - Ensure that only the most important section of the UI are designated as landmarks. Overuse of landmarks dilutes their purpose and meaning.
- **Use landmarks to designate the top-level page sections** - A page must contain at least a `header`, `main` and `contentinfo`, with optional `navigation`,`search`, and `complementary` sections. 
- **Use headings inside of landmarks to speak for its purpose** - Multiple landmarks of the same type (e.g. `navigation` and `complementary` sections) should be differentiated using `aria-label` or `aria-labelledby`.
- **Use landmarks consistently** - Across an application/web site, UX designers must ensure that landmarks are used in a consistent and predictable manner.
- **Ensure that all page content resides in a landmark** - Avoid orphaned content that does not live within a landmark region, and thus is not discoverable via landmark navigation.

##### Development

- **Use landmarks in conjunction with an appropriate HTML5 sectioning element** - HTML5 sectioning elements are available to provide more semantic structure to your markup, but their interpretation as landmark regions by themselves is not fully nor consistently supported by screen readers. As a best practice, use both HTML5 sectioning elements and landmark roles together to ensure future compatibility as screen reader and browser support improves.


### Headings

Headings provide both a visual and accessible means for users to identify content hierarchy and to navigate page content by jumping to the various headings via screen readers.

#### Heading Best Practices

##### Design

- **Document heading use in wires and copy decks** - Wireframes and copy decks must clearly outline the strategy for consistent and proper implementation of headings across an application.
- **Use headings sparingly** - Headings should enable users to identify the most important content sections and the hierarchy of content on a page. Overuse of headings dilutes their 
- **Use headings consistently** - Heading levels should represent sections of equal importance equally across a site. For example, if an H2 is used as an article title on one page, it should be used consistently
- **Use succinct and meaningful text** - A user should be able to determine the purpose of the content it represents.
- **Use proper heading levels to define content hierarchy** - Use heading levels to create relationships and hierarchy. For example, an H3 implies that it has a parent H2 and that the content is a subtopic of the parent H2.
- **Avoid skipping heading levels** - Heading order can be used to indicate content hierarchy. Skipping levels - e.g. having an H2 followed by an H4 vs. and H3 - may cause confusion, and thus heading levels should never increase by more than 1:
	- ***Good***: H2 > H3, H1 > H2, H4 > H2 (*decreases* by 2, which is fine)
	- ***Avoid***: H2 > H4, H1 > H4
- **Use only one H1 per page/view** - An H1 is the most important heading in the page. There should only be one available at any time and it should convey the purpose of the current page. E.g. "Account Dashboard"
- **Modal headings should start at H1** - When a modal dialog is active, the modal should contain an H1 the summarizes the purpose of the dialog. The main page content and H1 should be hidden from the screen reader.

##### Development

- **Avoid mixing other elements in headings** - Keep heading purpose simple and clear. Headings should be plain text - avoid adding unrelated markup to headings or using headings as links or including linked or other non-heading text within a heading.


