---
title: Live Region Best Practices
filename: announce-this
pubdate: 20150628
author: 'Patrick Fox'
draft: true
---



#Announcing content with ARIA Live Regions



##How Live Regions Work






##Best Practices

###Use sparingly for pertinent messages
ARIA live regions provide a powerful means for announcing messages dynamically to users.

- Improve awareness and understanding
Pertinent UI changes and time-sensitive updates or messages should be brought to the user's attention.

###Use a single Live Region

Live regions are very powerful means to announce content to users without moving their focus, but uncontrolled use can lead to added code complexity and maintenance issues.

Allowing developers, especially on larger teams, to use live regions ad hoc can causes unintended issues. Managing multiple live regions in a page can create headaches. 

Only one live region can be heard at a time. As a best practice, use a single, common live region to speak all user messages. Any message that needs to be announced can simply be added to this common live region.


###How $.announce() works


-live region must be in the page at DOM load or very shortly thereafter
-with dynamic views(e.g. single page apps or dynamic UI), dynamically created live regions do not work in some screen reader/browser combinations(namely VoiceOver)
-reset live region before each message is announced
-clear live region content after brief pause


####Queuing Messages
At this time, there is not a way to queue messages other than to use ```aria-live="polite"```


##Live Region Support




##Announcing Content

ARIA live regions provide a powerful means for announcing messages dynamically to users.

- Improve awareness and understanding
Pertinent UI changes and time-sensitive updates or messages should be brought to the user's attention.

##Implementation Best Practices


