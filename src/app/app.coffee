jQuery ->
  class Item extends Backbone.Model
    defaults:
      first: 'Hello'
      second: 'Backbone'

  class List extends Backbone.Collection
    model: Item

  class ListView extends Backbone.View
    el: $ '#main-container'

    initialize: ->
      _.bindAll @

      @collection = new List
      @collection.bind 'add', @appendItem

      @counter = 0
      @render()

    render: ->
      $(@el).append '<button>Add</button>'
      $(@el).append '<ul></ul>'

    addItem: ->
      @counter++
      item = new Item
      item.set second: "#{item.get 'second'} #{@counter}"
      @collection.add item

    appendItem: (item) ->
      $(@el).find('ul').append "<li>Item: #{item.get 'first'} #{item.get 'second'}</li>"

    events: 'click button': 'addItem'

  list_view = new ListView
