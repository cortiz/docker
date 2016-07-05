# Crafter CMS Docker files

## General Notes:

All crafter own software runs under _/home/craftercms_ and with the user _crafter_.
All services output are redirected to /dev/stdout.
All services are startup and shutdown by supervisor

### Crafter Base
This is the base image for all craftercms containers.
by default runs an empty tomcat with default tomcat wars deployed

#### Exported Variables
List of all environment variables

```
HOME=/home/crafter
CRAFTER_HOME=$HOME/craftercms
JDK_HOME=$HOME/jdk
JAVA_HOME=$JDK_HOME/jre
CATALINA_HOME=$CRAFTER_HOME/apache-tomcat
PATH=$PATH:$JDK_HOME/bin:$CATALINA_HOME/bin
TMP_PATH=$HOME/tmp
CRAFTER_DEPLOYER_HOME=$CRAFTER_HOME/deployer
CRAFTER_DATA_PATH=$CRAFTER_HOME/data
CRAFTER_DB_PATH=$CRAFTER_DATA_PATH/db
CRAFTER_REPO_PATH=$CRAFTER_DATA_PATH/repo
```

#### Crafter Software bundle.
Latest snapshots from sonatype.

#### Packages & software bundle
1. Ubuntu Xenial 16.04 LTS
2. wget unzip git jsvc supervisor nano
3. Oracle JDK 1.8_U92
4. Apache Tomcat 8.5.3
5. Solr 4.10

#### Exported ports
 8080,8009
#### Exported Volumes
None

### Crafter Local Development
This image will create containers with Crafter Engine,Studio,Search and Solr-Crafter running in a Disk & Derby configuration. Use the exported Volumes to backup and restore
site contents.

#### Exported ports
 9191

#### Exported Volumes

| Path | Explanation |
|  :---:  |  :---: |  :---: |
| ${CRAFTER_HOME}/data  | Crafter repository and Derby folder |
| ${CRAFTER_HOME}/deployer/conf  | Crafter deployer configuration  |
| ${CRAFTER_HOME}/deployer/target | Crafter deployer configuration  |

### Crafter Authoring
This image will create containers for a Crafter authoring environment , backed by a Mysql db and a disk repo, also has a Crafter engine running in preview

#### Packages & software bundle
1. Apache 2.4.x
2. Mysql 5.7
3. Mysql-connector-java 5.1.38

#### Exported ports
 80,9191
#### Exported Volumes

| Path | Explanation |
|  :---:  |  :---: |  :---: |
| ${CRAFTER_HOME}/data  | Crafter repository and Derby folder |
| ${CRAFTER_HOME}/deployer/conf  | Crafter deployer configuration  |
| ${CRAFTER_HOME}/deployer/target | Crafter deployer configuration  |
| $CRAFTER_HOME/www/ | Apache Document Root   |
| /var/lib/mysql/| Mysql DB and configuration  |
| /etc/apache2/sites-enabled-ext | Apache extension for configuration, its loaded last in the apache2.conf |

##### Apache Mods enabled
1. cgid
2. headers
3. proxy
4. proxy_http
5. proxy_ajp
6. reqtimeout
7. rewrite ssl
8. socache_shmcb
9. expires

#### Notes:
In this image the apache is setup as a full proxy, apache will not serve any static-assets.

Note that /solr-crafter is restricted to localhost only.

### Crafter Delivery
This image will create containers of a Crafter delivery node, this is a Engine running in default node with Search and crafter deployer setup for a single site configuration

#### Packages & software bundle
1. Apache 2.4.x

##### Apache Mods enabled
1. cgid
2. headers
3. proxy
4. proxy_http
5. proxy_ajp
6. reqtimeout
7. rewrite ssl
8. socache_shmcb
9. expires

#### Exported ports
 80,9191

#### Exported Volumes

| Path | Explanation |
|  :---:  |  :---: |  :---: |
| ${CRAFTER_HOME}/data  | Crafter repository and Derby folder |
| ${CRAFTER_HOME}/deployer/conf  | Crafter deployer configuration  |
| ${CRAFTER_HOME}/deployer/target | Crafter deployer configuration  |
| $CRAFTER_HOME/www/ | Apache Document Root   |
| /var/lib/mysql/| Mysql DB and configuration  |
| /etc/apache2/sites-enabled-ext | Apache extension for configuration, its loaded last in the apache2.conf _*should*_ override any preview configured vhost|

#### Notes:
All files under /static-assets with in the $CRAFTER_HOME/www/ folder will be serve by apache and will not proxy to tomcat.

Note that /solr-crafter is restricted to localhost only.

## Additional Notes
