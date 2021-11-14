# Log Parser Challenge
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
## About
Project which is analyses webserver's logs to list page's visits in total mode and unique mode.

## Ruby Version
`3.0.0`

## Install
- clone the project
- If you don't have the compatible version of ruby use the command to install this using [rbenv](https://github.com/rbenv/rbenv)
```shell
rbenv install 3.0.0
```
**Note**: You can find installed ruby version in your system with the below command:
```shell
ruby -v
```
- install dependencies using [Bundler](https://github.com/bundler/bundler) 
```shell 
bundle install
```

## Usage
Now you can run the project with below command:
```shell
./parser.rb log/webserver.log
```

**Note:** If you face with an `permission denied` error you can fix this with the below command:
```shell
chmod +x parser.rb
```

## Test
This project written in TDD by `rspec` gem. The project has `unit` and `integration` test. If you want you can run Rspec and generate code coverage with below command:
```shell
bundle exec rspec
```
For the generate test coverate we use `SimpleCov` gem which reports `193 relevant lines, 192 lines covered and 1 lines missed. ( 99.48% )`

![image](https://user-images.githubusercontent.com/27271223/141687546-212a4cfb-e55f-4b8c-a8be-a205096cc495.png)

## Architecture
- The entry point of the project is `parser.rb` which get a file to parse it.
- At the first we have a service named `ArgsReader` which checks the given arguments and returns `path` as a main file path which must be parsed.
- Then there is a service named `FileLoader` which in charge of loads the given file and then will pass the file to `FileReader`.
- `FileReader` reads given file line by line and will extract `path` and `ip` from each line.
- `Repository` service which in charge of store `path` and `ip`. The service implements two methods for return count visits and uniuqe count visits.
- Our main service is `Analyser` which depneds on two services `FileReader` and `Repository`. The service sends message to `FileReader` to read given file line by line then will send message to `Repository` to store given data.
- Finally as we have to display the result, we have a service named `Presenter` which will display the output.

![image](https://user-images.githubusercontent.com/27271223/141689627-a8832725-1826-4715-a8e2-bb96aa5b96cb.png)

## TODO
- Better exception handling.
- To improve performance we can use cache mechanism.
- Implement a bin file to interactive more efficient and clear with client
- Better implementation of Presenter service. 













