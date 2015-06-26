# Lets make sure we're prepped.
if [ -e .prepped ]
  then
    echo "Yes, we're prepped with - Username: $1 - Password: $2"
  else
    echo "Nope. We're unprepaed."
fi
