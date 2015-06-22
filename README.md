
Act
===

This small lib provides almost pure erlang-style actors in js.

Install
-------

```
bower install act --save
```

Usage
-----

```
worker = new Act(init_state, timeout)
worker.cast((state) -> do_work(state))
worker.zcast(() -> do_other_work())
worker.get()
```
Where:

- init_state : any js term
- timeout : timeout of processing queue in ms
- "cast" function gets one arg : function of prev state that must return new state. "cast" will return queue length
- "zcast" function's arity is 0 : it only execute something, not change inner state. "zcast" will return queue length
- "get" function returns current state value

WARNING
-------

```
Avoid cyclic references!!!
```