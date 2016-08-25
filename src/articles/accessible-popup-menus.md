---
title: Accessible Popup/Dropdown Menus
filename: accessible-popup-menus
pubdate: 20150104
author: 'Patrick Fox'
draft: false
---

<h2 data-page-title="Accessible Popup Menus">Accessible Dropdown Menus</h2>

Accessible Dropdown Menu example

<div id="event_custom">Event type</div>
<div class="dropdownmenu" data-drop-down="">
	<button data-drop-down-button="" aria-labelledby="selected event_custom"><span id="selected">Select an event</span></button>
	<div data-drop-down-menu="">
		<button data-drop-down-item="">Birthday</button>
		<button data-drop-down-item="">Anniversary</button>
		<button data-drop-down-item="">Engagement</button>
		<button data-drop-down-item="">Party</button>
		<button data-drop-down-item="">Soiree</button>
	</div>
</div>

<form method="post" action="#">
	<label for="event_select">Event Type</label>
	<select id="event_select" class="dropdown-select">
		<option>Birthday</option>
		<option>Anniversary</option>
		<option>Engagement</option>
		<option>Party</option>
		<option>Soiree</option>
	</select>
</form>