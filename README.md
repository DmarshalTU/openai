# openai

OpenAI library for Crystal, providing an interface to interact with various OpenAI services.

## Features

- [x] Authentication
- Engine Interaction
  - [x] List available engines.
  - [ ] Retrieve details about a specific engine.
- [x] Completion Requests
  - [x] Create completions.
  - [ ] Retrieve a specific completion.
- [x] Error Handling
  - [ ] Implement robust error handling for different scenarios.
- [ ] Usage Information
  - [ ] Provide methods to retrieve API usage information.
- [ ] Documentation and Examples
  - [ ] Include comprehensive documentation and example code for each function.
- [ ] Testing
  - [ ] Write unit tests to cover the main functionality.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     openai:
       github: dmarshaltu/openai
   ```

2. Run `shards install`

## Usage

```crystal
require "openai"
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/dmarshaltu/openai/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [dmarshaltu](https://github.com/dmarshaltu) - creator and maintainer
