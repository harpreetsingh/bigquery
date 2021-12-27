-- Section 2 SQL Queries: Basic Select

-- For each tag, how many questions does it have?

-- 1) How many rows in the table: 6,623,851
-- select count(*) from `jrjames83-1171.sampledata.top_questions`;

-- 2) # of occurences of a tag 19,852
-- select tag, count(*) as num_rows
-- FROM `jrjames83-1171.sampledata.top_questions`
-- GROUP BY tag
-- ORDER BY num_rows DESC;

-- 3) tag --> num of rows it's found in; tag --> number of unique questions; 19.852
-- select tag, count(*) as num_rows, count(Distinct id) as unique_questions
-- FROM `jrjames83-1171.sampledata.top_questions`
-- GROUP BY tag
-- ORDER BY num_rows DESC;

-------------
-- Can a question belong to multiple tags
-- 1) question --> unique tags 506,001
-- select title, count(Distinct tag) as unique_tags
-- FROM `jrjames83-1171.sampledata.top_questions`
-- GROUP BY title
-- ORDER BY unique_tags DESC;

-- 2) Let's try to list the tags each questions have 506055
-- using ARRAY_AG function to do so; ends up repeating tags because the data is being repeated quarter by quarter
-- select title, id, ARRAY_AGG(tag) as unique_tags
-- FROM `jrjames83-1171.sampledata.top_questions`
-- GROUP BY title, id;

-- 3) Let's try to get to unique tags by using Distinct
-- select title, id, ARRAY_AGG(Distinct tag) as unique_tags
-- FROM `jrjames83-1171.sampledata.top_questions`
-- GROUP BY title, id;

------------------
-- 1) Find questions with more than 2 unique tags 12,114
select title, id, ARRAY_AGG(Distinct tag) as unique_tags
FROM `jrjames83-1171.sampledata.top_questions`
GROUP BY title, id
HAVING ARRAY_LENGTH(ARRAY_AGG(DISTINCT tag)) > 2
ORDER BY ARRAY_LENGTH(ARRAY_AGG(DISTINCT tag)) DESC;
