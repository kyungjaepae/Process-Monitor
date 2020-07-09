#!/bin/bash

#DO NOT REMOVE THE FOLLOWING TWO LINES
git add $0 >> .local.git.out
git commit -a -m "Lab 2 commit" >> .local.git.out
git push >> .local.git.out || echo


#Your code here
PW=$(cat $1)
PWlength=${#PW}
SCORE=0

#check password length (6 <= PWlength <= 32)
if [[ PWlength -lt 6 ]] || [[ PWlength -gt 32 ]] ; then
  echo Error: Password length invalid.
  exit
fi

#points per character
SCORE=$PWlength

#contains '#$+%@'
if [[ "$PW" =~ [\#$+%@] ]] ; then
  let SCORE=SCORE+5
fi

#contains '0-9'
if [[ "$PW" =~ [0-9] ]] ; then
  let SCORE=SCORE+5
fi

#contains alphabet
if [[ "$PW" =~ [A-Za-z] ]] ; then
  let SCORE=SCORE+5
fi

#contains repeated alphanumeric characters
if grep -Eq '([[:alnum:]])\1' <<< $PW ; then
  let SCORE=SCORE-10
fi

#contains 3+ consecutive lowercase characters
if [[ "$PW" =~ [a-z][a-z][a-z]+ ]] ; then
  let SCORE=SCORE-3
fi

#contains 3+ consecutive uppercase characters
if [[ "$PW" =~ [A-Z][A-Z][A-Z]+ ]] ; then
  let SCORE=SCORE-3
fi

#contains 3+ consecutive numbers
if [[ "$PW" =~ [0-9][0-9][0-9]+ ]] ; then
  let SCORE=SCORE-3
fi

echo Password Score: $SCORE