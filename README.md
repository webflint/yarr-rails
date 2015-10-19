# Yarr

A CMS so light, you won't even feel it on your skin.

## Installation

Add the following to your application's Gemfile:

```ruby
gem 'i18n-active_record',
  git: 'git://github.com/svenfuchs/i18n-active_record.git',
  require: 'i18n/active_record'

gem 'yarr' git: 'https://github.com/webflint/yarr.git'
```

And then execute:

    $ bundle

And then run the migrations:

    $ rake yarr_engine:install:migrations db:migrate

And finally:

`require 'yarr'` in your `config/application.rb`

## Usage

Yarr sets up Rails to use a I18 Active Record backend.  Content is saved and delivered
through Rai's I18n class.   To enable Yarr's content editor, Yarr some content in your views:

Ensure `<%= csrf_meta_tags %>` is in the head of your html document.

Replace: `<%= t :'.welcome_html' %> with Yarr: `<%= yarr :'.welcome_html' %>`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/webflint/yarr.

