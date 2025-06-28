
CREATE TABLE match_info (
  match_id INT PRIMARY KEY,
  date DATE,
  duration_minutes INT,
  winner VARCHAR(50),
  total_points INT
);

CREATE TABLE player_stats (
  match_id INT,
  player_name VARCHAR(50),
  aces INT,
  double_faults INT,
  first_serve_pct DECIMAL(4,2),
  winners INT,
  unforced_errors INT,
  total_points INT,
  PRIMARY KEY (match_id, player_name)
);

CREATE TABLE set_stats (
  match_id INT,
  set_number INT,
  p1_games INT,
  p2_games INT,
  tiebreak BOOLEAN,
  tb_p1 INT,
  tb_p2 INT,
  PRIMARY KEY (match_id, set_number)
);

CREATE TABLE rally_length_stats (
  match_id INT,
  player_name VARCHAR(50),
  rally_cat VARCHAR(10),
  points_won INT,
  PRIMARY KEY (match_id, player_name, rally_cat)
);

CREATE TABLE key_events (
  match_id INT,
  event VARCHAR(50),
  player_name VARCHAR(50),
  set_number INT,
  minute_mark INT
);


INSERT INTO match_info VALUES
(1, '2025-06-08', 329, 'Carlos Alcaraz', 385);

INSERT INTO player_stats VALUES
(1, 'Jannik Sinner', 8, 0, 0.54, 53, 64, 193),
(1, 'Carlos Alcaraz', 7, 7, 0.58, 70, 73, 192);

INSERT INTO set_stats VALUES
(1, 1, 6, 4, FALSE, NULL, NULL),
(1, 2, 7, 6, TRUE, 7, 4),
(1, 3, 4, 6, FALSE, NULL, NULL),
(1, 4, 7, 6, TRUE, 7, 3),
(1, 5, 6, 7, TRUE, 10, 2);

INSERT INTO rally_length_stats VALUES
(1, 'Jannik Sinner', '0-4', 80),
(1, 'Jannik Sinner', '5-8', 60),
(1, 'Jannik Sinner', '9+', 30),
(1, 'Carlos Alcaraz', '0-4', 85),
(1, 'Carlos Alcaraz', '5-8', 55),
(1, 'Carlos Alcaraz', '9+', 25);

INSERT INTO key_events VALUES
(1, 'championship_point_saved', 'Carlos Alcaraz', 4, 260);

-- MATCH SUMMARY REPORT: ROLAND GARROS 2025 FINAL --

SELECT
  '🎾 MATCH OVERVIEW' AS section_title,
  date,
  duration_minutes,
  winner,
  total_points
FROM match_info
WHERE match_id = 1;

-- Set-by-Set Scores
SELECT
  '📊 SET SCORES' AS section_title,
  set_number,
  p1_games AS sinner_games,
  p2_games AS alcaraz_games,
  tiebreak,
  tb_p1,
  tb_p2
FROM set_stats
WHERE match_id = 1
ORDER BY set_number;

-- Stats Comparison
SELECT
  '🧠 PLAYER STATS' AS section_title,
  player_name,
  aces,
  double_faults,
  first_serve_pct,
  winners,
  unforced_errors,
  total_points,
  (winners - unforced_errors) AS net_winners
FROM player_stats
WHERE match_id = 1
ORDER BY player_name;

-- Rally Length Effectiveness
SELECT
  '🚀 RALLY BREAKDOWN' AS section_title,
  rally_cat,
  player_name,
  points_won
FROM rally_length_stats
WHERE match_id = 1
ORDER BY rally_cat, player_name;

-- Key Events (clutch moments)
SELECT
  '🔥 KEY MOMENTS' AS section_title,
  event,
  player_name,
  set_number,
  minute_mark
FROM key_events
WHERE match_id = 1
ORDER BY minute_mark;
