# Ceylon distribution

This is the 1.2 _"A Series Of Unlikely Explanations"_ release of the Ceylon 
command line tools (version 1.2.0). This is a production version of 
the platform.

Ceylon is a modern, modular, statically typed programming language 
for the Java and JavaScript virtual machines. The language features 
a flexible and very readable syntax, a unique and uncommonly elegant 
static type system, a powerful module architecture, and excellent 
tooling, including an awesome Eclipse-based IDE.

Ceylon enables the development of cross-platform modules which 
execute portably in both virtual machine environments. Alternatively, 
a Ceylon module may target one or the other platform, in which case 
it may interoperate with native code written for that platform.

Read more about Ceylon at <http://ceylon-lang.org>.

## Distribution layout

- `bin`            - Unix/Windows commands
- `contrib`        - Sample Ceylon command-line plugins
- `doc`            - Documentation about Ceylon including the spec in HTML and PDF format
- `lib`            - Required libraries for the Ceylon commands
- `repo`           - Required bootstrap Ceylon modules (language, tools)
- `samples`        - Sample Ceylon modules
- `templates`      - Templates for new Ceylon projects
- `LICENSE-ASL`    - The Ceylon ASL license
- `LICENSE-GPL-CP` - The Ceylon GPL/CP license
- `README.md`      - This file

## Building the distribution

To begin, make sure you have:

- the [Java 7 JDK][] or [Java 8 JDK][] and [Ant 1.8+][] installed and that both are working
correctly (if you installed Ant using your platform's package manager make
sure it installed the `ant-junit.jar` as well, which can be found in a package
named `ant-junit` or `ant-optional` depending on your distribution)
- [Git set up][] correctly
- created a new directory for the Ceylon project
- opened a terminal and changed to the newly created directory

[Java 7 JDK]: http://www.oracle.com/technetwork/java/javase/downloads/index.html
[Java 8 JDK]: http://www.oracle.com/technetwork/java/javase/downloads/index.html
[Ant 1.8+]: http://ant.apache.org/
[Git set up]: https://help.github.com/articles/set-up-git

And now you either set things up for HTTPS access (recommended for most people):

- Clone ceylon-dist:

<!-- lang: bash -->
    $ git clone https://github.com/ceylon/ceylon-dist.git
        
(If you encounter an issue like "fatal: unable to access 'https://github.com/ceylon/ceylon-dist.git/': 
Failed connect to github.com:443; No error", make sure you've set up your proxy as git config, ie: 
<!-- lang: bash -->
        $ git config --global http.proxy http://userName:password@proxyServer:port 

that should fix it.)
        
- Go into the newly created ceylon-dist directory and run the setup

<!-- lang: bash -->
    $ cd ceylon-dist ; ant setup

Or you set things up for SSH access (mainly contributors with push access):

- Make sure you have [GitHub SSH][] access set up correctly
- Clone ceylon-dist:

[GitHub SSH]: https://help.github.com/articles/generating-ssh-keys

<!-- lang: bash -->
    $ git clone git@github.com:ceylon/ceylon-dist.git

- Go into the newly created ceylon-dist directory and run the setup

<!-- lang: bash -->
    $ cd ceylon-dist ; ant setup-admins

After performing one of the two above setups continue with the following:

- Build the complete distribution by running

<!-- lang: bash -->
    $ ant clean publish

After this you'll have a newly built distribution in the `dist` 
folder of your current directory. You can run the `ceylon` command 
without any further setup or installation by simply running

<!-- lang: bash -->
    $ dist/bin/ceylon

But it's advisable to add the `ceylon` command to your `PATH` 
environment variable (either by adding the `bin` folder to your 
`PATH` or by creating a symbolic link to it in an appropriate place 
like `~/bin/`).

If at any time you want to update the distribution to the latest 
code from GitHub just run

<!-- lang: bash -->
    $ ant update
    $ ant clean publish

NB: The `update` command assumes that your projects are "clean", 
that is you don't have uncommitted changes. If that's not the case 
you'll have to manually update those projects or first stash your 
changes (using `git stash`).

After the build finishes the command line tools will be located in 
the `bin` directory.

