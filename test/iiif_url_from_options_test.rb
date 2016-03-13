require 'test_helper'

class IiifUrlTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::IiifUrl::VERSION
  end

  def test_creation_of_url_from_string_options
    options = {
      region: 'full',
      size: 'full',
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/full/full/0/default.jpg"
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_creation_of_url_with_identifier
    options = {
      identifier: 'abc',
      region: 'full',
      size: 'full',
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/abc/full/full/0/default.jpg"
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_creation_of_url_from_hash_region_and_size_options
    options = {
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
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_creation_of_url_from_height_size_option
    options = {
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
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_creation_of_url_from_width_and_height_size_option
    options = {
      region: "full",
      size: {w: 200, h: 300},
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/full/200,300/0/default.jpg"
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_creation_of_url_from_pct_region
    options = {
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
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_creation_of_url_from_pct_size
    options = {
      region: "full",
      size: {pct: 25},
      rotation: 0,
      quality: 'default',
      format: 'jpg'
    }
    expected = "/full/pct:25/0/default.jpg"
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_creation_of_url_from_rotation_options
    options = {
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
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_mirror_is_false_if_not_passed_in
    options = {
      region: "full",
      size: "full",
      rotation: { degrees: 180 },
      quality: 'default',
      format: 'png'
    }
    expected = "/full/full/180/default.png"
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_creation_of_url_from_rotation_with_mirror
    options = {
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
    url = IiifUrl.from_options(options)
    assert_equal expected, url
  end

  def test_creation_of_url_with_defaults
    expected = "/full/full/0/default.jpg"
    url = IiifUrl.from_options
    assert_equal expected, url
  end

  def test_passing_in_base_url
    options = {
      identifier: 'abc',
      base_url: "http://example.edu/prefix"
    }
    url = IiifUrl.from_options(options)
    expected = "http://example.edu/prefix/abc/full/full/0/default.jpg"
    assert_equal expected, url
  end

  def test_passing_in_base_url_no_identifier
    options = {
      base_url: "http://example.edu/prefix"
    }
    url = IiifUrl.from_options(options)
    expected = "/full/full/0/default.jpg"
    assert_equal expected, url
  end

end
