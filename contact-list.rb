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
    when "update"
      id = ARGV[1]
      the_contact = Contact.find(id)
      puts "#{the_contact.id}. #{the_contact.name} (#{the_contact.email})"
      puts "Please enter the new name."
      new_name = STDIN.gets.chomp
      puts "Please enter the new email address."
      new_email = STDIN.gets.chomp
      puts the_contact.save(new_name, new_email)
    when "list"
      puts Contact.all
    when "show"
      id = ARGV[1]
      puts Contact.find(id)   
    when "search"
      term = ARGV[1]
      puts Contact.search(term) 
    when "destroy"
      id = ARGV[1]
      the_contact = Contact.find(id)
      puts "Delete #{the_contact.id}. #{the_contact.name} (#{the_contact.email})? [y/n]"
      answer = STDIN.gets.chomp.downcase
      if answer == 'y'
        puts the_contact.destroy(id) 
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


