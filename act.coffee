window.Act = (init_state, timeout) -> 
	if (not(Imuta.is_number(timeout)) or (timeout <= 0)) then throw(new Error("Act timeout is number >= 0"))
	obj = {
		#
		#	priv
		#
		state: Imuta.clone(init_state)
		queue: []
		init: () -> 
			try
				@state = Imuta.clone(@queue.shift()(@state)) while @queue.length != 0
			catch error
				console.log "Actor error"
				console.log error
			this_ref = this
			setTimeout((() -> this_ref.init()), timeout)
		#
		#	public
		#
		cast: (func) -> 
			if (func.length == 1) and Imuta.is_function(func)
				@queue.push(Imuta.clone(func))
				@queue.length
			else
				throw(new Error("Act expects functions arity == 1 (single arg is actor's state)"))
		zcast: (func) ->
			if (func.length == 0) and Imuta.is_function(func)
				@queue.push( ((state) -> Imuta.clone(func)(); state) )
				@queue.length
			else
				throw(new Error("Act expects functions arity == 0"))
		get: () ->
			Imuta.clone(@state)
	}
	obj.init()
	obj
#module.exports = Act