# Polymer::Rails

Adds [polymer](http://polymer-project.org/) to your rails project to help in building [web components](http://www.w3.org/TR/components-intro/).

Easily import web component with `<%= html_import_tag "my-component" %>`.

## Installation

Add this line to your application's Gemfile:

    gem 'polymer-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install polymer-rails

## Usage

    $ rails g polymer:install

This generator adds `//= require polymer/platform` into `application` manifest file, and creates
`app/assets/components` and `vendor/assets/components` directories for your and third-party web components.

    $ rails g polymer:component <component-name>

This generates new `<component-name>` component directory and .html file of the same name under `app/assets/components` directory.

Under `app/assets/components` directory you can now build your web components.

See example Rails application here [http://polymer-rails-example.herokuapp.com/](http://polymer-rails-example.herokuapp.com/)

Source code can be found here [https://github.com/alchapone/polymer-rails-example](https://github.com/alchapone/polymer-rails-example)

## Contributing

1. Fork it ( http://github.com/alchapone/polymer-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
