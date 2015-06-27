# cf-quota-perm-set
Periodically set OrgAuditor and SpaceAuditor perms across a Cloud Foundry environment.

### Usage:

See [cf-cron](https://github.com/18F/cf-cron) for general usage.

### Running the Job:

The `set-quota-auditor.sh` script expects to find all the parameters it needs in order to authenticate and set permissions. 

Create a credential service with following keys and appropriate values.

```
cf cups cf-cron-creds -p '{"cf_api":"API_URL", "username":"ORGMANAGER", "password":"PASSWORD", "cf_org":"DEFAULT_ORG", "cf_space":"DEFAULT_SPACE", "auditor":"AUDITOR_USERNAME"}'
```

Push the app.

```
cf push
```
The app will set *Auditor permissions for every Org / Space in the environment.

```
Started...
Prep_Out: API endpoint: API_URL
Prep_Out: Authenticating...
Prep_Out: OK
Prep_Out: Targeted org DEFAULT_ORG
Prep_Out: Targeted space DEFAULT_SPACE
Prep_Out:                    
API endpoint:   API_URL (API version: x.x.x)   
User:           USERNAME
Org:            DEFAULT_ORG   
Space:          DEFAULT_SPACE
Prep_Exit:0
Scheduling...
Setting: org1
Setting: org1 / space1
Setting: org1 / space2
...
Setting: org43 / space4
Setting: org43 / space4
Set: Orgs - 43 / Spaces - 211 / Errors - 0
```