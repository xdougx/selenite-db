# Selenite::DB

Selenite is a persistency-model based library

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  selenite-db:
    github: xdougx/selenite-db
```


## Usage


```crystal
require "selenite-db"

# setup out connection
Selenite::DB::Configuration.configure do |conf|
  conf.client_encoding = "utf8"
  conf.port = "5432"
  conf.database = "crystal"
  conf.user = "root"
  conf.password = ""
  conf.host = "localhost"
  conf.env = "development"
end

```



When you build your model you'll need to define your properties, initializers, attributes types, and the table name.

#### 1 Create our base model

```
class Users < Selenite::DB::Persistence
end
```

#### 2 Define its table

```
def self.table_name
  "users"
end
```

#### 3 Setup attributes types

```
  @name : String?
  @email : String?
  @password : String?
  @password_digest : String?
```

#### 4 Define the properties

```
  property(id, created_at, updated_at) # is needed to be separeted

  set_property(name, email, password, password_digest) # base attributes

  set_initializer(true, id, name, email, password, password_digest) # base initializer, **true** is for timestamp initialization
```

#### 5 That is our base model

```crystal
class Users < Selenite::DB::Persistence
        
  def self.table_name
    "users"
  end

  @name : String?
  @email : String?
  @password : String?
  @password_digest : String?

  property(id, created_at, updated_at) # is needed to be separeted
  set_property(name, email, password, password_digest) # base attributes
  set_initializer(true, id, name, email, password, password_digest)

end

```

#### 6 Try it

```
user = Users.new({"name" => "Vitor Hugo", "email" => "vitor.hugo@email.net"})
user.save

puts "User name is: #{user.name}"
puts "User email is: #{user.email}"
```


### Persistency Available Methods

```crystal

def self.exec(query)                                   # executes a query and return a result from PG
def exec(query)                                        # alias for an instance
def save; end                                          # persist your model
def update_columns(params); end                        # update the values direct
def self.exists?(column, value); end                   # verify if an id exists
def self.exists?(params); end                          # verify if exists using many params
def self.find(id : Int32 | Int64 | String | Nil); end  # find with id
def self.get_result_by(params); end                    # find using many params
def self.find_by(params); end                          # find using many params
```

## Features Roadmap

- [ ] has_one
- [ ] has_many
- [ ] belongs_to
- [ ] joins
- [ ] where
- [ ] validations
- [ ] order
- [ ] limit
- [ ] offset
- [ ] scheema

## Contributing

Would like to help us to improve our library? 

1. Fork it ( https://github.com/[your-github-name]/selenite-db/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [xdougx](https://github.com/xdougx) Douglas Rossignolli - creator, maintainer

## Credits and Thanks

- Crystal-Lang Irc/Gitter
- @mverzilli
