class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    if not @isDealer and @checkScore() > 21
      @trigger('lose', @)

  scores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  checkScore: ->
    score = @scores()
    if score.length == 2
      if _.max(score) > 21 and _.min(score) <= 21
        _.min(score)
      else if _.max(score) <= 21
        _.max(score)
      else
        _.min(score)
    else
      score

  dealerHit: ->
    check = @checkScore()
    while check < 17
      @hit()
      check = @checkScore()

  stand: ->
    @trigger('end', @)

  hitDat: ->
    if @checkScore() <= 21
      @hit()
