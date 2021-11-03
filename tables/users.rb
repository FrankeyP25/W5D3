require 'sqlite3'
require 'singleton'
# require 'questions_database.rb'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end

end

class User

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map {|ele| User.new(ele)}
    end

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL,id)
          SELECT
            *
          FROM
            users
          WHERE
            id = ?
        SQL
        User.new(user.first)
    end

    def self.find_by_name(fname, lname)
        users = QuestionsDatabase.instance.execute(<<-SQL,fname, lname)
          SELECT
            *
          FROM
            users
          WHERE
            fname = ? AND lname = ?
        SQL
        users.map {|user|User.new(user)}
    end

    attr_accessor :id, :title, :body, :author
      
    def initialize(options)
        @id = options["id"]
        @fname = options["fname"]
        @lname = options["lname"]
    end

    def authored_questions
      Questions.find_by_author(@id)
    end

    def authored_replies
      Reply.find_by_user_id(@id)
    end


end
