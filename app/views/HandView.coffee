class window.HandView extends Backbone.View

  className: 'hand'

  template: Handlebars.compile $("#hand-template").html()

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el