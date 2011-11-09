LCIberica.namespace("Pet.todo.views.Application")


# The Application
# ---------------

# Our overall **AppView** is the top-level piece of UI.
class Pet.todo.views.Application extends Backbone.View
  # Instead of generating a new element, bind to the existing skeleton of
  # the App already present in the HTML.
  el: $("#todoapp")

  # Delegated events for creating new items, and clearing completed ones.
  events: ->
    "keypress #new-todo":  "createOnEnter"
    "keyup #new-todo":     "showTooltip"
    "click .todo-clear a": "clearCompleted"

  # At initialization we bind to the relevant events on the `Todos`
  # collection, when items are added or changed. Kick things off by
  # loading any preexisting todos that might be saved in *localStorage*.
  initialize: ->    
    @input = $("#new-todo")
    # Se supone que con eventos de Backbone, esto deberia de funcionar
    @input.keypress(@createOnEnter)
    @input.keyup(@showTooltip)
        
    Todos.bind('add',   @addOne, this)
    Todos.bind('reset', @addAll, this)
    Todos.bind('all',   @render, this)

    Todos.fetch();

  # Re-rendering the App just means refreshing the statistics -- the rest
  # of the app doesn't change.
  render: ->
    $('#todo-stats').html JST['todo/templates/stats'](
      total:      Todos.length,
      done:       Todos.done().length
      remaining:  Todos.remaining().length
    )
    # Se supone que con eventos de Backbone, esto deberia de funcionar
    $('.todo-clear a').click(@clearCompleted)
    return this

  # Add a single todo item to the list by creating a view for it, and
  # appending its element to the `<ul>`.
  addOne: (todo) ->
    view = new Pet.todo.views.TodoView({model: todo})
    $("#todo-list").append(view.render().el)

  # Add all items in the **Todos** collection at once.
  addAll: ->
    Todos.each(@addOne)

  # If you hit return in the main input field, and there is text to save,
  # create new **Todo** model persisting it to *localStorage*.
  createOnEnter: (e) ->
    input = $("#new-todo")
    text = input.val()
    return if (!text || e.keyCode != 13)
    Todos.create(text: text)
    input.val('')

  # Clear all done todo items, destroying their models.
  clearCompleted: -> 
    _.each(Todos.done(), (todo) -> todo.destroy())
    false

  # Lazily show the tooltip that tells you to press `enter` to save
  # a new todo item, after one second.
  showTooltip: (e) ->
    input = $("#new-todo")
    tooltip = $(".ui-tooltip-top")
    val = input.val()
    tooltip.fadeOut();
    clearTimeout(@tooltipTimeout) if (@tooltipTimeout)
    return if (val == '' || val == input.attr('placeholder'))
    show = () -> tooltip.show().fadeIn()
    @tooltipTimeout = _.delay(show, 1000)

