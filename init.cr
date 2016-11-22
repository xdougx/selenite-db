require "./src/selenite-db"

Selenite::DB::Base.configure do |conf|
  conf.client_encoding = "utf8"
  conf.port = "5432"
  conf.database = "crystal"
  conf.user = "root"
  conf.password = ""
  conf.host = "localhost"
  conf.env = "development"
  conf
end

class Users < Selenite::DB::Persistence
  
  def self.table_name
    "users"
  end

  @name : String?
  @email : String?
  @password : String?
  @password_diges : String?
  @toke : String?
  @temp_has : String?
  @status : String?
  @gender : String?


  set_property(name, email, password, password_diges, toke, temp_has, status, gender)
  set_initializer(id, name, email, password, password_diges, toke, temp_has, status, gender)

end



user = Users.new({"name" => "Douglas", "email" => "doug.ross@email.net"})
user.save

puts "Nome do usuário é: #{user.name}"
puts "Nome do email é: #{user.email}"

