# selenite-db

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
```


When you build your model you'll need to define your properties, initializers, define your attribute types, and the table name.

```crystal
class Users < Selenite::DB::Persistence
        
  def self.table_name
    "users"
  end

  @name : String?
  @email : String?
  @password : String?
  @password_digest : String?
  @token : String?
  @temp_hash : String?
  @status : String?
  @gender : String?

  property(id, created_at, updated_at)
  set_property(name, email, password, password_digest, token, temp_hash, status, gender, created_at, updated_at)
  set_initializer(true, id, name, email, password, password_digest, token, temp_hash, status, gender)

end

```


### Persistency Available Methods

```crystal

def self.exec(query) # executes a query and return a result from PG
def exec(query) # alias for an instance
def save; end # persist your model
def update_columns(params); end # update the values direct
def self.exists?(column, value); end # verify if an id exists
def self.exists?(params); end # verify if exists using many params
def self.find(id : Int32 | Int64 | String | Nil); end # find with id
def self.get_result_by(params); end # find using many params
def self.find_by(params); end # find using many params
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/[your-github-name]/selenite-db/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[your-github-name]](https://github.com/[your-github-name]) Douglas Rossignolli - creator, maintainer
