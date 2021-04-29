class Character 
attr_accessor :id, :name, :age

    def initialize(option = {}) 
        option.each do |key, value|
            self.send("#{key}=", value) if respond_to?("#{key}=")
        end
    end

    def save 
        if self.id 
            self.update
        else
        sql = <<-SQL 
        INSERT INTO characters (name, age) VALUES (?,?);
        SQL
        DB[:conn].execute(sql, self.name, self.age)
        self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM characters;")[0][0]
        end
        self
    end

    def self.create(hash) 
     self.new(hash).save
    end

    def self.create_table 
        sql = <<-SQL
         CREATE TABLE IF NOT EXISTS characters(
             id INTEGER PRIMARY KEY,
             name TEXT,
             age INTEGER
         );
        SQL
        DB[:conn].execute(sql)
    end

    def self.all 
      sql = <<-SQL 
      SELECT * FROM characters;
      SQL

        records = DB[:conn].execute(sql)
        # binding.pry
        records.map do |record|
            self.new(record)
        end
    end

    def self.find_by(id)
        sql = <<-SQL
        SELECT * FROM characters WHERE id = ?;
        SQL

       record = DB[:conn].execute(sql, id).first
        Character.new(record)
    end


    def update 
        sql = <<-SQL
        UPDATE characters SET name = ?, age = ? WHERE id = ?;
        SQL
        DB[:conn].execute(sql, self.name, self.age, self.id)
        self
    end

    def delete_rows_below 
        sql = <<-SQL
        DELETE FROM characters WHERE id < ?;
        SQL
        DB[:conn].execute(sql, self.id)
    end

    def self.delete_all 
        DB[:conn].execute("DROP TABLE characters;")

    end

    



end