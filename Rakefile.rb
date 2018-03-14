require 'pg'
require 'rake'

task :test_environment do
  p 'Cleaning database...'

  connection = PG.connect(dbname: 'bookmark_manager_test')

  # Clear the database
  connection.exec('TRUNCATE links;')

  # Add the test data
  connection.exec("INSERT INTO links VALUES('http://www.makersacademy.com', 'Makers Academy');")
  connection.exec("INSERT INTO links VALUES('http://www.google.com', 'Google');")
  connection.exec("INSERT INTO links VALUES('http://www.facebook.com', 'Facebook');")
end

task :setup do
  p 'Creating databases...'

  %w[bookmark_manager bookmark_manager_test].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{database};")
    connection = PG.connect(dbname: database)
    connection.exec('CREATE TABLE links(url VARCHAR(60), title VARCHAR(60));')
  end
end
