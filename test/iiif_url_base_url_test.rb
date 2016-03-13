require 'test_helper'

class IiifBaseUrlTest < Minitest::Test

  def test_setting_constant
    IiifUrl.set_base_url("http://example.edu/prefix")
    url = IiifUrl.from_options
    expected = "http://example.edu/prefix/full/full/0/default.jpg"
    assert_equal expected, url
    IiifUrl.set_base_url("")
  end

  def test_overriding_constant_with_false
    IiifUrl.set_base_url("http://example.edu/prefix")
    options = {base_url: false}
    url = IiifUrl.from_options(options)
    expected = "/full/full/0/default.jpg"
    assert_equal expected, url
    IiifUrl.set_base_url("")
  end

  def test_overriding_constant_with_string
    IiifUrl.set_base_url("http://example.edu/prefix")
    options = {base_url: "http://example.org"}
    url = IiifUrl.from_options(options)
    expected = "http://example.org/full/full/0/default.jpg"
    assert_equal expected, url
    IiifUrl.set_base_url("")
  end


end
