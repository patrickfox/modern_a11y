#Accordion
Each Accordion has the following:
-Button - the button that toggles the display of the collpasible container
-Accordion container - the container that hides/shows when the button is clicked

##Accessibility features
Button
The button has the following states:
- aria-expanded
- aria-haspopup

	
	Accordion =
		init: (container)->
			_self = @
			@.container = container
			@.button = @.container.find('[data-button]')
			@.set_aria_attributes()
			@.content = @.container.find('[data-content]')
			@.button.attr('aria-haspopup', 'true')
			@.content.attr('aria-hidden', 'true')
			@.button.on('click', $.proxy(@.onclick_button, _self))
			return @
		
		onclick_button: (e)->
			if @.button.is('')

		set_aria_attributes: ->
			expanded = false
			if @.button.is('[aria-expanded]') && @.button.attr('aria-expanded')
				expanded = true
			@.button.is('[aria-expanded]', expanded)

	$.fn.Accordion
		unless $(@).data('accordion')
			accordion = Object.create(Accordion)
			$(@).data('accordion') = accordion.init($(@))
		@