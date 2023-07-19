#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
REMOVE=$($PSQL "TRUNCATE teams, games")
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != 'year' ]]
  then  
    # them name trong teams
    TEAM_ID1=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    TEAM_ID2=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $TEAM_ID1 ]]
    then
      INSERT1=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      TEAM_ID1=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi
    if [[ -z $TEAM_ID2 ]]
    then
      INSERT2=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      TEAM_ID2=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi
    # trong games
    # them values
    INSERT_YEAR=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$TEAM_ID1', '$TEAM_ID2', '$WINNER_GOALS', '$OPPONENT_GOALS')")
    # INSERT_YEAR=$($PSQL "")
  fi
done
