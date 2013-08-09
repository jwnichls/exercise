Installation and Running
===

For each topic/environment you want to run, create a twitter account and a new heroku account

Install heroku toolbelt and heroku:accounts (http://martyhaught.com/articles/2010/12/14/managing-multiple-heroku-accounts/)

run $ heroku accounts:add <some_arbitrary_name_that_describes_the_environment> --auto

authenticate to your heroku account

add a section to the project's .git/config file along the lines of (nojustice is the heroku:account name i'm using in this example):

[remote "heroku"]
	url = git@heroku.nojustice:inojustice.git

use $ heroku accounts:set <account_name>



to set the right account name when you're using it. you might want to add this line to your .rvmrc file for the project so it'll autoset the account when you're in the working directory


Presumably you also want a private github/bitbucket/gitorious account for the project, so create and add that too

Push the codebase to the heroku instance and login with your new environment-based twitter account. the first user is assumed to be the admin and has special priveleges in the environment.


Before you can visit the site, you need to load the database. For some reason $ heroku run rake db:migrate has a problem so you might be better off loading with $ heroku run rake db:schema:load

Things to modify
====
Add the scheduler addon to heroku
Add the disable_post task to run however frequently you want. This is hard coded to remove posts > 3 days old.
You can test any rake command with rake <command>

Add the launch_hit task to scheduler. These hits will be based on config/recruit_twitterer.*

Modify the topic of the campaign in 2 files:

app/views/shared/_instructions.html.erb
and
app/views/static_pages/home.html.erb


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
