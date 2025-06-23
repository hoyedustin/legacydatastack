# set up enviornment

## to be consistent with our prefect-legacy repo, we will be using python 3.10 - it should be already be installed from using the prefect-legacy repo

## virtual enviornment

```
$ python3 --version
$ python3.10 -m venv .venv-3.10
$ source .venv-3.10/bin/activate
(venv) $
```
## install requirements - we are starting with the example same requirnments from prefect-legacy as of 4/10/2025. Any new or specific requirnments to this repo will need to be added
`pip install -r requirements.txt`


## Connecting/Snowflake to DBT

First we need to generate a public/private key pair for authentication. Snowflake is switching over to MFA so UN/PW won't work

# public private key pair set up

#### gen private key encrypted
`mkdir keys`
`cd keys`
`openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out rsa_key.pem`
-rw-------   1 kcbigring  staff  1886 Apr  4 09:19 rsa_key.pem
-rw-r--r--   1 kcbigring  staff   451 Apr  4 09:20 rsa_key_kcbigring.pub

#### gen public key
`openssl rsa -in rsa_key.pem -pubout -out rsa_key_kcbigring.pub` (replace kcbigring w/ your github handle name)

#### assign the public key to the first slot on the snowflake user

NOTE: Make sure that you have a private/public key pair set up in Snowflake BEFORE attempting to log into DBT. We are switching off of UN/PW and are using Key Pair Auth due to MFA rollout

# using private/public keys to authenticate in DBT Cloud

After logging into DBT, there are TWO places where you are required to enter credentials/Snoflake information in order for Snowflake to work: Credentials/Connections

Credentials: After creating a new project

NOTE: The following information is under the "Account" section in Snowflake under the User Profile under "View Account Details"

Once you fill out that info, you will need to configure the connection in DBT to Snowflake. You will have to put Snowflake Account, Database and Warehouse.

Next, in the "Your Profile" section under "Credentials", you will put in the same Snowflake Account, Database and Warehouse. Then under "Auth Method", you put your username, private key and passkey passphrase. 

NOTE: When entering in the private passkey, do NOT include the commented out portions that say "#####Begin Private Key#####" and "#####End Private Key#####. This will cause the connection to fail.

