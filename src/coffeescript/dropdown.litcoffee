<a name="top">
# Drop Down
Enhances elements of the interface that resemble native HTML selects
in their appearance and expected behavior. Examples of this include the
card selector and the question selector in the FAQ module.

**[NB]**: In cases where it is necessary to remove an item from the dropdown list
upon selection, use of the **[data-disabled]** attribute can facilitate this.


    class DropDown

        keys =
          arrow_up: 38
          arrow_down: 40
          enter: 13
          esc: 27
          space_bar: 32
          tab: 9

        # Create an array of the key codes for convenience
        array_of_keys = $.map keys, (value, key) -> value

        constructor: (@house) ->
          @drop_down_button      = $ '[data-drop-down-button]', @house
          @drop_down_menu        = $ '[data-drop-down-menu]', @house
          @drop_down_elements    = $ '[data-drop-down-button], [data-drop-down-menu], [data-drop-down-item]', @house

          do @poll_drop_down_menu_items

          # Set ARIA attributes
          guid = $.get_guid true

          @drop_down_button
            .attr('aria-haspopup', true)
            .attr('aria-owns', "menu_#{guid}")
            .attr('aria-expanded', false)

          @drop_down_menu
            .attr('id', "menu_#{guid}")
            .attr('aria-hidden', true)

          @drop_down_menu_items
            .attr('role', 'menuitem')
            .attr('tabindex', -1)

          # Event bindings
          @house.on 'keydown.dropdown keyup.dropdown', @navigate_via_keyboard
          @drop_down_button.on 'click.dropdown', @toggle_drop_down_menu
          @drop_down_menu_items.on 'click.dropdown', @choose_menu_item

[Back to top](#top)

##poll_drop_down_menu_items()

        poll_drop_down_menu_items: =>
          @drop_down_menu_items  = $('[data-drop-down-item]:not([data-disabled])', @drop_down_menu)

[Back to top](#top)

##toggle_drop_down_menu()

        toggle_drop_down_menu: (event, do_expand = @drop_down_button.attr('aria-expanded').toLowerCase() isnt 'true') =>
          target = $ event.target

          do @poll_drop_down_menu_items
          @drop_down_button.attr 'aria-expanded', do_expand
          @drop_down_menu.attr 'aria-hidden', not do_expand

          if do_expand
            do @drop_down_button.focus
            active_menu_item = @drop_down_menu_items.filter('.active')
            if active_menu_item.length is 0
              active_menu_item = @drop_down_menu_items.first().addClass('active')
            do active_menu_item.focus if active_menu_item
            @drop_down_button.trigger 'expand'
            $(document).on 'activity.dropdown', @check_if_menu_should_collapse

          else
            $(document).off 'activity.dropdown', @check_if_menu_should_collapse
            do @drop_down_button.focus if @drop_down_button and (not $(document.activeElement).is(':focusable') or $(document.activeElement).is(@drop_down_menu_items))
            @drop_down_button.trigger 'contract'
            
[Back to top](#top)

##choose_menu_item()

        choose_menu_item: (event) =>
          chosen_menu_item = if event.type is 'click' then $(event.currentTarget) else $(event.target)
          @drop_down_button.find('span').text(chosen_menu_item.text())
          chosen_menu_item.trigger 'choose'
          @toggle_drop_down_menu event, false

[Back to top](#top)

##navigate_via_keyboard()

        navigate_via_keyboard: (event) =>
          target        = $ event.target
          key_pressed   = event.which

          return true unless $.inArray(key_pressed, array_of_keys) > -1

          if target.is @drop_down_button
            switch key_pressed

              when keys.enter, keys.space_bar
                @toggle_drop_down_menu event if event.type is 'keyup'
                return false

          else if target.is @drop_down_menu_items
            switch key_pressed

              when keys.esc
                if event.type is 'keyup'
                  @toggle_drop_down_menu event, false
                  do @drop_down_menu.focus
                return false

              when keys.enter, keys.space_bar
                @choose_menu_item event if event.type is 'keyup'
                return false

              when keys.arrow_up, keys.arrow_down
                if event.type is 'keyup'
                  @move_focus if key_pressed is keys.arrow_up then 'up' else 'down'
                return false

              when keys.tab
                return false

          true

[Back to top](#top)

##move_focus()

        move_focus: (direction) =>
          do @poll_drop_down_menu_items
          current_tab_index   = @drop_down_menu_items.index document.activeElement
          new_tab_index       = if direction is 'up' then current_tab_index - 1 else current_tab_index + 1

          if new_tab_index < 0
            new_tab_index = @drop_down_menu_items.length - 1

          else if new_tab_index >= @drop_down_menu_items.length
            new_tab_index = 0

          do @drop_down_menu_items.removeClass('active').eq(new_tab_index).addClass('active').focus

[Back to top](#top)

##check_if_menu_should_collapse()

        check_if_menu_should_collapse: (event) =>
          active_element = $ document.activeElement
          expanded       = @drop_down_button.attr('aria-expanded').toLowerCase() is 'true'

          if expanded and not active_element.is(@drop_down_menu_items) and not active_element.is(@drop_down_button)
            @toggle_drop_down_menu(event, false)

[Back to top](#top)

#jQuery extension:

        $.fn.dropdown = ->
          unless $(@).data 'drop_down'
            $(@).data 'drop_down', new DropDown $ @
          @

[Back to top](#top)