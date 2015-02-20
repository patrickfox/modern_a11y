#Tooltip
Each tooltip has the following:
-shell - the outermost container of the tooltip UI
-button - the button the opens the tooltip

##Accessibility features
	

		Tooltip_Manager =
			overlay: null
			tooltip_active: false
			open_button: '[data-opens-tooltip]'
			init: ()->
				_self = @
				$('body').on('focusin.tooltip_open, mouseenter', @.open_button, $.proxy(@.handle_open, _self))
				$('body').on('focusout.tooltip_open, mouseout', @.open_button, $.proxy(@.handle_close, _self))
				return

			handle_open: (e)->
				return if @.tooltip_active
				@.tooltip_id = $(e.target).data('opens-tooltip')
				@.shell = $('[data-tooltip-id="' + @.tooltip_id + '"]')
				@.open()
				return

			handle_close: (e)->
				return if !@.tooltip_active
				if !$(e.target).is('[data-tooltip-id]')
					@.close()
				return

			handle_keypress: (e)->
				key = e.keyCode
				if key is 27
					return if @.shell.is('.hidden')
					@.close()
				return

			open: ->
				@.position()
				@.shell.removeClass('hidden')
				@.tooltip_active = true
				return

			close: ->
				_self = @
				lastly = ->
					_self.tooltip_active = false
				@.shell.addClass('hidden')
				setTimeout(lastly, 0)
				return

			position: ->
				@.shell.addClass('testing')
				button = $('[data-opens-tooltip="'+@.tooltip_id+'"]')
				position = button.position()
				b_width = button.outerWidth()
				b_height = button.outerHeight()
				t_width = @.shell.outerWidth()
				t_height = @.shell.outerHeight()
				console.log(t_height)
				pos = {}
				pos.top = Math.floor(position.top - t_height - 10) + 'px'
				pos.left = (position.left + (b_width - t_width)/2) + 'px'
				@.shell.css(pos)
				@.shell.removeClass('testing')
				return

			label: (label, labelled)->
				unless @.shell.is('[aria-labelledby]')
					labels = @.shell.find('[data-modal-label]')
					label_ids = []
					labels.each ->
						label = $(this)
						id = 'modal_label_' + $.get_guid()
						label.attr('id', id)
						label_ids.push(id)
					@shell.attr('aria-labelledby', label_ids.join(' '))
				return
		$( ->
			tooltip_mgr = Object.create(Tooltip_Manager)
			tooltip_mgr.init()
		)