# https://github.com/ssorallen/jquery-scrollstop/

$ = jQuery
uid1 = "D" + (+new Date)
uid2 = "D" + ((+new Date) + 1)

special = $.event.special

special.scrollstart =
    setup: ->
        handler = (evt) ->
            args = arguments

            if timer
                clearTimeout timer
            else
                evt.type = "scrollstart"
                $.event.handle.apply @, args

            timer = setTimeout ->
                timer = null
            , special.scrollstop.latency

        $(@).bind("scroll", handler).data uid1, handler

    teardown: ->
        $(@).unbind "scroll", $(@).data uid1

special.scrollstop =
    latency: 250

    setup: ->
        handler = (evt) ->
            args = arguments

            if timer
                clearTimeout timer

            timer = setTimeout ->
                timer = null
                evt.type = "scrollstop"
                $.event.handle.apply @, args
            , special.scrollstop.latency

        $(@).bind("scroll", handler).data uid2, handler

    teardown: ->
        $(@).unbind "scroll", $(@).data uid2
