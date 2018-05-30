
# CrafterCMS Docker containers.

## What's inside :

* Ubuntu 18.04 (bionic)
* OpenJDK 8 headless 
* wget 
* lsof 
* openssh-client

## Usage

### Run a Container

#### Authoring 
    ```bash
     docker run --detach  --publish 8080:8080 --publish --name crafterAuth --restart always \
     -v LOCAL_MNT:/opt/crafter/data cortiz/authoring
    ```
### Delivery 
    ```bash                                                                                                        
     docker run --detach  --publish 8080:8080 --publish --name crafterDelivery --restart always \                      
     -v LOCAL_MNT:/opt/crafter/data cortiz/delivery                                                           
     ```
#### Creating a site 

	1. Start or create the Crafter Delivery container.
	2. Run 
	```bash
		docker exec -i -t CONTAINER_ID/CONTAINER_NAME /bin/bash
	```
	3. Follow [https://docs.craftercms.org/en/3.0/system-administrators/activities/setup-site-for-delivery.html](this instructions)

### Update a container 

#### Authoring
	```bash
	docker pull cortiz/authoring
	docker stop CONTAINER_ID/CONTAINER_NAME
	docker rm CONTAINER_ID/CONTAINER_NAME
	docker run --detach  --publish 8080:8080 --publish --name crafterAuth --restart always \                      
    -v LOCAL_MNT:/opt/crafter/data cortiz/authoring  
	``` 

#### Delivery 
	```bash
	docker pull cortiz/delivery
	docker stop CONTAINER_ID/CONTAINER_NAME
	docker rm CONTAINER_ID/CONTAINER_NAME
	docker run --detach  --publish 8080:8080 --publish --name crafterDelivery --restart always \
	-v LOCAL_MNT:/opt/crafter/data cortiz/delivery··
	```
*Note* You don't need to rerun the create.

## Exposed Ports
#### Authoring
* 8080	Tomcat HTTP Conector
* 8009  Tomcat AJP Conector
* 9191  Crafter Deployer Web API 
* 8694  Solr HTTP Web API
* 33306 Mysql Port.

#### Delivery
* 9080	Tomcat HTTP Conector
* 9009  Tomcat AJP Conector
* 8695  Crafter Deployer Web API 
* 9192  Solr HTTP Web API