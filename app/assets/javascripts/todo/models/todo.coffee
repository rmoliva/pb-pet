LCIberica.namespace("Pet.todo.models.Todo")

class Pet.todo.models.Todo extends Backbone.Model
  # Default attributes for a todo item.
  defaults: ->
    done:  false
    order: Todos.nextOrder()

  # Toggle the `done` state of this todo item.
  toggle: ->
    @save(done: !this.get("done"))

