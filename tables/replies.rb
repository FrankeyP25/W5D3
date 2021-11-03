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

class Reply

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map {|ele| User.new(ele)}
    end

    def self.find_by_id(id)
        replies = QuestionsDatabase.instance.execute(<<-SQL,id)
          SELECT
            *
          FROM
            replies
          WHERE
            id = ?
        SQL
        Reply.new(replies.first)
    end

    def self.find_by_user_id(user_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL,user_id)
          SELECT
            *
          FROM
            replies
          WHERE
            user_id = ?
        SQL
        replies.map { |reply| Reply.new(reply) }
    end

    def self.find_by_subject_question(subject_question)
        replies = QuestionsDatabase.instance.execute(<<-SQL,subject_question)
          SELECT
            *
          FROM
            replies
          WHERE
            subject_question = ?
        SQL
        replies.map { |reply| Reply.new(reply) }
    end

    def self.find_by_parent_reply(parent_reply)
        replies = QuestionsDatabase.instance.execute(<<-SQL, parent_reply)
          SELECT
            *
          FROM
            replies
          WHERE
            parent_reply = ?
        SQL
        replies.map { |reply| Reply.new(reply) }
    end

    def self.find_by_body(body)
        replies = QuestionsDatabase.instance.execute(<<-SQL, body)
          SELECT
            *
          FROM
            replies
          WHERE
            body = ?
        SQL
        replies.map { |reply| Reply.new(reply) }
    end

    attr_accessor :id, :subject_question, :user_id, :body
      
    def initialize(options)
        @id = options["id"]
        @subject_question = options["subject_question"]
        @parent_reply = options["parent_reply"]
        @user_id = options["user_id"]
        @body = options["body"]
    end

    def author
      self.user_id
    end

    def question
      self.subject_question
    end

    def parent_reply
      @parent_reply
    end

    def child_replies 
      QuestionsDatabase.instance.execute(<<-SQL)
        SELECT
         *
        FROM
          replies
        WHERE
          parent_reply = #{@id}   
      SQL
    end

end