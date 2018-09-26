require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "
      INSERT INTO artists (name)
      VALUES ($1)
      RETURNING id;
    "
    result = SqlRunner.run(sql, [@name])

    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM artists;"
    order_hashes = SqlRunner.run(sql)
    order_objects = order_hashes.map {|order_hash| Artist.new(order_hash)}
    return order_objects
  end

  def self.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def albums()
    sql = "
      SELECT * FROM albums
      WHERE artist_id = $1;
    "
    results = SqlRunner.run(sql, [@id])
    albums = results.map do |album_hash|
      Album.new(album_hash)
    end
    return albums
  end

end
