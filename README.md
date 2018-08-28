# Livezilla Docker image

Docker image ready for PAAS

# Instructions
1. First launch it in INSTALL_MODE no need to specify the ENV of the DB.
1. Go to Livezilla URL and follow the steps for configuring it.
1. Destroy the container
1. Launch another one with the INSTALL_MODE at false with all the environement variables
1. All set !

# Features
* Forcing https is built-in via http_x_forwarded_proto.
* Possibility to specify the version in the dockerfile

# Environment variables availables : 
  * LIVEZILLA_ID (Random number)
  * LIVEZILLA_PR_CR (Random String)
  * DB_HOST
  * DB_USERNAME
  * DB_PASSWORD
  * DB_DATABASE
  * DB_PREFIX
  * DB_ENGINE (MyISAM / InnoDB)
  * INSTALL_MODE (true / false)

# Contribute
Feel free to contribute or to tell me if you see something to add / fix
