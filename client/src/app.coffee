jQuery ->
  class ListView extends Backbone.View
    el: $ 'body'

    initialize: ->
      _.bindAll @
      @counter = 0
      @render()

    render: ->
      $(@el).append '<button>Add</button>'
      $(@el).append '<ul></ul>'

    addItem: ->
      @counter++
      $('ul').append "<li>Itemo: #{@counter}</li>"

    events: 'click button': 'addItem'

  list_view = new ListView
