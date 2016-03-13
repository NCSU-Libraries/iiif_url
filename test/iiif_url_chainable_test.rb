require 'test_helper'

class IiifUrlChainableTest < Minitest::Test

  def test_chainable_params
    url = IiifUrl.new
    url.region({x:100, y:200, w: 300, h: 300})
    url.size({w: 150}).format('png')
    expected = "/100,200,300,300/150,/0/default.png"
    assert_equal expected, url.to_s
  end

  def test_chainable_identifier
    url = IiifUrl.new
    url.identifier('abc')
    expected = "/abc/full/full/0/default.jpg"
    assert_equal expected, url.to_s
  end

  def test_chainable_params_with_initial
    url = IiifUrl.new({size: {w: 100}})
    url.format('png')
    url.rotation(180)
    expected = "/full/100,/180/default.png"
    assert_equal expected, url.to_s
  end

end
