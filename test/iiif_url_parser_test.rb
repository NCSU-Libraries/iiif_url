require 'test_helper'

class IiifUrlTest < Minitest::Test

  def test_parsing_simple_url
    params = IiifUrl.parse("http://example.org/prefix/abc/full/full/0/default.png")
    expected = {
      identifier: 'abc',
      region: "full",
      size: "full",
      rotation: {degrees: 0, mirror: false},
      quality: 'default',
      format: 'png'
    }
    assert_equal expected, params
  end

  def test_parsing_simple_path_with_identifier
    params = IiifUrl.parse("/abc/full/full/0/default.png")
    expected = {
      identifier: 'abc',
      region: "full",
      size: "full",
      rotation: {degrees: 0, mirror: false},
      quality: 'default',
      format: 'png'
    }
    assert_equal expected, params
  end

  def test_parsing_simple_path_without_identifier
    params = IiifUrl.parse("/full/full/0/default.png")
    expected = {
      identifier: nil,
      region: "full",
      size: "full",
      rotation: {degrees: 0, mirror: false},
      quality: 'default',
      format: 'png'
    }
    assert_equal expected, params
  end

  def test_parsing_parameterized_path_without_identifier
    params = IiifUrl.parse("/0,100,200,300/75,/0/default.jpg")
    expected = {
      identifier: nil,
      region: {x:0, y:100, w: 200, h: 300},
      size: {w: 75, h: nil},
      rotation: {degrees: 0, mirror: false},
      quality: "default",
      format: "jpg"
    }
    assert_equal expected, params
  end

  def test_parsing_pcts
    params = IiifUrl.parse("/pct:0,100,200,300/pct:75/0/default.jpg")
    expected = {
      identifier: nil,
      region: {pctx:0, pcty:100, pctw: 200, pcth: 300},
      size: {pct: 75},
      rotation: {degrees: 0, mirror: false},
      quality: "default",
      format: "jpg"
    }
    assert_equal expected, params
  end

end
