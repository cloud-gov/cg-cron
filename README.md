# cf-cron
Run cron jobs in a Cloud Foundry app.

### Multi-Job:

This expects a crontab.yml or crontab.json with the format:

**YAML:**

```
---
jobs:
  - name: job-1
    schedule: "0 * * * * *"
    command: "/bin/bash, job.sh, creds.key"
    tz: "America/Los_Angeles"
    prep:
      name: job-1-prep
      command: "/bin/bash, prep.sh, creds.username, creds.password"
  - name: job-2
    schedule: "0 * * * * *"
    command: "/bin/bash, job2.sh, creds.key"
```

Each cronjob can have an optional `prep` subjob which will run immediately upon starting the app. Cronjobs run on the provided `schedule:`.

**Output:**

```
Found crontab.yml.
cf-cron started...
Found 2 jobs.
0:job-1
1:job-2
Preparing for: job-1 with job-1-prep
Prep: job-1-prep - Out: Authenticating...
Prep: job-1-prep - Out: OK
Prep: job-1-prep - Exit: 0
Finished: job-1-prep
Creating Job: job-1
Job: job-1 - Out: Running...
```

### Usage:

This app expects a few environment variables and a bound service.

##### Variables:

* `CF_CREDS:`<br>
  **Description:** The name of a service holding secrets for use by the prep or job scripts.<br>
  **Example:** `cf-cron-creds`
  
##### Credential Service:

This app will take advantage of secrets held in the credentials of either a bound service or a user-provided service. To store arbitrary credentials or non-public variables, use the syntax below to set up a user-provided service.

```
cf cups cf-cron-creds -p '{"username":"user", "password":"password"}'
```