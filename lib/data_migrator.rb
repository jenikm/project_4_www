module DataMigrator
  def self.get_artist_reference(data)
    data[2] = data[3] if data[2].empty?
    data[2].strip.to_sym
  end

  def self.get_song_reference(data)
    data[4] = data[5]if data[4].empty?
    data[4].strip.to_sym
  end

  def self.migrate_played_songs
    ActiveRecord::Base.logger = nil
    puts "truncate users; truncate songs; truncate track_plays; truncate artists;"
    ActiveRecord::Base.connection.execute("truncate users;truncate songs; truncate track_plays; truncate artists;")
    file = File.open(File.join(Rails.root, "lib", "userid-timestamp-artid-artname-traid-traname.tsv"))
    users = {}
    plays = []
    artists = {}
    songs = {}
    i = 0
    while cur_line = file.gets
      i+=1
      data = cur_line.split("\t")
      users[data[0].strip.to_sym] = true
      #plays << [data[1], data[0], data[4]]
      artist_reference = get_artist_reference(data) 
      artists[artist_reference] = data[3].strip
      song_reference = get_song_reference(data)
      songs[song_reference] = [data[5].strip, artist_reference]
      puts "Processing line: #{i}" if i%100000 == 0
    end
    puts "Creating users"
    users.keys.each do |reference|
      User.create(:reference=> reference)
    end
    puts "Creating artists"
    artists.each do |reference, name|
      Artist.create(:name => name, :reference => reference) 
    end
    puts "Creating songs"
    songs.each do |reference, attributes|
      Song.create(:name => attributes[0], :reference => reference, :artist => Artist.find_by_reference(attributes[1]))
    end

    #puts "Creating plays"
    #plays.each do |play|
    #  puts play.inspect
    #  TrackPlay.create(:played_at => play[0].to_time, :song => Song.find_by_reference(play[2]), :played_by => User.find_by_reference(play[1]))
    #end

    file.close
  end

  def self.migrate_plays
    ActiveRecord::Base.logger = nil
    users = {}
    songs = {}
    f = File.new(File.join(Rails.root, "lib", "copy_track_plays.sql"), "w")
    #ActiveRecord::Base.transaction do
      puts "truncate track_plays;"
      ActiveRecord::Base.connection.execute("truncate track_plays;")
      file = File.open(File.join(Rails.root, "lib", "userid-timestamp-artid-artname-traid-traname.tsv"))
      i = 0
      sql = ""
      while line = file.gets
        i+=1
        data = line.split("\t")
        song_reference = get_song_reference(data)
        user_reference = data[0]

        #songs[song_reference] ||= Song.find_by_reference(song_reference)
        #users[user_reference] ||= User.find_by_reference(user_reference)
        #statement = ["INSERT INTO track_plays (played_at, song_id, played_by_id) VALUES(?, (SELECT id FROM songs WHERE reference = ?), (SELECT id FROM users WHERE reference = ?));", data[1].to_time, song_reference.to_s.strip, user_reference.to_s.strip]
        
        sql << "\n#{i}\t#{data[1].to_time}\t#{song_reference.to_s.strip}\t#{user_reference.to_s.strip}".gsub("\\", "")
        #statement = User.send(:sanitize_sql_array, statement)
        #TrackPlay.create(:played_at => data[1].to_time, 
        #                 :song => songs[song_reference], 
        #                 :played_by => users[user_reference])
        #sql << statement
        if i%100000 == 0
          f.write(sql)
          sql = ""
          #f = File.new(File.join(Rails.root, "lib", "sql_files", "#{i}_data.sql"), "w")
          #f.write(sql)
          #f.close
          #sql = ""
          ##TrackPlay.connection.execute(sql)
          puts "Processing line: #{i}"
        end
      end
      file.close
    #end
  end

  def self.migrate_user_profiles
    ActiveRecord::Base.logger = nil
    file = File.open(File.join(Rails.root, "lib", "usersha1-profile.tsv"))
    countries = {}
    i=0
    User.transaction do
      while line = file.gets  
        i+=1
        data = line.split("\t")
        country_name = data[3].strip
        countries[country_name] ||= Country.create :name => data[3].strip
        User.create :reference => data[0], 
                    :gender => User.gender_to_index(data[1].strip), 
                    :age => data[2].to_i, 
                    :country => countries[country_name], 
                    :registered_at => data[4].to_date
        puts "Processing line: #{i}" if i%10000 == 0
      end
    end
    file.close
  end

  def self.create_missing_users_arists
    ActiveRecord::Base.logger = nil
    file = File.open(File.join(Rails.root, "lib", "usersha1-artmbid-artname-plays.tsv"))
    users = {}
    artists = {}
    i=0
    while line = file.gets
      i+=1
      data = line.split("\t")
      user_reference = data[0].strip
      data[1] = data[2] if data[1].empty?
      artist_reference = data[1].strip
      #puts "#{user_reference}\t#{user_reference}\t#{data[2].strip}\t#{data[3].strip}"
      begin
        users[user_reference] ||= (User.find_by_reference(user_reference) || User.create(:reference => user_reference))
        artists[artist_reference] ||= (Artist.find_by_reference(artist_reference) || Artist.create(:name => data[2].strip, :reference => artist_reference))
      rescue
        puts $!
      end
      puts "Processing line: #{i}" if i%10000 == 0
    end
    file.close
  end

  def self.create_favorite_artists
    ActiveRecord::Base.logger = nil
    file = File.open(File.join(Rails.root, "lib", "usersha1-artmbid-artname-plays.tsv"))
    users = {}
    artists = {}
    i=0
    f = File.new(File.join(Rails.root, "lib", "copy_favorite_artists.sql"), "w")
    sql = ""
    while line = file.gets
      i+=1
      data = line.split("\t")
      user_reference = data[0].strip
      data[1] = data[2] if data[1].empty?
      artist_reference = data[1].strip
      sql << "\n#{user_reference}\t#{artist_reference}\t#{data[3].strip}"
      if i%100000==0
        f.write(sql)
        sql = ""
        puts "Processing line: #{i}"
      end
    end
    f.close
    file.close
  end

end
