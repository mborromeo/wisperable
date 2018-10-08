ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Schema.define do
  self.verbose = false

  create_table :todos, force: true do |t|
    t.string :body
  end
end