LCIberica.namespace("Pet.todo.collections.TodoList")

# Todo Collection
# ---------------

# The collection of todos is backed by *localStorage* instead of a remote
# server.

class Pet.todo.collections.TodoList extends Backbone.Collection
  # Reference to this collection's model.
  model: Pet.todo.models.Todo

  # Save all of the todo items under the `"todos"` namespace.
  localStorage: new Store("todos")

  # Filter down the list of all todo items that are finished.
  done: ->
    @filter((todo) -> todo.get('done'))
    
  # Filter down the list to only todo items that are still not finished.
  remaining: ->
    @without.apply(this, this.done())

  # We keep the Todos in sequential order, despite being saved by unordered
  # GUID in the database. This generates the next order number for new items.
  nextOrder: ->
    return 1 if !@length
    @last().get('order') + 1

  # Todos are sorted by their original insertion order.
  comparator: (todo) ->
    todo.get('order')

