# Polymer-Rails
Want to get started with  [web components](http://www.w3.org/wiki/WebComponents/)? Want to bring them into your Rails app? Easily build your own and use web components that are built by community in your Ruby on Rails Application. Poymer-rails helps you to do this:

1. Adds [polymer](http://polymer-project.org/) library to assets of your rails project.

2. Allows you to easily import web component with `<%= html_import_tag "my-component" %>` helper.

3. Allows you to import and package web components into assets pipeline, exactly as you would Javascript or CSS

#### Prefer using SASS or CoffeeSript?

Polymer-rails works well with compiling assets, such as CoffeeScript and Sass.
You can easily use external stylesheet or script tag references in your web component with any extension that Sprockets recognize.
Use `<link rel="stylesheet" href="application.sass">` for stylesheets and `<script src="application.coffee">` for javascripts.
This assets will be automatically compiled and required into component html file.



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

Add your component to manifest file after requiring webcomponents:

    //
    //= require polymer/webcomponents
    //= require component-name/component-name

And you can use your component in Rails application!

#### Polymer core/paper elements

Polymer team is working on set of core element which you can learn more about here http://www.polymer-project.org/docs/elements/core-elements.html. If you want to use them in your Rails application, checkout [polymer-core-rails](https://github.com/alchapone/polymer-core-rails) gem.

You may also be interested in Polymer paper elements, they are also available as [polymer-paper-rails](https://github.com/alchapone/polymer-paper-rails) gem.

## Example

See example Rails application here [http://polymer-rails-example.herokuapp.com/](http://polymer-rails-example.herokuapp.com/)

Source code can be found here [https://github.com/alchapone/polymer-rails-example](https://github.com/alchapone/polymer-rails-example)

## Learn more

 You can check out http://customelements.io/ or http://component.kitchen/ to see what components are already built by community.

## Contributing

1. Fork it ( http://github.com/alchapone/polymer-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
