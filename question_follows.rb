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


    attr_accessor :id, :title, :body, :author
      
    def initialize(options)
        @id = options["id"]
        @user_id = options["user_id"]
        @question_id = options["question_id"]
    end

end
