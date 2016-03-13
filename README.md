# IIIF URL

Create and parse IIIF Image API URLs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iiif_url'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iiif_url

## Usage

Here's the simplest case of creating a IIIF URL with all options. By default only the path is given without the scheme, server, port, or IIIF prefix.

```ruby
iiif_base_url = "http://example.edu/prefix"
options = {
  identifier: 'abc',
  region: 'full',
  size: 'full',
  rotation: 0,
  quality: 'default',
  format: 'jpg'
}
url = IiifUrl.from_options(options)
# => "/abc/full/full/0/default.jpg"
full_url = File.join(iiif_base_url, url)
# => "http://example.edu/prefix/full/full/0/default.jpg"
```

If the base URL is set then it will form a full url automatically:

```ruby
IiifUrl.set_base_url("http://example.edu/prefix")
options = {
  identifier: 'abc',
  region: 'full',
  size: 'full',
  rotation: 0,
  quality: 'default',
  format: 'jpg'
}
url = IiifUrl.from_options(options)
# => "http://example.edu/prefix/abc/full/full/0/default.jpg"
```

You can also pass in the base URL in with the options, which will override any value set for the base URL.

```ruby
IiifUrl.set_base_url("http://example.edu/prefix")
options = {
  identifier: 'abc',
  base_url: "http://example.org",
  region: 'full',
  size: 'full',
  rotation: 0,
  quality: 'default',
  format: 'jpg'
}
url = IiifUrl.from_options(options)
# => "http://example.org/abc/full/full/0/default.jpg"
```

If the base URL is set you can prevent it being used and just return the path portion by setting the `base_url` option key to `false`:

```ruby
IiifUrl.set_base_url("http://example.edu/prefix")
options = {
  identifier: 'abc',
  base_url: false,
  region: 'full',
  size: 'full',
  rotation: 0,
  quality: 'default',
  format: 'jpg'
}
url = IiifUrl.from_options(options)
# => "/abc/full/full/0/default.jpg"
```

A more complicated region and size:

```ruby
options = {
  identifier: 'abc',
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
url = IiifUrl.from_options(options)
# => "/abc/0,0,1000,1200/300,/0/default.jpg"
```

To use a percent region or percent size, you must prefix the keys like this:

```ruby
options = {
  identifier: 'abc',
  region: {
    pctx: 10,
    pcty: 10,
    pctw: 80,
    pcth: 80
  },
  size: {pct: 50}
}
url = IiifUrl.from_options(options)
# => "/abc/pct:10,10,80,80/pct:50/0/default.jpg"
```

If no identifier is passed in, then only the IIIF URL path will be returned:

```ruby
options = {
  size: {pct: 50}
}
url = IiifUrl.from_options(options)
# => "/full/pct:50/0/default.jpg"
```

Even if a base_url is given if there is no identifier, then only the IIIF URL path will be returned:

```ruby
options = {
  base_url: "http://example.org/prefix/",
  size: {pct: 50}
}
url = IiifUrl.from_options(options)
# => "/full/pct:50/0/default.jpg"
```


## Defaults

You only need to specify values that are different from the defaults. The defaults are as specified:

| parameter  | value     |
|:-----------|:----------|
| identifier | null      |
| region     | "full"    |
| size       | "full"    |
| rotation   | "0"       |
| quality    | "default" |
| format     | "jpg"     |

```ruby
options = {
  identifier: 'abc',
  size: {w: 600}
}
url = IiifUrl.from_options(options)
# => "/abc/full/600,/0/default.jpg"
```

And without an identifier:

```ruby
options = {
  size: {w: 600}
}
url = IiifUrl.from_options(options)
# => "/full/600,/0/default.jpg"
```

## Chainable

There may be cases where you do not have all of the options you need so you want to pass around a IiifUrl to add more options.

```ruby
url = IiifUrl.new
url.region({x:100, y:200, w: 300, h: 300})
url.size({w: 150}).format('png')
url.to_s
# => "/100,200,300,300/150,/0/default.png"
```

You can also pass in some initial options and then add on others:

```ruby
url = IiifUrl.new({size: {w: 100}})
url.identifier('abc')
url.format('png')
url.rotation(180)
url.to_s
# => "/abc/full/100,/180/default.png"
```

## Parser

IIIF URLs are parsed by segments including: region, size, rotation, quality, and format. The region and size segments can also be parsed into a string or hash. Rotation is always parsed into a hash. Quality and format are always a string.

Simple case for region and size parsed into strings:

```ruby
options = IiifUrl.parse("/full/full/0/default.png")
# => {region: "full", size: "full", rotation: {degrees: 0, mirror: false}, quality: 'default', format: 'png'}
```

With an identifier:

```ruby
options = IiifUrl.parse("/abc/full/full/0/default.png")
# => {identifier: "abc", region: "full", size: "full", rotation: {degrees: 0, mirror: false}, quality: 'default', format: 'png'}
```

Parameterized region and size:

```ruby
options = IiifUrl.parse("/0,100,200,300/75,/0/default.jpg")
# => {identifier: nil, region: {x:0, y:100, w: 200, h: 300}, size: {w: 75, h: nil}, rotation: {degrees: 0, mirror: false}, quality: "default", format: "jpg" }
```

Parse a full URL:

```ruby
options = IiifUrl.parse("http://example.org/prefix/abc/0,100,200,300/75,/0/default.jpg")
# => {identifier: abc, region: {x:0, y:100, w: 200, h: 300}, size: {w: 75, h: nil}, rotation: {degrees: 0, mirror: false}, quality: "default", format: "jpg" }
```

## Validation

No validation is done for creating or parsing a URL. This allows for extensions to the IIIF Image API.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/NCSU-Libraries/iiif_url.

## Authors

Jason Ronallo

## License

The gem is copyright North Carolina State University and is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
