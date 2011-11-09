LCIberica.namespace("Pet.calc.models.Application")

class Pet.calc.models.Application extends Backbone.Model
    defaults: ->
      result: 0

    add: (op1, op2) ->
      @processAjax 'add', op1, op2
      
    sub: (op1, op2) ->
      @processAjax 'sub', op1, op2
      
    mlt: (op1, op2) ->
      @processAjax 'mlt', op1, op2
      
    div: (op1, op2) ->
      @processAjax 'div', op1, op2

    processAjax: (op, op1, op2) ->
      that = this
      $.ajax( 
        type: 'POST'
        url: "/calc"
        dataType: "json"
        data:
          op: op
          op1: op1
          op2: op2
        success: (data) ->
          that.set(data)
      )

