require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

  input_array = ARGV
  
  case ARGV[0]
    when "new"
      puts "Please enter a name."
      name = STDIN.gets.chomp
      puts "Please enter an email address."
      email = STDIN.gets.chomp
      puts Contact.create(name, email)
    when "list"
      puts Contact.all
    when "show"
      id = ARGV[1]
      puts Contact.find(id)   
    when "search"
      term = ARGV[1]
      puts Contact.search(term)   
    else
      puts "Here is a list of available commands:"
      puts "new    - Create a new contact"
      puts "list   - List all contacts"
      puts "show  - Show a contact"
      puts "search - Search contacts"    
  end
end