- `bin/ceylon`     - The ceylon tool which provides at least the following subcommands:
    * `browse`     - Open module documentation in the browser
    * `classpath`  - Print a classpath suitable for passing to Java tools to run a given Ceylon module
    * `compile`    - Compile a Ceylon program for the Java backend
    * `compile-js` - Compile a Ceylon program for the JavaScript backend
    * `config`     - Manage Ceylon configuration files
    * `copy`       - Copy modules from one module repository to another
    * `doc`        - Document a Ceylon program
    * `help`       - Display help about another tool
    * `info`       - Print information about modules in repositories
    * `import-jar` - Import a Java `.jar` file into a Ceylon module repository
    * `new`        - Generate a new Ceylon project
    * `plugin`     - Package or install command-line plugins
    * `run`        - Run a Ceylon program on the Java VM
    * `run-js`     - Run a Ceylon program on node.js (JavaScript)
    * `src`        - Fetch source archives from a repository and extract them
    * `test`       - Test a Ceylon program on the Java VM
    * `test-js`    - Test a Ceylon program on node.js (JavaScript)
    * `version`    - Show and update version numbers in module descriptors
    * `war`        - Generate a WAR file from a compiled `.car` file

The API documentation for the language module `ceylon.language` may 
be found here:

- `repo/ceylon/language/1.2.0/module-doc/api`

## Running the sample programs

To compile and run the samples, read the README.md contained in
the `samples` sub folder for instructions.

## Tool usage

To see a list of command line options for a particular subcommand,
use the `help` subcommand. For example, to get help on the `compile` 
tool:

    ./bin/ceylon help compile

## Ant tasks for Ceylon

We include support for Ceylon ant tasks which are documented at 
<http://ceylon-lang.org/documentation/1.2/reference/tool/ant/>.

To run the "hello world" program using ant, type:

    cd samples/helloworld
    ant

## Source code

Source code is available from GitHub:

<http://github.com/ceylon>

## Issues

Bugs and suggestions may be reported in GitHub's issue tracker.

## Systems where Ceylon is known to work

Since Ceylon is running on the JVM it should work on every platform 
that supports a Java 7 or 8 compatible JVM. However we have tested the 
following platforms to make sure it works:

### Linux

- Ubuntu "quantal" 12.10 (64 bit) JDK 1.7.0_09 (IcedTea) Node 0.10.15
- Fedora 17 (64 bit) JDK 1.7.0_09 (IcedTea)
- Fedora 16 (64 bit), JDK 1.7.0_b147 (IcedTea)

### Windows

- Windows 7 (64 bit) 1.7.0_05 (Oracle)
- Windows Server 2008 R2 SP1 JDK 1.7.0_04

### OSX

- OSX 10 Lion (10.8.5) JDK 1.7.0_40 (Oracle) Node 0.10.17

## License

The Ceylon distribution is and contains work released

- partly under the ASL v2.0 as provided in the `LICENSE-ASL` file 
  that accompanied this code, and
- partly under the GPL v2 + Classpath Exception as provided in the 
  `LICENSE-GPL-CP` file that accompanied this code.

### License terms for 3rd Party Works

This software uses a number of other works, the license terms of 
which are documented in the `NOTICE` file that accompanied this code.

### Repository

The content of this code repository, [available here on GitHub][ceylon-dist], 
is released under the ASL v2.0 as provided in the `LICENSE-ASL` file 
that accompanied this code.

[ceylon-dist]: https://github.com/ceylon/ceylon-dist

By submitting a "pull request" or otherwise contributing to this 
repository, you agree to license your contribution under the license 
mentioned above.

## Acknowledgement

We're deeply indebted to the community volunteers who contributed a 
substantial part of the current Ceylon codebase, working often in 
their own spare time. The following people have contributed to this 
release:

Gavin King, Stéphane Épardaud, Tako Schotanus, Emmanuel Bernard, 
Tom Bentley, Aleš Justin, David Festal, Max Rydahl Andersen, 
David Festal, Enrique Zamudio, Lucas Werkmeister, Ross Tate,
Alexander Altman, Alexander Zolotko, Alex Szczuczko, 
Andrés G. Aragoneses, Anh Nhan Nguyen, Bastien, Bastien Jansen, 
Brice Dutheil, Carlos Augusto Mar, Casey Dahlin,
Charles Gould, Chris Gregory, Diego Coronel, Griffin DeJohn, 
Henning Burdack, John Vasileff, Julien Viet, klinger, 
Loic Rouchon, Luke deGruchy, Martin Voelkle, Matej Lazar, 
Michael Musgrove, Mr. Arkansas, Paco Soberón, Paŭlo Ebermann, 
Rohit Mohan, Roland Tepp, Stephane Gallès, Tomáš Hradec,
Toby Crawley, Vorlent
