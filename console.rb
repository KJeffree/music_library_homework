require_relative('./models/album.rb')
require_relative('./models/artist.rb')

require('pry')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'name' => 'KT Tunstall'
  })

artist2 = Artist.new({
  'name' => 'Dodie'
  })

artist1.save()
artist2.save()

album1 = Album.new({
  'title' => 'You',
  'genre' => 'Pop',
  'artist_id' => artist2.id
  })

album2 = Album.new({
  'title' => 'Intertwined',
  'genre' => 'Pop',
  'artist_id' => artist2.id
  })

album3 = Album.new({
  'title' => 'Eye To The Telescope',
  'genre' => 'Alternative Rock',
  'artist_id' => artist1.id
  })

album4 = Album.new({
  'title' => 'Drastic Fantastic',
  'genre' => 'Alternative Rock',
  'artist_id' => artist1.id
  })

album5 = Album.new({
  'title' => 'Tiger Suit',
  'genre' => 'Alternative Rock',
  'artist_id' => artist1.id
  })

  album1.save()
  album2.save()
  album3.save()
  album4.save()
  album5.save()

  artists = Artist.all()
  albums = Album.all()


  binding.pry
  nil
