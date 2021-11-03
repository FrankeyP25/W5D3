require 'sqlite3'
require 'singleton'
require 'replies'

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

    def self.find_by_title(title)
        questions = QuestionsDatabase.instance.execute(<<-SQL,title)
          SELECT
            *
          FROM
            questions
          WHERE
            title = ?
        SQL
        questions.map {|question| Question.new(question)}
    end

    def self.find_by_body(body)
        questions = QuestionsDatabase.instance.execute(<<-SQL,body)
          SELECT
            *
          FROM
            questions
          WHERE
            body = ?
        SQL
        questions.map {|question| Question.new(question)}
    end

    def self.find_by_author(author)
        questions = QuestionsDatabase.instance.execute(<<-SQL,author)
          SELECT
            *
          FROM
            questions
          WHERE
            author = ?
        SQL
        questions.map {|question| Question.new(question)}
    end


    attr_accessor :id, :title, :body
      
    def initialize(options)
        @id = options["id"]
        @title = options["title"]
        @body = options["body"]
        @author = options["author"]
    end

    def author
      Question.find_by_author(@author)
    end

    def replies
        Reply.find_by_subject_question(@id)
    end

end

# a = Question.new("hello", "world", "hey")
# p a