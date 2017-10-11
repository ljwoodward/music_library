require('pry')
require_relative('models/album.rb')
require_relative('models/artist.rb')
require_relative('db/sql_runner.rb')

Album.delete_all
Artist.delete_all


artist1 = Artist.new({
  'name' => 'Michael Jackson'
  })

artist2 = Artist.new({
  'name' => 'Nirvana'
  })

artist1.save
artist2.save

album1 = Album.new({
    'artist_id' => artist1.id(),
    'title' => 'Thriller',
    'genre' => 'pop'
    })

album2 = Album.new({
    'artist_id' => artist2.id(),
    'title' => 'Nevermind',
    'genre' => 'Rock'
    })

album3 = Album.new({
    'artist_id' => artist1.id(),
    'title' => 'Bad',
    'genre' => 'pop'
    })

album1.save
album2.save
album3.save



binding.pry

nil
