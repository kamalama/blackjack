#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('end', =>
      @get('dealerHand').findWhere({revealed:false}).set('revealed', true)
      @get('dealerHand').dealerHit()
      @trigger 'winner', @determineWinner()
      )
    @get('playerHand').on('lose', =>
      @trigger 'winner', @determineWinner()
      )
    undefined

  determineWinner: ->
    playerScore = @get('playerHand').checkScore()
    dealerScore = @get('dealerHand').checkScore()
    if (playerScore < 21 and playerScore > dealerScore)
      "player"
    else if (playerScore < 21 and playerScore < dealerScore and dealerScore <= 21)
      "dealer"
    else if (dealerScore <= 21 and playerScore > 21)
      "dealer"
    else if (dealerScore == playerScore)
      if (dealerScore > 21)
        "none"
      if (@get('dealerHand').length == 2 && @get('playerHand').length > 2)
        "dealer"
      if (@get('playerHand').length == 2 && @get('dealerHand').length > 2)
        "player"
    else if (dealerScore >21 && playerScore >21)
      "none"


# http://www.youtube.com/watch?v=0D_81DcOSPE&feature=youtu.be&t=28s