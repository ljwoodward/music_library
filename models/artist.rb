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

  def self.all()
    sql = "SELECT * FROM artists"
    values = []
    artists = SqlRunner.run(sql, values)
    artists_as_objects = artists.map {|artist| Artist.new(artist)}
    return artists_as_objects
  end


end
