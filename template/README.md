# Write your own application

Start with the template, which contains a demo web application named `ceylon.demo.net` and contains the following structure:

```
- README               # Useful info
- .openshift           # OpenShift-specific settings
 - config              #  Configuration
  - modules            #   Extra module repo where you can put your dependencies that cannot be found on Herd
  - ceylon.properties  #   Your application Ceylon settings (see below)
 - action_hooks        #  Action hooks to control application lifecycle
 - cron                #  Cron jobs
 - markers             #  OpenShift markers
- modules              # Leave empty, it won't be used
- source/...           # Your module source files
- web-content/...      # The default template module's resources, you can remove it if you don't need it
```

You can replace the source module with the one you want to run, or if you only want to run a single module,
see the Configuration section below. You can put any extra module dependency you want in `.openshift/config/modules`
if they cannot be found on Herd. Then don't forget to specify your main module in `.openshift/config/ceylon.properties`
and you're set!

# Configuration of your application

The following environment variables can be configured in `.openshift/config/ceylon.properties`:

- `ceylon_module`: the module you want to run
- `ceylon_module_args`: arguments you want to pass to your module
- `ceylon_repos`: list of repos for compile/run (has a default value)
- `ceylon_args`: arguments passed to `ceylon run` and `ceylon compile`
- `ceylon_run_args`: arguments passed to `ceylon run` (has a default value)
- `ceylon_compile_args`: arguments passed to `ceylon compile`
- `ceylon_encoding`: source file encoding (defaults to `utf8`)
- `JAVA_OPTS`: JVM options use for both compilation and runtime

# Environment variables

The following environment variables will be available to your application and configuration:

- `CEYLON_HOME`: The Ceylon distribution path
- `CEYLON_BIN_DIR`: The Ceylon distribution bin directory (contains the `ceylon` command)

- `OPENSHIFT_CEYLON_MODULES_REPO_DIR`: The module repository where we compile your application
- `OPENSHIFT_CEYLON_LOG_DIR`: The log dir for the Ceylon cartridge
- `OPENSHIFT_CEYLON_RUN_DIR`: The run dir for the Ceylon cartridge

- `CEYLON_LOG_PATH`: Path to the Ceylon cartridge log file
- `CEYLON_PID_FILE`: Path to the Ceylon cartridge run PID file (the PID of your Ceylon application)

- `OPENSHIFT_CEYLON_IP`: The (local) IP your application should bind on
- `OPENSHIFT_CEYLON_PORT`: The (local) port your application should bind on

On top of the [standard OpenShift ones](https://developers.openshift.com/en/managing-environment-variables.html):

- `OPENSHIFT_APP_DNS`: The public external DNS under which your app will be visible
- `OPENSHIFT_APP_NAME`: Your application name
- `OPENSHIFT_REPO_DIR`: Where your application will be checked out (where your source files will reside)
- `OPENSHIFT_DATA_DIR`: A persistent data directory
- `OPENSHIFT_TMP_DIR`: A temporary directory you can use
- `OPENSHIFT_<database>_DB_HOST`: The host name or IP address used to connect to the database
- `OPENSHIFT_<database>_DB_PORT`: The port the database server is listening on
- `OPENSHIFT_<database>_DB_USERNAME`: The database administrative user name
- `OPENSHIFT_<database>_DB_PASSWORD`: The database administrative user’s password

# Markers

You can customise how your application will be run in `.openshift/markers` by placing
the following empty source files:

- `enable_aether`: Will add the aether repo to your compilation and run (there is more to it than just adding 
  `--rep aether`, because we need to tell Maven where to cache stuff so we have to create folders and a
  `settings.xml` and point to it, so just use this rather than deal with it yourself)
- `enable_jpda`: Will run your application with JPDA running on port 8787
