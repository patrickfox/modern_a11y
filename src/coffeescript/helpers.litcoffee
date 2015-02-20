#Helpers
Global helper functions

##events

	$.events =
		'window_resize': 'window_resize'



##get_guid
Returns a globally unique ID

	_guid = 0

	$.get_guid = (return_current) ->
		unless return_current
			_guid++
		return _guid;


##PubSub

	do ($) ->
		a = {}
		$.publish = (d, c) ->
			a[d] and $.each(a[d], ->
				if @apply
					@apply $, c or []
				)

		$.subscribe = (c, d) ->
			a[c] = []  unless a[c]
			a[c].push d
			[c, d]

		$.unsubscribe = (event_name, handler) ->
			if a[event_name]
				counter = 0
				for registered_handler in a[event_name]
					if registered_handler is handler then a[event_name].splice counter, 1
					counter++

		$.subscriptions = a

##Throttlr
Emit throttled events on the window

	Throttlr =
		dom_event: null
		timeout: null
		pubsub_event: null
		publish_event: ->
			$.publish @pubsub_event
		on_event: ->
			self_timeout = @timeout
			_self = @
			self_publish_event = ->
				_self.publish_event()
			window.clearTimeout self_timeout
			self_timeout = window.setTimeout self_publish_event, @timeout
		init: (dom_event, publish_event, timeout) ->
			@dom_event = dom_event
			@pubsub_event = publish_event
			@timeout = timeout
			_self = @
			$(window).on @dom_event, $.proxy(@on_event, _self)
		create: (dom_event, publish_event, timeout) ->
			instance = Object.create(Throttlr)
			return instance.init(dom_event, publish_event, timeout)

	window_resize = Throttlr.create('resize', $.events.window_resize, 100)


