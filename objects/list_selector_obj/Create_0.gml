/// @description Initialize variable

self.list = noone //List of items to allow selection of
self.type = noone //Type 1 = move selection, 2 = enemy selection, 3 = inventory selection
self.items_shown = 4 //number of items shown at once
self.current = 0 //Current item cursor is on
self.start = 0 //Item to start displaying on
self.initialized = false //Whether or not list was copied and cleaned (if necessary)