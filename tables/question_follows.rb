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

class QuestionFollow

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map {|ele| User.new(ele)}
    end

    def self.find_by_id(id)
        question_follow = QuestionsDatabase.instance.execute(<<-SQL,id)
          SELECT
            *
          FROM
            question_follows
          WHERE
            id = ?
        SQL
        QuestionFollow.new(question_follow.first)
    end

    def self.find_by_user_id(user_id)
        question_follows = QuestionsDatabase.instance.execute(<<-SQL,user_id)
          SELECT
            *
          FROM
            question_follows
          WHERE
            user_id = ?
        SQL
        question_follows.map { |question_follow| QuestionFollow.new(question_follow) }
    end

    def self.find_by_question_id(question_id)
        question_follows = QuestionsDatabase.instance.execute(<<-SQL,question_id)
          SELECT
            *
          FROM
            question_follows
          WHERE
            question_id = ?
        SQL
        question_follows.map { |question_follow| QuestionFollow.new(question_follow) }
    end

    def self.followers_for_question_id(question_id)
      users = QuestionsDatabase.instance.execute(<<-SQL)
        SELECT
          id, fname, lname
        FROM
          question_follows
        JOIN 
          users 
        ON
          users.id = question_follows.user_id
        WHERE
          question_id = #{question_id}  
      SQL
      users.map {|user| User.new(user)}
    end

    attr_accessor :id, :user_id, :question_id
      
    def initialize(options)
        @id = options["id"]
        @user_id = options["user_id"]
        @question_id = options["question_id"]
    end

end
