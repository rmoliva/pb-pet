LCIberica.namespace("Pet.todo.views.TodoView")


# Todo Item View
# --------------

# The DOM element for a todo item...
class Pet.todo.views.TodoView extends Backbone.View
  #... is a list tag.
  tagName:  "li"

  # The DOM events specific to an item.
  events: ->
    "click .check"              : "toggleDone"
    "dblclick div.todo-text"    : "edit"
    "click span.todo-destroy"   : "clear"
    "keypress .todo-input"      : "updateOnEnter"

  # The TodoView listens for changes to its model, re-rendering.
  initialize: ->
    @model.bind('change', @render, this)
    @model.bind('destroy', @remove, this)

  # Re-render the contents of the todo item.
  render: ->
    $(@el).html JST['todo/templates/item'](@model.toJSON())
    @setText()
    this

  # To avoid XSS (not that it would be harmful in this particular app),
  # we use `jQuery.text` to set the contents of the todo item.
  setText: ->
    text = @model.get('text')
    this.$('.todo-text').text(text)
    @input = this.$('.todo-input')
    @input.bind('blur', _.bind(@close, this)).val(text)

  # Toggle the `"done"` state of the model.
  toggleDone: ->
    @model.toggle();

  # Switch this view into `"editing"` mode, displaying the input field.
  edit: ->
    $(@el).addClass("editing")
    @input.focus()

  # Close the `"editing"` mode, saving changes to the todo.
  close: ->
    @model.save(text: @input.val())
    $(@el).removeClass("editing")

  # If you hit `enter`, we're through editing the item.
  updateOnEnter: (e) ->
    @close() if (e.keyCode == 13) 

  # Remove this view from the DOM.
  remove: ->
    $(@el).remove()

  # Remove the item, destroy the model.
  clear: ->
    @model.destroy()
