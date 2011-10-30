LCIberica.namespace("Pet.models.Application")

class Pet.models.Application extends Backbone.Model
    defaults: ->
      result: 0

    add: (op1, op2) ->
      @set('result': op1 + op2)
      
    sub: (op1, op2) ->
      @set('result': op1 - op2)
      
    mlt: (op1, op2) ->
      @set('result': op1 * op2)
      
    div: (op1, op2) ->
      @set('result': op1 / op2)                  
