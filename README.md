# cg-cron
Run cron jobs in a Cloud Foundry app.

### Usage:

This app expects a bound service holding credentials and a `crontab.yml` or `crontab.json` with the following format:

**crontab.yml**

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

##### Job Parameters:
  
* `prep:`<br> 
    **Description:** An optional job which runs once, prior to the recurring job. Takes an array-formatted command with optional parameters. Specify a script here to avoid unexpected issues with variable expansion.<br>

   **Example:** `"/bin/bash, prep.sh"`
   
* `command:`<br>
  **Description:** The recurring job. An array-formatted command with optional parameters. Specify a script here to avoid unexpected issues with variable expansion.<br>
   **Example:** `"/bin/bash, job.sh, creds.username, creds.password"`
   
   Parameters passed to `PREP_JOB` and `CRON_JOB` with the `creds.` prefix will eval to variables held in the service specified by `CF_CREDS`.
   
* `schedule:`<br>
  **Description:** A cron schedule. For more information see: [Cron Ranges](https://www.npmjs.com/package/cron#cron-ranges). This parameter only applies to cronjobs, prep jobs run immediately.<br>
   **Example:** `"0 * * * * *"`

* `tz: [optional]`<br>
  **Description:** Time Zone for the cronjob.<br>
   **Example:** `"America/Los_Angeles"`
   
##### Credential Service:

This app will take advantage of secrets held in the credentials of either a bound service or a user-provided service. To store arbitrary credentials or non-public variables, use the syntax below to set up a user-provided service.

```
cf cups cg-cron-creds -p '{"username":"user", "password":"password"}'
```

### Running the Example:

Create the credential service.

```
cf cups cg-cron-creds -p '{"username":"user", "password":"password"}'
```

Push the app.

```
cf push
```

The app will:

1. Start the first prep job which counts to 3.
2. Start the second cronjob which echoes betelgeuse every 3 seconds.
3. When the first prep completes, start the first cronjob which echoes sirius every 5 seconds.

**Output:**

```
Found crontab.yml.
cg-cron started...
Found 2 jobs.
0:job-1
1:job-2
Preparing for: job-1 with job-1-prep
Creating Job: job-2
Prep: job-1-prep - Out: Count 1/3 
Prep: job-1-prep - Out: Count 2/3 
Job: job-2 - Out: betelgeuse
Job: job-2 - Exit: 0
Prep: job-1-prep - Out: Count 3/3 
Prep: job-1-prep - Exit: 0
Finished: job-1-prep
Creating Job: job-1
Job: job-2 - Out: betelgeuse
Job: job-2 - Exit: 0
Job: job-1 - Out: sirius
Job: job-1 - Exit: 0
```
