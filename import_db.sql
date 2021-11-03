PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL,
    person_id INTEGER NOT NULL,
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY (author) REFERENCES users(id)
);

CREATE TABLE question_follows (
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_info) REFERENCES users(user_id),
    FOREIGN KEY (question_info) REFERENCES questions(question_id)
);


CREATE TABLE replies (
    

)











