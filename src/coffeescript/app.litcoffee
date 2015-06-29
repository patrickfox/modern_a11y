	app = angular.module("modern_a11y", ["ngRoute"])
	app.config [
		"$routeProvider"
		($routeProvider) ->
			$routeProvider.when("/",
				templateUrl: "home.html"
				controller: "PageCtrl"
			).when("/contact",
				templateUrl: "contact.html"
				controller: "PageCtrl"
			).when("/blog/:post_name",
				templateUrl: (params)->
					'/articles/' + params.post_name
				controller: "PageCtrl"
			).when("/faq",
				templateUrl: "faq.html"
				controller: "PageCtrl"
			).when("/about",
				templateUrl: "about.html"
				controller: "PageCtrl"
			).when("/services",
				templateUrl: "services.html"
				controller: "PageCtrl"
			).when("/blog",
				templateUrl: "blog.html"
				controller: "PageCtrl"
			).when("/blog/post",
				templateUrl: "blog_item.html"
				controller: "PageCtrl"
			).otherwise "/404",
				templateUrl: "home.html"
				controller: "PageCtrl"
	]

	app.controller "PageCtrl", ($scope, $location, $http) ->
		$scope.$on '$viewContentLoaded', announce_view_loaded
		$scope.$on '$viewContentLoaded', init_components
		return

	site_title = 'Modern Accessibility - '

	announce_view_loaded = ->
		#return
		page_title_el = $('main [data-page-title]')
		if page_title_el?
			page_title = page_title_el.data('page-title') || page_title_el.html()
		else 
			page_title 'page title not set'
		set_title_and_announce_page_load(page_title)

	init_components = ->
		$('[data-drop-down]').each ->
			container = $(@)
			unless container.data('drop-down')
				container.dropdown()

	set_title_and_announce_page_load = (page_title) ->
		page_title = site_title + page_title
		$('title').html(page_title)
		$('#main_content').access(true)
		$.announce(page_title + ' page loaded', 'assertive')
		return


