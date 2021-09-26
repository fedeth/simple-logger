# Simple Logger
This simple app receives a log file in input and returns the list of web pages with most page views ordered. It also returns the list of web pages ordered by the number of unique IPs that have visited each specific page.

## Usage
If you have a Ruby interpreter installed, you can just type:
```bash
ruby main.rb webserver.log
```
Or if you prefer to use bundler:

```bash
bundle install
bundle exec ruby main.rb webserver.log
```

### Supported file format
Currently, the Simple Logger can parse only text files with the following syntax:

```ruby
$website_path $pseudo_ip_address

$website_path format: {[a-z0-9/_]{1,}}
$pseudo_ip_address format: {[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}
```
## The idea behind
- **LogLine**: it is responsible for preserve the original line of text, and after validations respond to _ip_ and _url_ messages.
- **Link**: it stores a link and keeps track of the total numbers of views and the number of unique IPs. Its _add_ip_ method is responsible for increment the visit counter and collects unique IPs.
- **Links**:it wraps an enumerable collection of entities (likely Link(s)) and provides some methods to order them.
- **LogParser**: it acts as a container, it is responsible for file-related operations and it delegates received messages to the others components.
- **Formatter** it is a stand-alone entity that format the received arguments according to some options.


 