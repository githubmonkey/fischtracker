
# Prerequisits for all firebase python ops:
## Set credentials via env

Set variable in shell and editor terminal, don't change env name or google auth will not find default

```bash
export GOOGLE_APPLICATION_CREDENTIALS=/Users/.../keystores/my_project.json
```

## Generate a new service account key

Firebase console -> Project Settings -> Service accounts -> `Generate new private key`

## Init python environment with pyenv

```bash
pyenv version  # to verify version
# should be 3.10.11, otherwise use 'pyenv local 3.10.11'
pyenv virtualenv fischfinder  # TODO: do we need to call this every time?
pyenv activate fischfinder
### DO WORK ###
pyenv deactivate
```

# Upload/Download scripts

## Download a json dump from firebase

Restrictions:

* only works on a single collection, no nesting
* timestamps are converted to UTC (Firebase doesn't seem to keep the timezone, just takes UTC and converts it to browser default in console)
* keys are sorted but empty keys are stripped only during upload

```bash
python ./firestore_to_json.py users/xxx/cats cats.json
```

## Upload local json to firebase

NOTE: timestams are uploaded as UTC but firebase will display them in local 

```bash
# source path must appear at top level in local dump. 
# Target path can be anything but must be odd numbered(coll/doc/coll)
python ./json_to_firestore.py cats.json users/xxx/cats
```

## More 

See baumfinder-utils
