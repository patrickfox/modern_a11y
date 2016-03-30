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
			).when("/spelling/:week",
				templateUrl: "spelling.html"
				controller: "SpellingCtrl"
			).otherwise "/404",
				templateUrl: "home.html"
				controller: "PageCtrl"
	]

	app.controller "PageCtrl", ($scope, $location, $http) ->
		$scope.$on '$viewContentLoaded', announce_view_loaded
		$scope.$on '$viewContentLoaded', init_components
		return

	site_title = 'Modern Accessibility with Angular - '

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
		$.announce(page_title + ' page loaded', 'polite')
		return

/*
	app.controller "SpellingCtrl", ($scope, $location, $http) ->
		$scope.$on '$viewContentLoaded', announce_view_loaded
		$scope.$on '$viewContentLoaded', init_components
		$scope.words = get_week(3)
		console.log $scope.words
		return

	words_4 = ['about','actor','agree','airplane','airport','alike','almost','alone','along','aloud','already','army','ate','awake','awhile','bare','baseball','beat','become','bedtime','beef','beet','began','begin','bench','bent','berry','better','birthday','bless','boil','bought','boy','brand','brass','bring','bringing','brush','build','built','burn','bury','bushes','bushy','butter','cannot','can&apos;t','carry','cast','cave','cent','cherries','cherry','chess','chili','chest','choose','churn','clean','cobweb','coil','could','cracker','crazy','cure','curl','cut','daytime','dinner','doesn&apos;t','done','don&apos;t','dozen','draw','drink','dwell','early','earn','eggnog','eight','elbow','elsewhere','employ','enjoy','face','fall','far','fault','fill','fired','fireman','fit','flavor','flow','fray','frost','full','fulfill','gate','gift','glove','glue','goldfish','goose','got','grabbed','grain','greet','guild','grow','guilt','hair','haircut','half','halfway','hang','hare','hobbies','hobby','hold','holiday','hot','huge','hunt','hurry','hurt','if','isn&apos;t','its','it&apos;s','itself','jellyfish','join','jolly','joy','keep','kidnap','kind','ladybug','large','later','laugh','light','long','loss','lung','mailbox','mare','mark','milking','mopped','mouse','mouth','move','much','munch','myself','noontime','never','none','number','oatmeal','only','own','pail','pale ','pancake','past','pear','pest','pick ','pinch','pint','pitch','please','point','popcorn','pound','pray','pretty','price','prize','pure','pushes','queen','queer','quick','quicksand','quiet','quilt','quit','rainstorm','rent','role','round','scarecrow','scarf','search','seven','shall','should','show','six','slight','small','soft','someone','somewhere','sought','sow','spelling','spend','spent','squirt','start','stepped','stopped','strain','stray','stream','street','strike ','studies','study','sugar','sunny','sure','surely','sweet','talk','taught','tear','tearful','ten','thirst','throne','throw','thrown','tipped','today','together','toothpaste','toy','try','turn','twig','underdog','visiting','voice','volleyball','walk','warm','whatever','when','whose','wire','won&apos;t','wood','word','worm','worth','work','worker','worry','wrench','write','wrong','yourself','young','zipped']

	get_week = (week) ->
		words_per_lesson = 14
		max_week = Math.floor(words_4.length % words_per_lesson)
		week = if week < 0 then 0 else if week > max_week then max_week else week
		add_word = (i) ->
			words_for_week.push(words_4[i+week-1])

		words_for_week = []

//		add_word i for i < words_per_lesson

		return words_for_week
*/
