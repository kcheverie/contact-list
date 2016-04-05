require 'csv'
require 'pry'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  attr_accessor :name, :email, :id
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(id, name, email)
    # TODO: Assign parameter values to instance variables.
    @id = id
    @name = name
    @email = email
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      @contacts = []
      CSV.foreach('list.csv') do |contact| 
        @contacts << contact
      end
      @contacts.each do |id, name, email|
        puts "#{id}. #{name} (#{email})"
      end
   
      "---\n#{@contacts.length} records total."
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      array_length = CSV.read("list.csv").length
      id = array_length + 1
      CSV.open("list.csv", "ab") do |csv|
        csv << [id, name, email]
      end
    end
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      CSV.foreach('list.csv') do |contact| 
        if contact[0] == id
          return contact
        end
      end
    end
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      result = []
      CSV.foreach('list.csv') do |contacts| 
        contacts.each do |contact|
          if contact.include?(term)
            result << contacts
          end        
        end
      end
        results = []
        result.each do |id, name, email|
        results << result
        puts "#{id}. #{name} (#{email})"
        end
        "---\n#{results.length} records total."
    end
  end
end