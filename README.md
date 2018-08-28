# Livezilla Docker image

Docker image ready for Paas

# Introduction
You'll need to deploy in two phases because Livezilla create the tables in DB only in install mode.

# Features
* Forcing https is built-in via http_x_forwarded_proto.
* Possibility to specify the version in the dockerfile

# Environment variables availables (Mandatory): 
  * LIVEZILLA_ID
  * LIVEZILLA_PR_CR
  * DB_HOST
  * DB_USERNAME
  * DB_PASSWORD
  * DB_DATABASE
  * DB_PREFIX
