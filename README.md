# SmartParser
Ruby test for Smart Pension
Parses a web server log file and outputs the following:
+ List of webpages with total page visits ordered from most total visits to less total visits
+ List of webpages with most unique page visits ordered from most unique visits to less unique visits

# Solution design 
+ [`Application`][1] is used as the application layer that consumes the domain logic and outputs the results.
+ The module **LogFile** is used as a bounded context for the domain logic.
+ [`LogFile::Counter`][2] class is used to count all total and unique visits for the web pages.
+ [`LogFile::Line`][3] class is used to parse the line string provided and return web_page and IP strings.
+ [`LogFile::Validators::IpValidator`][4] class is used to validate the parsed ip_string.
+ [`LogFile::Validators::WebPageValidator`][5] class is used to validate the parsed web_page_string.
+ [`LogFile::Presenters::CounterPresenter`][6] class is used to order and return array for most page visits and most uniq visits.
+ The project is following TDD so specs are implemented before features.

# Improvements would like to make
+ After running mutation tests, **LogFile::Counter** and **LogFile::Line** classes have some minor failures that I would like to fix.
+ Currently, the ruby class 'Set' is used in **LogFile::Counter** to aggragate the unique ips and find the total count. This can cause a problem if the logfile is big and with a lot of unique ips. Would like to use another data structure (such as as [`HyperLogLog`][7]) for storing unique ips count and not the whole set of ip strings.

# Setup & Run
This project is using:
+ ruby 2.7.0
+ rspec gem as the tests framework.
+ rubocop gem for coding style guide.
+ simplecov gem for test coverage report.
+ TravisCI for continuous integration service.

You need to install the dependencies first, follow these steps to install all required dependencies using RVM:

+ Install RVM
```shell
$ curl -sSL https://get.rvm.io | bash -s stable
```

+ Install/Use ruby 2.7.0 and create a gemset for this project
```shell
$ rvm use ruby-2.7.0@smart_parser --create
```

+ Install bundler gem
```shell
$ gem install bundler
```

+ Install gems listed in Gemfile
```shell
$ bundle install
```

+ Run application
```shell
$ ./smart_parser.rb <webserver.log>
```
+ Run tests
```shell
$ bundle exec rspec
```
+ Run rubocop
```shell
$ bundle exec rubocop
```

[1]: https://https://github.com/ivanelrey/smart_parser/blob/master/application.rb
[2]: https://github.com/ivanelrey/smart_parser/blob/master/lib/log_file/counter.rb
[3]: https://github.com/ivanelrey/smart_parser/blob/master/lib/log_file/line.rb
[4]: https://github.com/ivanelrey/smart_parser/blob/master/lib/log_file/validators/ip_validator.rb
[5]: https://github.com/ivanelrey/smart_parser/blob/master/lib/log_file/validators/web_page_validator.rb
[6]: https://github.com/ivanelrey/smart_parser/blob/master/lib/log_file/presenters/counter_presenter.rb
[7]: https://en.wikipedia.org/wiki/HyperLogLog
