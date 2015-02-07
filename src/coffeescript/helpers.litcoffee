#Helpers
Global helper functions

##get_guid
Returns a globally unique ID

	_guid = 0

	$.get_guid = (return_current) ->
		unless return_current
			_guid++
		return _guid;