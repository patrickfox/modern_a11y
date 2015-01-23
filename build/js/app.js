(function() {
  var announce_view_loaded, app, set_title, site_title;

  app = angular.module("modern_a11y", ["ngRoute"]);

  app.config([
    "$routeProvider", function($routeProvider) {
      return $routeProvider.when("/", {
        templateUrl: "home.html",
        controller: "PageCtrl"
      }).when("/contact", {
        templateUrl: "contact.html",
        controller: "PageCtrl"
      }).when("/blog/:post_name", {
        templateUrl: function(params) {
          return '/articles/' + params.post_name;
        },
        controller: "PageCtrl"
      }).when("/faq", {
        templateUrl: "faq.html",
        controller: "PageCtrl"
      }).when("/about", {
        templateUrl: "about.html",
        controller: "PageCtrl"
      }).when("/services", {
        templateUrl: "services.html",
        controller: "PageCtrl"
      }).when("/blog", {
        templateUrl: "blog.html",
        controller: "PageCtrl"
      }).when("/blog/post", {
        templateUrl: "blog_item.html",
        controller: "PageCtrl"
      }).otherwise("/404", {
        templateUrl: "home.html",
        controller: "PageCtrl"
      });
    }
  ]);

  app.controller("PageCtrl", function($scope, $location, $http) {
    $scope.$on('$viewContentLoaded', announce_view_loaded);
  });

  site_title = 'Modern Accessibility - ';

  announce_view_loaded = function() {
    var page_title;
    page_title = $('main [data-page-title]').data('page-title') || 'page title not set';
    return set_title(page_title);
  };

  set_title = function(page_title) {
    page_title = site_title + page_title;
    $('title').html(page_title);
    $.announce(page_title + ' page loaded', 'assertive');
  };

}).call(this);
