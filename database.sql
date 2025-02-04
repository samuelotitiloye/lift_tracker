
-- USER is a reserved keyword with Postgres
-- You must use double quotes in every query that user is in:
-- ex. SELECT * FROM "user";
-- Otherwise you will have errors!
--this table will create users from the register/login page

CREATE TABLE "user" (
    "id" SERIAL PRIMARY KEY,
    "username" VARCHAR (80) UNIQUE NOT NULL,
    "password" VARCHAR (1000) NOT NULL
);

-- this table will create workouts per user...a workout will contain various exercises
  CREATE TABLE "workout" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INT,
  "name" VARCHAR,
  "date" DATE NOT NULL DEFAULT CURRENT_DATE);

--- this table will create different physical activities by the user
CREATE TABLE "exercise" (
  "id" SERIAL PRIMARY KEY, 
  "name" varchar,
  "description" varchar);

-- this table will create different workout 
INSERT INTO "workout" ("user_id", "name")
VALUES ('1', 'Chest'),
('1', 'Glutes'),
('1', 'Shoulders'),
('1', 'Legs'),
('1', 'Back');

-- this query will populate/insert into the exercise table with different exercises
INSERT INTO "exercise" ("name", "description")
VALUES ('Bench Press', 'Lie back on a flat bench. Using a medium width grip (a grip that creates a 90-degree angle in the middle of the movement between the forearms and the upper arms), lift the bar from the rack and hold it straight over you with your arms locked. From the starting position, breathe in and begin coming down slowly until the bar touches your middle chest.
After a brief pause, push the bar back to the starting position as you breathe out. Focus on pushing the bar using your chest muscles. Lock your arms and squeeze your chest in the contracted position at the top of the motion, hold for a second and then start coming down slowly again. Tip: Ideally, lowering the weight should take about twice as long as raising it. Repeat the movement for the prescribed amount of repetitions.'),
('Hip Thrust', 'Begin seated on the ground with a bench directly behind you. Have a loaded barbell over your legs. Using a fat bar or having a pad on the bar can greatly reduce the discomfort caused by this exercise. Roll the bar so that it is directly above your hips, and lean back against the bench so that your shoulder blades are near the top of it. Begin the movement by driving through your feet, extending your hips vertically through the bar. Your weight should be supported by your shoulder blades and your feet. Extend as far as possible, then reverse the motion to return to the starting position.'),
('OverHead Press', 'Stand with the bar on your front shoulders, and your hands next to your shoulders.
Press the bar over your head, until it’s balanced over your shoulders and mid-foot.Lock your elbows at the top, and shrug your shoulders to the ceiling. Hold the bar for a second at the top. Then lower it back to your front shoulders and repeat. Don’t use your legs, keep them straight'),
('Squats', 'Begin with the barbell supported on top of the traps. The chest should be up and the head facing forward. Adopt a hip-width stance with the feet turned out as needed. Descend by flexing the knees, refraining from moving the hips back as much as possible. This requires that the knees travel forward. Ensure that they stay align with the feet. The goal is to keep the torso as upright as possible. Continue all the way down, keeping the weight on the front of the heel. At the moment the upper legs contact the lower legs reverse the motion, driving the weight upward.'),
('Deadlifts', 'Approach the bar so that it is centered over your feet. Your feet should be about hip-width apart. Bend at the hip to grip the bar at shoulder-width allowing your shoulder blades to protract. Typically, you would use an alternating grip. With your feet and your grip set, take a big breath and then lower your hips and flex the knees until your shins contact the bar. Look forward with your head. Keep your chest up and your back arched, and begin driving through the heels to move the weight upward. After the bar passes the knees aggressively pull the bar back, pulling your shoulder blades together as you drive your hips forward into the bar. Lower the bar by bending at the hips and guiding it to the floor');

--- this will be a junction table that joins the worout table and the exercise table. Join queries will be made here
 CREATE TABLE "workout_exercise" (
  "id" SERIAL PRIMARY KEY, 
  "workout_id" INT references "workout",
  "exercise_id" INT references "exercise",
  "weight" int,
  "sets" int,
  "reps" int
);


--
SELECT * FROM "workout" ORDER BY "id";
SELECT * FROM "exercise" ORDER BY "id";
SELECT * FROM "user" ORDER BY "id";
SELECT * FROM "workout_exercise" ORDER BY "id";

--
INSERT INTO "exercise" ;

--
INSERT INTO "workout_exercise" ("workout_id", "exercise_id", "weight", "sets", "reps")
VALUES ('3', '3', '40', '2', '3')
RETURNING "workout_exercise"."id";


--
SELECT * FROM "workout_exercise";


---this is for the track table for the single workout
SELECT "workout_id", "exercise_id", "weight", "sets", "reps", "workout", "exercise"."name" FROM "workout_exercise" 
JOIN "workout"
ON "workout_id"="workout"."id"
JOIN "exercise"
ON "exercise_id"="exercise"."id"
WHERE "user_id" = 1;

----this select is for display on track workout table/page
SELECT "weight", "sets", "reps", "workout"."name", "exercise"."name" FROM "workout_exercise" 
JOIN "workout"
ON "workout_id"="workout"."id"
JOIN "exercise"
ON "exercise_id"="exercise"."id"
WHERE "user_id" = 1;

-- query to get 
SELECT "weight", "sets", "reps", "workout", "exercise" 
FROM "workout_exercise" 
JOIN "workout" 
ON "workout_id"="workout"."id" 
JOIN "exercise"
ON "exercise_id"="exercise"."id" 
WHERE "workout_exercise"."id"=1;

--
SELECT "weight", "sets", "reps", "workout", "exercise" 
FROM "workout_exercise" 
JOIN "workout" 
ON "workout_id"="workout"."id"
JOIN "exercise"
ON "exercise_id"="exercise"."id" 
WHERE "workout_exercise"."id"='156';

--query to select all of workout_exercise history
SELECT "workout_exercise"."date","workout"."name", "exercise"."name", "weight", "sets", "reps" FROM "workout_exercise"
JOIN "workout" 
ON "workout_id"="workout"."id"
JOIN "exercise"
ON "exercise_id"="exercise"."id" 
ORDER BY "workout_exercise"."date";

--query to get distinct date to map through
SELECT DISTINCT "date"
FROM "workout_exercise"
ORDER BY "date";

WHERE "workout_exercise"."id"=200;
    
-- query to delete an item from the history table 
DELETE FROM "workout_exercise" 
WHERE "id"= 153;

SELECT * FROM "workout_exercise";

--query to get dynamic dates from the database to map through
SELECT * FROM "workout_exercise"
JOIN "workout"
ON "workout_id"
WHERE "workout_id"="id"
ORDER BY "date";

--query to select all of workout_exercise history//-- query to get recent workout for edit/update functionality
SELECT "workout_exercise"."date", "workout"."name" AS "workout.name", "exercise"."name", "weight", "sets", "reps", "workout_exercise"."id" 
FROM "workout_exercise"
JOIN "workout" 
ON "workout_id"="workout"."id"
JOIN "exercise"
ON "exercise_id"="exercise"."id" 
WHERE "workout_exercise"."date"= CURRENT_DATE;


SELECT "workout_exercise"."date", "workout"."id" AS "workout_id", "exercise"."id" AS "exercise_id", "weight", "sets", "reps", "workout_exercise"."id" 
FROM "workout_exercise"
JOIN "workout" 
ON "workout_id"="workout"."id"
JOIN "exercise"
ON "exercise_id"="exercise"."id" 
WHERE "workout_exercise"."date" = CURRENT_DATE
ORDER BY "id" DESC;

-- INSERT query to post workout and exercise
INSERT INTO "workout_exercise" ("workout_id", "exercise_id", "weight", "sets", "reps")
VALUES ($1, $2, $3, $4, $5) 
RETURNING "workout_exercise"."id";

      --- query to GET newly posted workout 
SELECT "workout_exercise"."id","weight", "sets", "reps", "workout"."name", "exercise", "workout_exercise"."date", "exercise"."name" AS "exercise_name" 
FROM "workout_exercise" 
JOIN "workout" 
ON "workout_id"="workout"."id" 
JOIN "exercise"
ON "exercise_id"="exercise"."id" 
WHERE "workout_exercise"."id" =$1;

--- Query to UPDATE/EDIT workout/exercise
UPDATE "workout_exercise" 
SET "workout_id" =$1, 
"exercise_id" =$2, 
"weight"=$3,
"sets"=$4,
"reps" =$5
WHERE "workout_exercise"."id"=$6;

--- Query to get all workout dates from the database
SELECT DISTINCT "date"
FROM "workout_exercise"
ORDER BY "date";

---Query to get recently posted workout for edit/update page
SELECT "workout_exercise"."date", "workout"."id" AS "workout_id", "exercise"."id" AS "exercise_id", "weight", "sets", "reps", "workout_exercise"."id" 
FROM "workout_exercise"
JOIN "workout" 
ON "workout_id"="workout"."id"
JOIN "exercise"
ON "exercise_id"="exercise"."id" 
WHERE "workout_exercise"."date" = CURRENT_DATE
ORDER BY "id" DESC;

-- Query to get ALL workout from History
SELECT "workout_exercise"."date", "workout"."name" AS "workout", "exercise"."name", "weight", "sets", "reps", "workout_exercise"."id" 
FROM "workout_exercise" 
JOIN "workout" 
ON "workout_id"="workout"."id"
JOIN "exercise"
ON "exercise_id"="exercise"."id" 
ORDER BY "workout_exercise"."date" ASC;