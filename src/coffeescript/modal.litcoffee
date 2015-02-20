#Modal
Each modal has the following:
-shell - the outermost container of the modal dialog UI
-button - the button the opens the modal

##Accessibility features
-shell has _role=dialog_, and when focused, a screen reader will announce "dialog"
-any elements(s) inside the shell with _data-modal-label_ get a unique id, and this id is dynamically associated with the _aria-labelledby_ on the shell
	

		Modal_Manager =
			overlay: null
			modal_active: false
			open_button: '[data-opens-modal]'
			close_button: '[data-closes-modal]'
			init: ()->
				_self = @
				update_position = ->
					_self.position()
				@.content_shell = $('[data-isolate]')
				unless @.overlay
					@.overlay = $('<div class="hidden" id="modal_overlay"></div>').appendTo('body')
				$('body').on('click.modal_open', _self.open_button, $.proxy(@.handle_click_open, _self))
				$('body').on('click.modal_close', _self.close_button, $.proxy(@.handle_click_close, _self))
				$('body').on('keyup.modal_close', $.proxy(@.handle_keypress, _self))
				$.subscribe($.events.window_resize, update_position)
				return

			handle_click_open: (e)->
				return if @.modal_active
				@.modal_active = true
				@.modal_id = $(e.target).data('opens-modal')
				@.shell = $('[data-modal-id="' + @.modal_id + '"]')
				@.open()
				return

			handle_click_close: (e)->
				return if !@.modal_active
				if $(e.target).is('[data-closes-modal]')
					@.close()
				return

			handle_keypress: (e)->
				key = e.keyCode
				if key is 27
					return if !@.modal_active
					@.close()
				return

			open: ->
				@.isolate()
				@.label_shell()
				@.shell.removeClass('hidden')
				@.overlay.removeClass('hidden')
				@.shell.access()
				@.position()
				return

			close: ->
				_self = @
				lastly = ->
					_self.modal_active = false
					$('[data-opens-modal="' + _self.modal_id + '"]').focus()
					@.shell = null
				@.isolate(true)
				@.shell.addClass('hidden')
				@.overlay.addClass('hidden')
				setTimeout(lastly, 0)
				return

			position: ->
				return if not @.shell?
				@.shell.addClass('testing')
				width = @.shell.width()
				height = @.shell.height()
				window_width = $(window).width()
				window_height = $(window).height()
				@.shell.removeClass('testing')
				pos = {}
				pos.left = ((window_width - width)/2) + 'px'
				pos.top = ((window_height - height)/2) + 'px'
				@.shell.css(pos)

			label_shell: ->
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


### isolate
The isolate method manages 

			isolate: (close) ->
				_self = @
				handle_focusin_body = (e) ->
					unless !!$(e.target).parents('[data-modal-id]').length
						_self.shell.find(':focusable').focus()
					return
				if close
					@.content_shell.removeAttr('aria-hidden')
					#disable tabfence
					$('body').off('.tabfence')
				else
					@.content_shell.attr('aria-hidden', true)
					#enable tabfence
					$('body').on('focusin.tabfence', handle_focusin_body)
				return

		$( ->
			modal_mgr = Object.create(Modal_Manager)
			modal_mgr.init()
		)