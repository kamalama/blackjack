class window.CardView extends Backbone.View

  className: 'card'

  template: Handlebars.compile $("#card-template").html()

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
