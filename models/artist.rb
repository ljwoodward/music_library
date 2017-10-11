require('pg')
require_relative('../db/sql_runner.rb')

class Artist
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING * "
    values = [@name]
    result = SqlRunner.run(sql, values)[0]['id'].to_i()
    @id = result
  end


end
