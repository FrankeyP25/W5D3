require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.result_as_hash = true
    end

end

class Question

    def self.all()
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map {|ele| Question.new(ele)}
    end

    attr_accessor :id, :title, :body, :author

    def initialize(options)
        @id = options["id"]
        @title = options["title"]
        @body = options["body"]
        @author = options["author"]
    end

end