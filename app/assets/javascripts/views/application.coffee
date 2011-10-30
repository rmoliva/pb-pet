
LCIberica.namespace("Pet.views.Application")

class Pet.views.Application extends Backbone.View
  events: ->
    # "selectOrg #organizations": "onSelectOrg"

  initialize: ->

  render: ->
    $(@el).html JST['templates/application']()
    this

