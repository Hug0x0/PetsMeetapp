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

```
https://github.com/Hugooboutot/PetsMeetapp.git
```

### Step 3:

Go to project root and execute the following command in console to get required dependencies:

```
flutter pub get
```

### Step 4:

Run the project

```
flutter run
```

## 🔨 Installation of docker

First instal docker to use our services that use docker.

[Click here to install docker desktop](https://docs.docker.com/desktop/)

## 🔐 Docker https certificat installation

You have the directory **certs** who contains our key and certificat.

The directory **docker/web** is the part of docker to have an https in our localhost.

Now, you can build the container docker for our service.

Unless they are already running, this command also starts any linked services.

Go to **/docker** directory :

```
docker-compose up
```

After doing this, the server is now ready you can now go on your [https://localhost](https://localhost) and the certificat Pet's Meet (PM) is working.

## 🔰 Docker authentification with jsonwebtoken

For this part, you can consult **docker/jwt**. We also have firebase connect to our serveur nodejs to add some stroll.

If you want to check, you can go to your [https://localhost](https://localhost) to see your server nodejs running !

### 💻 Postman

To verify if the token is working you can install postman [here](https://www.postman.com/downloads/).

You can request your localhost on POST to have an token with :

```
https://localhost/login
```

Here we go their is your token generated !

To get the authorization to have our data, you can request on POST:

```
https://localhost/posts
```

Don't forget to add an header with key : **Authorization** and value : **Bearer yourTokenGenerated**.

You have now access to your data of token ! 

You can use the call **/stroll/** on POST to create a stroll on our realtime database (Flutter).

```
https://localhost/stroll/
```

On postman you have to setup a request json. Go to **Body**, select **raw**, and on **Text** you can choose **Json** and enter this request :

```
{
    "name": "NameOfStroll",
    "participants": "numberOfParticipants"
}
```

If you got inserted successful, you can consult your stroll created by yourself ! Visit [Pet's meet database](https://pet-s-meet.firebaseio.com/strolls.json)

## ❗ Show your support

Give a ⭐ to support us :)
