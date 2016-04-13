require 'pry'
require 'active_record'

require_relative 'contact'

ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database ...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'contactlist',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)

class ContactList

  input_array = ARGV
  
  case ARGV[0]
    when "new"
      puts "Please enter a name."
      name = STDIN.gets.chomp
      puts "Please enter an email address."
      email = STDIN.gets.chomp
      contact = Contact.create(name: name, email: email)
      puts "#{contact.id}. #{contact.name} (#{contact.email}) added to database!"
    when "update"
      id = ARGV[1]
      contact = Contact.find(id)
      puts "#{contact.id}. #{contact.name} (#{contact.email})"
      puts "Please enter the new name."
      new_name = STDIN.gets.chomp
      puts "Please enter the new email address."
      new_email = STDIN.gets.chomp
      contact.name = new_name
      contact.email = new_email
      contact.save
      puts "#{contact.id}. #{contact.name} (#{contact.email}) updated in database!"
    when "list"
      contacts =  Contact.order(:id)
      contacts.each do |contact|
        puts "#{contact.id}. #{contact.name} (#{contact.email})"
      end
    when "show"
      id = ARGV[1]
      contact = Contact.find(id.to_i)
      puts "#{contact.id}. #{contact.name} (#{contact.email})"

    when "search"
      term = ARGV[1]
      contacts = Contact.where("name LIKE ?", "%#{term}%")
      contacts.each do |contact|
        puts "#{contact.id}. #{contact.name} (#{contact.email})"
      end 
    when "destroy"
      id = ARGV[1]
      contact = Contact.find(id)
      puts "Delete #{contact.id}. #{contact.name} (#{contact.email})? [y/n]"
      answer = STDIN.gets.chomp.downcase
      if answer == 'y'
        contact.destroy
        puts "#{contact.id}. #{contact.name} (#{contact.email}) has been deleted"
      end 
    else
      puts "Here is a list of available commands:"
      puts "new    - Create a new contact"
      puts "update - Update a contact's information"  
      puts "list   - List all contacts"
      puts "show   - Show a contact"
      puts "search - Search contacts"    
      puts "destroy - Delete a contact" 
  end
end


