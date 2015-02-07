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

(function() {
  var _guid;

  _guid = 0;

  $.get_guid = function(return_current) {
    if (!return_current) {
      _guid++;
    }
    return _guid;
  };

}).call(this);

(function() {
  var Modal_Manager;

  Modal_Manager = {
    overlay: null,
    open_button: '[data-opens-modal]',
    close_button: '[data-closes-modal]',
    init: function() {
      var _self;
      _self = this;
      this.content_shell = $('[data-isolate]');
      if (!this.overlay) {
        this.overlay = $('<div id="modal_overlay"></div>').appendTo('body');
      }
      $('body').on('click.modal_open', this.open_button, $.proxy(this.handle_click_open, _self));
      $('body').on('click.modal_close', this.close_button, $.proxy(this.handle_click_close, _self));
      $('body').on('keyup.modal_close', $.proxy(this.handle_keypress, _self));
    },
    handle_click_open: function(e) {
      console.log('handle_click_open');
      this.modal_id = $(e.target).data('opens-modal');
      this.shell = $('[data-modal-id="' + this.modal_id + '"]');
      this.open();
    },
    handle_click_close: function(e) {
      console.log('handle_click_close');
      if ($(e.target).is('[data-closes-modal]')) {
        this.close();
      }
    },
    handle_keypress: function(e) {
      var key;
      key = e.keyCode;
      if (key === 27) {
        if (this.modal_active === false) {
          return;
        }
        this.close();
      }
    },
    open: function() {
      this.isolate();
      this.label_shell();
      this.shell.show();
      this.overlay.show();
      this.shell.access();
      this.position();
    },
    close: function() {
      var lastly, _self;
      _self = this;
      lastly = function() {
        return $('[data-opens-modal="' + _self.modal_id + '"]').focus();
      };
      this.isolate(true);
      this.shell.hide();
      this.overlay.hide();
      setTimeout(lastly, 0);
    },
    position: function() {
      var width, window_width;
      width = this.shell.width();
      window_width = $(window).width();
      return this.shell.css({
        'left': ((window_width - width) / 2) + 'px'
      });
    },
    label_shell: function() {
      var label_ids, labels;
      if (!this.shell.is('[aria-labelledby]')) {
        labels = this.shell.find('[data-modal-label]');
        label_ids = [];
        labels.each(function() {
          var id, label;
          label = $(this);
          id = 'modal_label_' + $.get_guid();
          label.attr('id', id);
          return label_ids.push(id);
        });
        this.shell.attr('aria-labelledby', label_ids.join(' '));
      }
    },
    isolate: function(close) {
      var handle_focusin_body, _self;
      _self = this;
      handle_focusin_body = function(e) {
        if (!$(e.target).parents('[data-modal-id]').length) {
          _self.shell.find(':focusable').focus();
        }
      };
      if (close) {
        this.content_shell.removeAttr('aria-hidden');
        $('body').off('.tabfence');
      } else {
        this.content_shell.attr('aria-hidden', true);
        $('body').on('focusin.tabfence', handle_focusin_body);
      }
    }
  };

  $(function() {
    var modal_mgr;
    modal_mgr = Object.create(Modal_Manager);
    return modal_mgr.init();
  });

}).call(this);
