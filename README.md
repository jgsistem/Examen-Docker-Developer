# Examen  Final Docker – Developer

El repositorio contiene:

1. La carpeta Docker-Compose: contiene el archvio docker-compose.yml, las imagenes docker que neceista este archivo se encuentran en el repositorio docker hub 
2. La carpeta DockerFile- apiAcceso: contiene el docker file del api de acceso, que se encuentra en docker hub como dockermarvic/apiacceso
3. La carpeta DockerFile-apiMicro1: contiene el docker file del api de cruds, que se encuentra en docker hub como dockermarvic/micro1
4. La carpeta DockerFile-apiMicro2: contiene el docker file del api de venta y reporte, que se encuentra en docker hub como dockermarvic/micro2
5. La carpeta DockerFile – database: contiene el docker file de creación de la bd postgres, que se encuentra en docker hub como dockermarvic/mi_postgres
6. La carpeta DockerFile-proxy: contiene el docker file  archivo nginx del server proxy, que se encuentra en docker hub como dockermarvic/apiproxy
7. La carpeta cineapp-frontend: contiene el fuente y docker file del frontend, que se encuentra en docker hub como dockermarvic/cinefrontend
8. La carpeta Docker Swarn compose: contiene el docker-compose.yml para swarm.

# EJECUTAR DOCKER COMPOSE - HOST UBUNTU

En la carpeta Docker-Compose se encuentra el archivo docker-compose.yml
para probarlo se sigue los siguientes pasos:

1. se abre una terminal y se navega hasta el directorio del archivo docker-compose.yml

2. se ejecuta el siguiente comando : docker-compose up -d 

3. Para probar el aplicativo se ingresa en el navegador web http://localhost:8090

3. Se ingresa las credenciales de acceso:

- usuario: admin

- contraseña : admin

4. En el Menu lateral se navegar hasta la opción REPORTES

- Se visualiza el grafico de ventas con información en la base de datos

5. Luego en el Menu de la barra lateral se ingresa a VENTA ENTRADAS

6. Se elije al cliente y se selecciona la película

7. luego se debe elegir los asientos

8. luego se debe elegir los piqueos

9. se confirma la operación presionando ACEPTAR

10. Luego se regresa a los REPORTES

- Entonces el grafico cambio por el ingreso de la nueva venta

# EJECUTAR CLUSTER DOCKER SWARM

## 1. Crear maquinas virtuales :

- Se ejecutan los siguientes comandos:

1. Se crea el manager1

docker-machine create --driver virtualbox --virtualbox-boot2docker-url=https://github.com/boot2docker/boot2docker/releases/download/v18.05.0-ce/boot2docker.iso manager1

2. Se crea el manager2

docker-machine create --driver virtualbox --virtualbox-boot2docker-url=https://github.com/boot2docker/boot2docker/releases/download/v18.05.0-ce/boot2docker.iso manager2

3. Se crea el worker1

docker-machine create --driver virtualbox --virtualbox-boot2docker-url=https://github.com/boot2docker/boot2docker/releases/download/v18.05.0-ce/boot2docker.iso  worker1

4. Se crea el worker2

docker-machine create --driver virtualbox --virtualbox-boot2docker-url=https://github.com/boot2docker/boot2docker/releases/download/v18.05.0-ce/boot2docker.iso  worker2

5. Se inicia el docker swarn:

docker-machine ssh manager1 "docker swarm init --advertise-addr $(docker-machine ip manager1)"

6. Se obtiene el token para agregar a manager2 a swarm

docker-machine ssh manager1 "docker swarm join-token manager"

7. Se agrega a manager2 a swarn

docker-machine ssh manager2 "docker swarm join --token SWMTKN-1-5zbsvscxzvz3iatbo68tksk26hmgm7of3pjk304guqucjypjdv-0kn9okpw7a6d3ha300vbzqxq4 192.168.99.100:2377"

8. añadir a worker1

docker-machine ssh worker1 "docker swarm join --token SWMTKN-1-5zbsvscxzvz3iatbo68tksk26hmgm7of3pjk304guqucjypjdv-b81bo9g81va9d11h82scmkvwc 192.168.99.100:2377"

9. añadir a worker2

docker-machine ssh worker2 "docker swarm join --token SWMTKN-1-5zbsvscxzvz3iatbo68tksk26hmgm7of3pjk304guqucjypjdv-b81bo9g81va9d11h82scmkvwc 192.168.99.100:2377"

10. Establecer variables de entorno a manager1
docker-machine env manager1

11. Ejecutar comando que nos indica

eval $(docker-machine env manager1)

12. verificar el cluster

docker node ls

## Ejecutar el archivo docker-compose.yml

- Navegar al directorio Docker Swarn compose

1. Ejecutar el siguiente comando desplegar el aplicativo en el cluster docker swarm

docker stack deploy -c docker-compose.yml cine

2. Se verificar el despliegue con los siguientes comandos

docker stack ps cine

docker service ls

3. se puede verificar los log de la base de datos

docker service logs -f cine_postgres_server

4. se puede verificar los log del api de seguridad

docker service logs -f cine_apiacceso

5. se puede verificar los log del api de CRUD

docker service logs -f cine_apimicro1

6. se puede verificar los log del api de VENTA

docker service logs -f cine_apimicro2

7. Se levanta el front end en angular y cambiamos la constante HOST por el ip del manage1

8. Se realizan las pruebas en el aplicativo

9. todos estos pasos se encuentran en el archivo ExamenFinal.odt
















