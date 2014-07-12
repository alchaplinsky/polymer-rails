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

#### Installation

    $ rails g polymer:install

- This generator adds `//= require polymer/platform` into `application.js` manifest file  
- Creates `app/assets/components` and `application.html` manifest file where you can include all your components.
- Creates `vendor/assets/components` directory for third-party web components.

After running `rails g polymer:install`, add `<%= html_import_tag 'application'%>` line into your layout,
to import web components manifest to your app.

#### Creating a component

    $ rails g polymer:component <component-name>

This generates new `<component-name>` component directory and .html file of the same name under `app/assets/components` folder.

Add your component to manifest file after requiring polymer:

    //
    //= require polymer/polymer
    //= require component-name/component-name

And you can use your component in your application!

See example Rails application here [http://polymer-rails-example.herokuapp.com/](http://polymer-rails-example.herokuapp.com/)

Source code can be found here [https://github.com/alchapone/polymer-rails-example](https://github.com/alchapone/polymer-rails-example)

## Learn more

 Polymer team is working on set of core element which you can learn more about here http://www.polymer-project.org/docs/elements/core-elements.html

 Also you can check out http://customelements.io/ or http://component.kitchen/ to see what components are already built by community.

## Contributing

1. Fork it ( http://github.com/alchapone/polymer-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
