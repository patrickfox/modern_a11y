#Carousel
Each carousel has the following:
-carousel container - the outermost container of the carousel UI
-buttons - left and right arrows allow the user to navigate through the carousel items

##Accessibility features
	

	Carousel_Manager =
		carousels: {}
		init: ->
			carousels = $('[data-carousel]')
			carousels.each( ()->
				container = $(this)
				return if container.data('carousel')
				carousel = Object.create(Carousel)
				carousel.init(container)
			)
	
	Carousel =
		init: (container)->
			_self = @
			@.container = container
			@.items = @.container.find('a')
			@.item_width = @.items.eq(0).width()
			@.arrows = @.container.find('button')
			id = 'carousel_' + new Date().getTime()
			carousel_mgr.carousels[id] = _self
			@.container.data('carousel', id)
			@.arrows.on('click', $.proxy(_self.onclick_carousel_arrow, _self))
		onclick_carousel_arrow: (e)->
			direction = $(e.target).data('type')

	$( ->
		window.carousel_mgr = Carousel_Manager
	)