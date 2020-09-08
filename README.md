# Nexus Repo Manager
Script to create Nexus repositories and maintain a know state


## Setup
Run the following script to install all required dependencies:
```
script/bootstrap
```

Either create a `.env` file based off of [.env.template](.env.template) or pass in the required values as environment variables directly to the command.


## Configuration
Place JSON representations of the repositories you want to manage in `/configs/`. You can dump the current repository configuration as a starting point via curl:
```
curl -X GET "https://[NEXUS_HOSTNAME]/service/rest/beta/repositories" -H "accept: application/json" -u NEXUS_USERNAME %> [PATH]/configs/[ENV].json
```

or using the online API:
- Log in with a privileged user
- Navigate to `https://[NEXUS_HOSTNAME]/#admin/system/api`
- Scroll down to Repository Management
- Expand the entry titled `GET   /beta​/repositories   List repositories`
- Click on `Try it out` and then on `Execute`
- Copy the result from the `Response body` or click on `Download`

The API also provides documentation on what elements are available and their structure if you want to add/modify the configs by hand.


## Usage
To run the script:
```
bin/nexus_repo_manager ENV   # <-- ENV is the name of the config you want to apply without the .json extension
```

**NOTE:** If you pass in a config (ex: `ENV1`), but your `.env` is pointed to `ENV2`, the script will create the `ENV1` repos in `ENV2`.

**NOTE:** If an invalid or no environment is passed in, the script will list the valid environments for you. This list is generated from the JSON files under `configs/`.

**NOTE:** This script does not _currently_ support modifying repositories. Only creation.


## Tests
To run all, or a subset, of the unit tests run one of the following commands:
```
script/test
script/test [NAME_OF_DIRECTORY]
script/test [NAME_OF_FILE]
script/test [NAME_OF_FILE]:[LINE_NUMBER]
```
