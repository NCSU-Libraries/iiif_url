require 'test_helper'

class IiifUrlTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::IiifUrl::VERSION
  end

  def test_creation_of_url_from_string_params
    params = {
      region: 'full',
      size: 'full',
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/full/full/0/default.jpg"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_creation_of_url_with_identifier
    params = {
      identifier: 'abc',
      region: 'full',
      size: 'full',
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/abc/full/full/0/default.jpg"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_creation_of_url_from_hash_region_and_size_params
    params = {
      region: {
        x: 0,
        y: 0,
        w: 1000,
        h: 1200
      },
      size: {w: 300},
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/0,0,1000,1200/300,/0/default.jpg"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_creation_of_url_from_height_size_option
    params = {
      region: {
        x: 0,
        y: 0,
        w: 1000,
        h: 1200
      },
      size: {h: 300},
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/0,0,1000,1200/,300/0/default.jpg"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_creation_of_url_from_width_and_height_size_option
    params = {
      region: "full",
      size: {w: 200, h: 300},
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/full/200,300/0/default.jpg"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_creation_of_url_from_pct_region
    params = {
      region: {
        pctx: 0,
        pcty: 0,
        pctw: 1000,
        pcth: 1200
      },
      size: "full",
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/pct:0,0,1000,1200/full/0/default.jpg"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_creation_of_url_from_pct_size
    params = {
      region: "full",
      size: {pct: 25},
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/full/pct:25/0/default.jpg"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_creation_of_url_from_rotation_params
    params = {
      region: "full",
      size: "full",
      rotation: {
        degrees: 180,
        mirror: false
      },
      quality: 'default',
      format: 'png'
    }
    expected = "/full/full/180/default.png"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_mirror_is_false_if_not_passed_in
    params = {
      region: "full",
      size: "full",
      rotation: { degrees: 180 },
      quality: 'default',
      format: 'png'
    }
    expected = "/full/full/180/default.png"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_creation_of_url_from_rotation_with_mirror
    params = {
      region: "full",
      size: "full",
      rotation: {
        degrees: 180,
        mirror: true
      },
      quality: 'default',
      format: 'png'
    }
    expected = "/full/full/!180/default.png"
    url = IiifUrl.from_params(params)
    assert_equal expected, url
  end

  def test_creation_of_url_with_defaults
    expected = "/full/full/0/default.jpg"
    url = IiifUrl.from_params
    assert_equal expected, url
  end

  def test_passing_in_base_url
    params = {
      identifier: 'abc',
      base_url: "http://example.edu/prefix"
    }
    url = IiifUrl.from_params(params)
    expected = "http://example.edu/prefix/abc/full/full/0/default.jpg"
    assert_equal expected, url
  end

  def test_passing_in_base_url_no_identifier
    params = {
      base_url: "http://example.edu/prefix"
    }
    url = IiifUrl.from_params(params)
    expected = "/full/full/0/default.jpg"
    assert_equal expected, url
  end

end
