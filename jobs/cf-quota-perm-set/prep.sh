# Lets get prepped.
set -e

export PATH=~/:$PATH

cf login -a $1 -u $2 -p $3 -o $4 -s $5

touch .prepped
