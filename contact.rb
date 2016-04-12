require 'pg'
require 'pry'

class Contact
  
  attr_accessor :name, :email, :id
  
  def initialize(id, name, email)
    @id = id
    @name = name
    @email = email
  end

  def save(name, email)
    if self.id == 0
     self.class.connection.exec_params("INSERT INTO contacts (name, email) VALUES ($1, $2)", [name, email])
      "#{name} (#{email}) added to database!"
    else
      self.class.connection.exec_params("UPDATE contacts SET name = $1, email = $2 WHERE id = $3::int;", [name, email, id])
      "#{name} (#{email}) updated in database!"
    end
  end

  def destroy(id)
    self.class.connection.exec_params("DELETE FROM contacts WHERE id = $1::int;", [id])
    "#{name} (#{email}) deleted from database!"
  end

  class << self

    def connection
      conn = PG.connect(
        host: 'localhost',
        dbname: 'contactlist',
        user: 'development',
        password: 'development'
      )
    end

    def create(name, email)
      contact = Contact.new(0, name, email)
      contact.save(name, email)
    end

    def all
      @contacts = []
      connection.exec('SELECT * from contacts ORDER BY id;') do |contacts| 
        contacts.map do |c|          
          @contacts << Contact.new(c["id"], c["name"], c["email"])
        end
      end
      @contacts.each do |contact|
        puts "#{contact.id}. #{contact.name} (#{contact.email})"
      end
      "---\n#{@contacts.length} records total."
    end

    def find(id)
      result = connection.exec_params("SELECT * FROM contacts WHERE id = $1::int; ", [id])
      result.each do |c| 
       contact =  Contact.new(c["id"], c["name"], c["email"])
       return contact
      end
    end

    def search(term)
      results = []
      result = connection.exec("SELECT * FROM contacts WHERE name LIKE \'%#{term}%\'")
      result.each do |c| 
        contact =  Contact.new(c["id"], c["name"], c["email"])
        results << contact
      end
      results.each do |contact|
        puts "#{contact.id}. #{contact.name} (#{contact.email})"
      end
      "---\n#{results.length} records total."
    end

  end
end