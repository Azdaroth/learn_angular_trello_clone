describe 'Main', ->

  beforeEach ->
    browser.get('http://trello_clone.dev/')
    @ptor = protractor.getInstance()

  it "can locate main container", ->
    mainContainer = protractor.By.id('log-in')
    expect(@ptor.isElementPresent(mainContainer)).toBe(true)
