require 'pry'
require 'active_record'
require_relative 'contact'


ActiveRecord::Schema.define do
  drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)

  create_table :contacts do |t|
    t.column :name, :string
    t.column :email, :string
    t.timestamps null: false
  end
end

puts 'Setup DONE'
