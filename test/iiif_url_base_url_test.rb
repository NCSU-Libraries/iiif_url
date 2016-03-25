require 'test_helper'

class IiifBaseUrlTest < Minitest::Test

  def test_setting_constant
    IiifUrl.set_base_url("http://example.edu/prefix")
    url = IiifUrl.from_params(identifier: 'abc')
    expected = "http://example.edu/prefix/abc/full/full/0/default.jpg"
    assert_equal expected, url
    IiifUrl.set_base_url("")
  end

  def test_overriding_constant_with_false
    IiifUrl.set_base_url("http://example.edu/prefix")
    params = {identifier: 'abc', base_url: false}
    url = IiifUrl.from_params(params)
    expected = "/abc/full/full/0/default.jpg"
    assert_equal expected, url
    IiifUrl.set_base_url("")
  end

  def test_overriding_constant_with_string
    IiifUrl.set_base_url("http://example.edu/prefix")
    params = {identifier: 'abc', base_url: "http://example.org"}
    url = IiifUrl.from_params(params)
    expected = "http://example.org/abc/full/full/0/default.jpg"
    assert_equal expected, url
    IiifUrl.set_base_url("")
  end

  def test_getting_base_url
    expected = "http://example.edu/prefixer"
    IiifUrl.set_base_url(expected)
    assert_equal expected, IiifUrl.base_url
    IiifUrl.set_base_url("")
  end


end
