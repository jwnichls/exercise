Overview
===

This is a modification of the original project that allows for the running of multiple campaigns 
from the same rails application.  There is no longer any need to deploy a separate modified version 
of the application for each each campaign.

I have not modified all of the instructions below to reflect this change, though I have done my best
to make as many changes as I could.

Requirements
===

This project uses Ruby 2.0.0 and Rails 4.  See the Gemfile for a complete list of gems.

Installation and Running
===

Deploy the application to heroku or your platform of choice.

Login with your new environment-based twitter account. the first user is assumed to be the admin and 
has special priveleges in the environment.  You can make other users admins later, though right now
this must be done by setting the "user_level" field for the desired user in the database to "admin".

If you're running on heroku, add the scheduler addon

Add the app:disable_post task to run however frequently you want. This is hard coded to remove posts > 3 days old.

You can test any rake command with rake app:&lt;command&gt;

Set Up A Campaign
===

One you launch the system and login, you can go to the /campaigns/ page to create a campaign.  You must specify the 
following:

* Twitter User to lead the campaign (chosen from drop-down of all users in application)
* Campaign name
* Instructions for the posts page in HTML
* Properties file for MTurk HITs
* Question file for MTurk HITs

Once you save this information, you will be directed to the front page of the campaign.  You can then fill out the survey 
and enter some initial priming posts.

If you are using Heroku, you should also add the app:launch_hit\[&lt;campaign_id&gt;\] task to the scheduler. These hits will be 
based on the data you specified above for your campaign.  You can test the HIT by running the app:launch_hit\[&lt;campaign_id&gt;,1\] 
task. The extra parameter will force the task to use the sandbox instead of production.

Connect to heroku db from a gui
===
pkinnair@ubuntu:~/code/justice$ heroku pg:info
heroku pg:credentials=== HEROKU_POSTGRESQL_COBALT_URL (DATABASE_URL)
Plan:        Dev
Status:      available
Connections: 2
PG Version:  9.2.4
Created:     2013-07-18 20:16 UTC
Data Size:   7.5 MB
Tables:      8
Rows:        413/10000 (In compliance)
Fork/Follow: Unsupported

pkinnair@ubuntu:~/code/justice$ heroku pg:credentials HEROKU_POSTGRESQL_COBALT_URL
Connection info string:
   "dbname=d5odpd7has084g host=ec2-54-225-68-241.compute-1.amazonaws.com port=5432 user=jrzbfvggmhswsh password=wYbayToB8JQSzIT533QV1P7XFc sslmode=require"
Connection URL:
    postgres://jrzbfvggmhswsh:wYbayToB8JQSzIT533QV1P7XFc@ec2-54-225-68-241.compute-1.amazonaws.com:5432/d5odpd7has084g
pkinnair@ubuntu:~/code/justice$ 
