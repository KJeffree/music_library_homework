require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'].to_i()
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i()
  end

  def save()
    sql = "
      INSERT INTO albums (title, genre, artist_id)
      VALUES ($1, $2, $3)
      RETURNING id;
    "
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i

  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums;"
    order_hashes = SqlRunner.run(sql)
    order_objects = order_hashes.map {|order_hash| Album.new(order_hash)}
    return order_objects
  end

  def artist()
    sql = "
      SELECT * FROM artists
      WHERE id = $1;
    "
    results = SqlRunner.run(sql, [@artist_id])
    artist_hash = results[0]
    artist = Artist.new(artist_hash)
    return artist
  end

  def update()
    sql = "
      UPDATE albums
      SET (title, genre) = ($1, $2)
      WHERE id = $3;
    "
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "
      DELETE FROM albums
      WHERE id = $1
    "
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    album_hash = result[0]
    album = Album.new(album_hash)
    return album
  end

end
