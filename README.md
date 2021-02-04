# Pet's Meet 

*"Pet's Meet dating for THEM too !"*

New pet owner relationship application.

🐶 🐱

## 🐾 Getting Started

This project is a starting point for a Flutter application.

### Step 1:

To download flutter to run this project [click here](https://flutter.dev/docs/get-started/install)

### Step 2:

Download or clone this repo by using the link below:

```https://github.com/Hugooboutot/PetsMeetapp.git```

### Step 3:

Go to project root and execute the following command in console to get required dependencies:

```flutter pub get```

### Step 4:

Run the project

```flutter run```

## 🔨 Installation of docker

First instal docker to use our services that use docker.

[Click here to install docker desktop](https://docs.docker.com/desktop/)

## 🔐 Docker https certificat installation

After the installation of docker you can now build the container for our service.

Unless they are already running, this command also starts any linked services.

Go to docker directory :

```docker-compose up -d web```

After doing this, the server is now ready you can now go on your [https://localhost](https://localhost) and the certificat Pet's Meet (PM) is working.

You can also go to [http://localhost:8080](http://localhost:8080) to consult nginx server.

If you want to stops containers created by up you can use :

```docker-compose down```

## 🔰 Docker authentification with jsonwebtoken

You can go to docker directory to build image of jsonwebtoken :

```docker-compose up -d jwt```

By default, our image is called docker_jwt. Now you can run it on a container with :

```docker run --name docker_jwt -p 8081:8081 -d docker_jwt```

After doing this, you can now go to your [http://localhost:8081](http://localhost:8081) to see your server nodejs running !

To verify if the token is working you can install postman [here](https://www.postman.com/downloads/).

You can request your localhost on POST to have an token with :

```localhost:8081/login```

Here we go their is your token generated !

To get the authorization to have our data, you can request on POST:

```localhost:8081/posts```

Don't forget to add an header with key : **Authorization** and value : **Bearer yourTokenGenerated**.

You have now access to your data of token !

## ❗ Show your support

Give a ⭐ to support us :)
