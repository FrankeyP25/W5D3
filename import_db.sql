PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author INTEGER NOT NULL,
    FOREIGN KEY (author) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);


CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    subject_question INTEGER NOT NULL,
    parent_reply INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL
);



INSERT INTO 
    users (fname, lname)
VALUES
    ('John', 'Smith'),
    ('Jeff', 'Rogere');

INSERT INTO
   questions (title, body, author)
VALUES
   ('Question 1', 'WT?', 1),
   ('Question 2', 'WFrosky?', 2);

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (1,2),
  (2,1);

INSERT INTO
  replies(subject_question, parent_reply, user_id, body)
VALUES
  (2, NULL, 1, "Super blue"),
  (2, 1, 1, "no super green");










