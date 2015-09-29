---
title: Screen Reader Page Load Behaviors
filename: screen-reader-page-load-behaviors
author: 'Patrick Fox'
pubdate: 20150103
summary: 'In an effort to better understand how screen readers communicate page load, I spent some time documenting how various screen reader and browser combinations report that a new page has loaded.'
---

<h2 data-page-title="Screen Reader Page Load Behaviors">Screen Reader Page Load Behaviors</h2>

In an effort to better understand how screen readers communicate page load, I spent some time documenting how various screen reader and browser combinations report that a new page has loaded.

| AT/Browser Combos					| Description
|-----------------------------------|---------------
| VoiceOver(MacOS 10.9) w/Safari	| "{page title} HTML content", reads page from top
| VoiceOver(MacOS 10.9) w/Chrome	| "{page title} HTML content", reads page from top
| VoiceOver(iOS 7) w/Safari			| "{URL} web page loaded", does not auto read
| VoiceOver(iOS 8) w/Safari			| "{URL} web page loaded", does not auto read
| TalkBack(4.4) w/Firefox			| "{page title}", loaded, does not auto read
| NVDA 2014.3(Win7) w/Firefox		| "{page title}", reads page from top
| JAWS 15(Win7) w/IE9				| "{page title}"


