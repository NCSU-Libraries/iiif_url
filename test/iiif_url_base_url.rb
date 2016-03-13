require 'test_helper'

class IiifUrlTest < Minitest::Test
  IIIF_URL_BASE_URL = "http://example.edu/prefix"

  def test_setting_constant
    url = IiifUrl.from_options
    expected = "http://example.edu/prefix/full/full/0/default.jpg"
    assert_equal expected, url
  end

  def test_overriding_constant
    options = {base_url: false}
    url = IiifUrl.from_options(options)
    expected = "/full/full/0/default.jpg"
    assert_equal expected, url
  end


end
