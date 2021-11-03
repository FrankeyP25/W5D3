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

class QuestionLike

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map {|ele| User.new(ele)}
    end

    def self.find_by_id(id)
        question_like = QuestionsDatabase.instance.execute(<<-SQL,id)
          SELECT
            *
          FROM
            question_likes
          WHERE
            id = ?
        SQL
        QuestionFollow.new(question_like.first)
    end

    def self.find_by_user_id(user_id)
        question_likes = QuestionsDatabase.instance.execute(<<-SQL,user_id)
          SELECT
            *
          FROM
            question_likes
          WHERE
            user_id = ?
        SQL
        question_follows.map { |question_like| QuestionFollow.new(question_like) }
    end

    def self.find_by_question_id(question_id)
        question_likes = QuestionsDatabase.instance.execute(<<-SQL,question_id)
          SELECT
            *
          FROM
            question_likes
          WHERE
            question_id = ?
        SQL
        question_likes.map { |question_like| QuestionFollow.new(question_like) }
    end

    attr_accessor :id, :user_id, :question_id
      
    def initialize(options)
        @id = options["id"]
        @user_id = options["user_id"]
        @question_id = options["question_id"]
    end

end
