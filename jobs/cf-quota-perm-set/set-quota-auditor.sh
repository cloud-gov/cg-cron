# This script walks through each org in a Cloud Foundry instance setting
# OrgAuditor and SpaceAuditor permissions at each level.
#
# Usage:
#
#  set-quota-auditor.sh AUDIT_USER
USER_EMAIL=$1

# Strip the host portion of the email supplied.
USER_NAME="${USER_EMAIL%%@*}"

# Initialize counters for success / failure.
org_count=0
spc_count=0
err_count=0

# Loop over org and spaces.
# Use process substitution to keep track of the counts in this loop.
# http://mywiki.wooledge.org/ProcessSubstitution
while read ORG_NAME
  do 
    echo "Setting: $ORG_NAME"
    cf set-org-role $USER_NAME $ORG_NAME OrgAuditor > /dev/null
      if [ $? -ne 0 ]; then
        err_count=$((err_count+=1))
      else
        org_count=$((org_count+=1))
      fi
  
  cf target -o $ORG_NAME > /dev/null
  
  while read SPACE_NAME
    do
      echo "Setting: $ORG_NAME / $SPACE_NAME" 
      cf set-space-role $USER_NAME $ORG_NAME $SPACE_NAME SpaceAuditor > /dev/null
        if [ $? -ne 0 ]; then
          err_count=$((err_count+=1))
        else
          spc_count=$((spc_count+=1))
        fi
  done < <(cf spaces | awk 'm;/^name/{m=1}')
done < <(cf orgs | awk 'm;/^name/{m=1}')

# Print a summary.
echo "Set: Orgs - $org_count / Spaces - $spc_count / Errors - $err_count"
