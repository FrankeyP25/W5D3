require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end

end

class Question

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map {|ele| Question.new(ele)}
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL,id)
          SELECT
            *
          FROM
            questions
          WHERE
            id = ?
        SQL
        Question.new(question.first)
    end

    attr_accessor :id, :title, :body, :author
      
    def initialize(options)
        @id = options["id"]
        @title = options["title"]
        @body = options["body"]
        @author = options["author"]
    end

end

# a = Question.new("hello", "world", "hey")
# p a