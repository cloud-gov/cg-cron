# Lets make sure we're prepped.
set -e

export PATH=~/:$PATH

if [ -e .prepped ]
  then
    /bin/bash set-quota-auditor.sh $1
  else
    echo "Nope. We're unprepaed."
fi
