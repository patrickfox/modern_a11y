#Carousel
Each carousel has the following:
-carousel container - the outermost container of the carousel UI
-buttons - left and right arrows allow the user to navigate through the carousel items

##Accessibility features
	
	Carousel =
		init: (container)->
			_self = @
			@.current_item = 0
			@.container = container
			@.items = @.container.find('a')
			@.item_width = @.items.eq(0).width()
			@.arrows = @.container.find('button')
			id = 'carousel_' + new Date().getTime()
			@.container.data('carousel', id)
			@.arrows.on('click', $.proxy(_self.onclick_carousel_arrow, _self))
			return @
		
		onclick_carousel_arrow: (e)->
			direction = $(e.target).data('type')
			@.update_carousel(direction is 'right'? 1 : -1)


		update_carousel: (value)->
			return

	$.fn.Carousel
		unless $(@).data('carousel')
			carousel = Object.create(Carousel)
			$(@).data('carousel') = carousel.init()
		@