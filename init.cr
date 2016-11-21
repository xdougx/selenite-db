require "./src/selenite-db"

class User < Selenite::DB::Persistence
  property(id)
  set_property(name, email)
  set_initializer(id, name, email)
end

params = {"name" => "Douglas", "email" => "doug.ross@email.net"} 
user = User.new({"name" => "Douglas", "email" => "doug.ross@email.net", "id" => ""} )
puts "Nome do usuário é: #{user.name}"
puts "Nome do email é: #{user.email}"