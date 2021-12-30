# rubymail
Ruby mailing framework 

## Installation:
```
$ gem install rubymail
```

## Tutorial:

- config:
```ruby
Rubymail.configure do |config|
  config.api_key = 'your-api-key'
  config.domain  = 'your-rubymail-domain'
end

@rubymail = Rubymail()

@rubymail = Rubymail(:api_key => 'your-api-key')
```

- sending email:

```ruby
parameters = {
  :to => "cooldev@your.rubymail.domain",
  :subject => "missing tps reports",
  :text => "test....",
  :from => "lumberg.bill@initech.rubymail.domain"
}
@rubymail.messages.send_email(parameters)
```