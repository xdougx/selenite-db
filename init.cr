require "./src/selenite-db"

Selenite::DB::Configuration.configure do |conf|
  conf.client_encoding = "utf8"
  conf.port = "5432"
  conf.database = "crystal"
  conf.user = "root"
  conf.password = ""
  conf.host = "localhost"
  conf.env = "development"
end

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


  set_property(name, email, password, password_digest, token, temp_hash, status, gender)
  set_initializer(id, name, email, password, password_digest, token, temp_hash, status, gender)

end



user = Users.new({"name" => "Douglas", "email" => "doug.ross@email.net"})
user.set_defaults
user.save

puts "Nome do usuário é: #{user.name}"
puts "Nome do email é: #{user.email}"

