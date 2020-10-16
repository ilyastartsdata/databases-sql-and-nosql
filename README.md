![Geekbrains Logo](https://github.com/ilyastartsdata/introductiontopython/blob/master/gb.png)

# Databases. SQL & NoSQL.

Course from Geekbrains University

> About Geekbrains: We teach people to master programming, web design and marketing from the ground up. We conduct online courses with internships and free master classes, develop the community, cooperate with employment companies and continuously test new methods to improve the effectiveness of learning.

## List of topics

1. Webinar. Setting up the environment, DDL commands
2. Video lesson. Database management. SQL query language
3. Webinar. Introduction to database design
4. Webinar. CRUD-operations
5. Video lesson. Operators, filtering, sorting and limiting. Data aggregation
6. Webinar. Operators, filtering, sorting and limiting. Data aggregation
7. Video lesson. Complex enquiries
8. Webinar. Complex enquiries
9. Video lesson. Transactions, variables, views. Administration. Stored procedures and functions, triggers.
10. Webinar. Transactions, variables, views. Administration. Stored procedures and functions, triggers.
11. Video lesson. Optimisation of requests. NoSQL
12. Webinar. Optimisation of requests
13. Final project

## Installing / Getting started

### Installation on Mac OS X

Before installing MySQL on Mac OS X, you should install Command Line Tools for XCode from the AppStore. 

XCode is an integrated application development environment for Mac OS X and iOS. 

A full load of XCode is not necessary, just install the command line tools and the compiler. You can verify whether XCode is installed using the command line:

```shell
xcode-select -p
/Applications/Xcode.app/Contents/Developer
```

If the above path is replaced by a suggestion to install Command Line Tools, this package must be installed by executing the command:

```shell
xcode-select --install
```

Now you can start installing PHP, for which it is best to use the Homebrew package manager. At the time of writing, you could install Homebrew using a team:

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

However, the exact team can always be found on the official website http://brew.sh. 
Once installed, a brew command will be available on the command line, with which you can download, delete and update software packages.
Once the Homebrew manager has been installed, we will proceed with the installation of MySQL. You can do this with the command:
 
 ```shell
 brew install mysql
 ```
 
 If it is necessary that the MySQL server starts automatically when the operating system is loaded, a symbolic link to the MySQL distribution plist-file must be created in the Library/LaunchAgents directory of the home directory:
 
 ```shell
 ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
 ```

## Contributing

Pull requests are welcome.

## Source

[Geekbrains](https://geekbrains.ru)
