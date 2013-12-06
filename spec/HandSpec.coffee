describe 'hand', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'checkScore', ->
    describe "when player 'hits'", ->

      it "should check the player's score ", ->
        spyOn(Hand.prototype, "checkScore").andCallThrough()
        hand.hit()
        expect(Hand.prototype.checkScore).toHaveBeenCalled()

      it "should tell us if the score is over 21", ->
        fakeCard1 = new Card rank: 10, suit: 0
        fakeCard2 = new Card rank: 10, suit: 1
        fakeCard3 = new Card rank: 10, suit: 2

        hand = new Hand([fakeCard1], deck)
        expect(hand.checkScore()).toEqual(hand.scores());
        hand = new Hand([fakeCard1,fakeCard2], deck)
        expect(hand.checkScore()).toEqual(hand.scores());
        hand = new Hand([fakeCard1,fakeCard2, fakeCard3], deck)
        expect(hand.checkScore()).toEqual(false);

      it "should not make a player lose if the player has an Ace and two cards summing greater than 11", ->
        fakeCard1 = new Card rank: 1, suit: 1
        fakeCard2 = new Card rank: 10, suit: 2
        hand = new Hand([fakeCard1,fakeCard2], deck)
        expect(hand.checkScore()).toEqual(21);
        fakeCard2 = new Card rank: 10, suit: 2
        fakeCard3 = new Card rank: 7, suit: 3
        hand = new Hand([fakeCard1,fakeCard2, fakeCard3], deck)
        expect(hand.checkScore()).toEqual(18);
        fakeCard2 = new Card rank: 11, suit: 2
        fakeCard3 = new Card rank: 10, suit: 3
        fakeCard4 = new Card rank: 10, suit: 0
        hand = new Hand([fakeCard1,fakeCard2, fakeCard3, fakeCard4], deck)
        expect(hand.checkScore()).toEqual(false);

      it "should make the dealer hit if score is under 17", ->
        fakeCard1 = new Card rank: 2, suit: 1
        fakeCard2 = new Card rank: 9, suit: 2
        fakeCard3 = new Card rank: 6, suit: 2

        spyOn(Hand.prototype, "hit").andCallThrough()
        dealer = new Hand [ fakeCard1, fakeCard2 ], deck, true

        dealer.dealerHit()
        expect(Hand.prototype.hit).toHaveBeenCalled()

        Hand.prototype.hit.reset()

        dealer = new Hand [ fakeCard1, fakeCard2, fakeCard3 ], deck, true
        dealer.dealerHit()
        expect(Hand.prototype.hit).not.toHaveBeenCalled()



