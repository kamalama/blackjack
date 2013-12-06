class window.AppView extends Backbone.View

  className: 'app'

  template: Handlebars.compile $("#app-template").html()

  events:
    "click .hit-button": -> @model.get('playerHand').hitDat()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: -> 
    @render()
    @model.on('winner', (winner)=>@playWinnerVideo(winner))

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  playWinnerVideo: (winner) ->
    # body = $('body')
    switch winner
      when 'player' then $('body').html('<iframe width="640" height="480" src="http://www.youtube.com/embed/vPGTizdGwSc&amp;autoplay=1" frameborder="0" allowfullscreen></iframe>')
      when 'dealer' then $('body').html('<iframe width="853" height="480" src="http://www.youtube.com/embed/0D_81DcOSPE?t=28s&amp;autoplay=1" frameborder="0" allowfullscreen></iframe>')
      when 'none'   then $('body').html('<iframe width="640" height="480" src="http://www.youtube.com/embed/vQTp8Ozj1JQ&amp;autoplay=1" frameborder="0" allowfullscreen></iframe>')
