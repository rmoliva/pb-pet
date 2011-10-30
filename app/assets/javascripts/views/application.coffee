
LCIberica.namespace("Pet.views.Application")

class Pet.views.Application extends Backbone.View
  events: ->
    "click #btn_add": "onBtnAdd"
    "click #btn_sub": "onBtnSub"
    "click #btn_mlt": "onBtnMlt"
    "click #btn_div": "onBtnDiv"

  initialize: ->
    @model.bind('change:result', @showResult, this);
    @render()
    @model.set(result:0)
    
  render: ->
    $(@el).html JST['templates/application']()
    this

  showResult: ->
    $('#opt_result').html @model.get('result')

  getValues: ->
    [parseInt($('#op1').val()), parseInt($('#op2').val())]

  onBtnAdd: ->
    [op1, op2] = @getValues()      
    @model.add(op1, op2)  
  
  onBtnSub: ->
    [op1, op2] = @getValues()
    @model.sub(op1, op2)  
    
  onBtnMlt: ->
    [op1, op2] = @getValues()
    @model.mlt(op1, op2)
    
  onBtnDiv: ->
    [op1, op2] = @getValues()
    @model.div(op1, op2)
    
    
