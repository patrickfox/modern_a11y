---
title: Using aria-describedby for improved form help
filename: aria-describedby-for-improved-form-help
pubdate: 20160830
author: 'Patrick Fox'
---

## Using aria-describedby for improved form help

In response to a Jeremy Keith article on [using aria-describedby for text input helper text](https://adactio.com/journal/11109).

The question: is it better to include helper text in the field `<label>` or to use `aria-describedby`.

The short answer is: it's complicated. Let's look at the options.


<iframe height='350' scrolling='no' src='//codepen.io/adactio/embed/jAXyxP/?height=350&theme-id=0&default-tab=html,result&embed-version=2' frameborder='no' allowtransparency='true' allowfullscreen='true' style='width: 100%;'>See the Pen <a href='http://codepen.io/adactio/pen/jAXyxP/'>Form field accessibility question</a> by Jeremy Keith (<a href='http://codepen.io/adactio'>@adactio</a>) on <a href='http://codepen.io'>CodePen</a>.
</iframe>

**Helper text in Label**

This option adds the helper text into the label and positions the text below the field. The user hears a single sentence: "Email must include the @ symbol" before hearing the indication that this is a text field: "edit text"



**Helper text via aria-describedby**

This option uses the aria-describedby attribute to associate the input field with the helper text. The user hears the label ("Email"), text field ("edit text"), and then the helper text. But, VoiceOver has a strange way of handling aria-describedby, wherein it does not read the helper text until after a pause and some instructions, and then says "The help text is: must include the @ symbol".


**Winner: `aria-describedby`** (though, VO could be better...)


### Placeholder Accessibility Concerns

While we're at it... 

The examples in Jeremy's post use the placeholder attribute to add examples, but this arguably adds more problems than it solves.


#### NVDA and JAWS Ignore Placeholder Text

NVDA and JAWS ignore placeholder text, which is ok in this case because we already have helper text. If the placeholder text is truly important, though, this would be a problem.

#### VoiceOver Is Confusing

VoiceOver reads placeholder text as if it were the field value, which is super confusing.

> "e.g. you@example.com Insertion at beginning of text. Email, edit text"

> (pause, followed by verbose explanation, and THEN the helper text)

> "You are currently on a text field, inside of HTML content. To enter text in this field, type. , The help tag is: must include the @symbol"

Placeholder text is also problematic for a few other reasons:

- **Styling** - placeholder text is not easy to style or requires browser specific styles syntax
- **Color Contrast** - placeholder text generally needs to be lighter to be recognized as being placeholder text versus a user-specified value, but lighter text colors often fail the minimum color contrast requirements
- **Flexibility** - the length of placeholder text can vary depending on the translation, and may extend beyond the width of the input field

#### Best Approach

<iframe height='500' scrolling='no' src='//codepen.io/pfox/embed/BLBdGJ/?height=500&theme-id=0&default-tab=html,result&embed-version=2' frameborder='no' allowtransparency='true' allowfullscreen='true' style='width: 100%;'>See the Pen <a href='http://codepen.io/pfox/pen/BLBdGJ/'>Form field accessibility question</a> by Patrick Fox (<a href='http://codepen.io/pfox'>@pfox</a>) on <a href='http://codepen.io'>CodePen</a>.
</iframe>


A better solution would be to forgo using the placeholder attribute and to make a _single_ helper statement, like:

> "Email address must include the @ symbol, For example: you@domain.com"


In summary:

- use `aria-describedby` to associate helper/formatting/instructional text to form fields 
- don't use the `placeholder` attribute

### Other Opinions

(Placeholder Attribute and Why It Is Not Accessible)[http://www.maxability.co.in/2016/01/placeholder-attribute-and-why-it-is-not-accessible/]
(Don't Put Labels Inside Text Boxes)[http://www.uxmatters.com/mt/archives/2013/02/dont-put-labels-inside-text-boxes-unless-youre-luke-w.php]
(Placeholder and Aria-Describedby)[http://www.davidmacd.com/blog/test-placeholder-text-aria-describedby.html]


