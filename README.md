# Kanban Tool

A Ruby wrapper library for accessing the [Kanban Tool API][kt-api].

> Note: this is currently a limited, read-only interface.  Contributions
> to extend the functionality are welcome.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kanbantool'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install kanbantool
```

## Usage

Make sure you have an [API key][get-key], then create a client:

```ruby
client = KanbanTool::Client.new(SUBDOMAIN, API_KEY}
```

You can then call methods on the client to retrieve data from the API:

```ruby
# Retrieve an array of all boards under this account
client.boards #=> [#<KanbanTool::Board:0x00 ...>, ...]

# Retrieve a single board, including stages
client.board(BOARD_ID) #=> #<KanbanTool::Board:0x00 ...>

# Retrieve an array of all tasks for a specific board
client.tasks(BOARD_ID) #=> [#<KanbanTool::Task:0x00 ...>, ... ]
```

## Contributing

1. [Fork it][fork-it]
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes and tests (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[kt-api]: http://kanbantool.com/about/api
[get-key]: http://gppmt.kanbantool.com/profile/api_token
[fork-it]: https://github.com/timblair/kanbantool/fork
