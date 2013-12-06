describe 'app', ->
  app = new App()
  deck = new Deck()
  fakeCard1 = new Card rank: 10, suit: 0
  fakeCard2 = new Card rank: 2, suit: 1
  fakeCard3 = new Card rank: 10, suit: 2
  fakeCard4 = new Card rank: 1, suit: 2

  describe 'determine winner', ->
    it "should return the winner of the game", ->
      app = new App()
      deck = new Deck()
      app.set("player", new Hand([fakeCard1, fakeCard2], deck))
      app.set("dealer", new Hand([fakeCard1, fakeCard2, fakeCard3], deck, true))
      expect(app.determineWinner()).toEqual("player")

    it "case1", ->
      app = new App()
      deck = new Deck()
      app.set("dealer", new Hand([fakeCard1, fakeCard4, fakeCard3], deck, true))
      app.set("player", new Hand([fakeCard1, fakeCard2], deck))
      expect(app.determineWinner()).toEqual("dealer")

    it "case2", ->
      app = new App()
      deck = new Deck()
      app.set("dealer", new Hand([fakeCard1, fakeCard4], deck, true)) #21
      app.set("player", new Hand([fakeCard2, fakeCard4], deck)) #21
      expect(app.determineWinner()).toEqual("player")

    it "case3", ->
      app = new App()
      deck = new Deck()
      app.set("dealer", new Hand([fakeCard1, fakeCard3], deck, true))
      app.set("player", new Hand([fakeCard1, fakeCard3], deck))
      expect(app.determineWinner()).toEqual("both")

    it "case4", ->
      app = new App()
      deck = new Deck()
      app.set("dealer", new Hand([fakeCard1, fakeCard2, fakeCard3], deck, true))
      app.set("player", new Hand([fakeCard1, fakeCard2, fakeCard3], deck))
      expect(app.determineWinner()).toEqual("none")

