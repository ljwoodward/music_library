require('pg')
require_relative('artist.rb')
require_relative('../db/sql_runner.rb')

class Album
  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i()
    @title = options["title"]
    @genre = options["genre"]
  end

  def save()
    sql = "
      INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3)
      RETURNING *;"
    values = [ @title, @genre, @artist_id ]

    @id = SqlRunner.run(sql, values)[0]['id'].to_i()

  end

  def self.all()
    sql = "SELECT * FROM albums"
    values = []
    albums = SqlRunner.run(sql, values)

    albums_as_objects = albums.map { |order| Album.new(order) }

    return albums_as_objects
  end

  def self.delete_all()
    sql = 'DELETE FROM albums'
    values = []
    SqlRunner.run(sql, values)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_data = results[0]
    artist = Artist.new(artist_data)
    return artist
  end

end
