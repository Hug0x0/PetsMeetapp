const express = require('express')
const jwt = require('jsonwebtoken')

const app = express()

app.get("/", (req, res) => res.send("Serve nodejs"))

app.post("/posts", verifyToken, (req, res) => {
    jwt.verify(req.token, "secretkey", (err, authData) => {
        if(err){
            res.sendStatus(403);
        } else {
            res.json({
                message: "Posts created :D",
                authData,
            });
        }
    });
});

app.post("/login", (req, res) => {
    const user = {
        uid: 1,
        username: "Mica",
        email: "lemail@gmail.com",
    }
    jwt.sign({user: user}, "secretkey", (err, token) => {
        res.json({
            token,
        });
    });
});

function verifyToken(req, res, next) {
    const bearerHeader = req.headers['authorization']
    if(typeof bearerHeader !== 'undefined'){
        const bearerToken = bearerHeader.split(' ')[1]
        req.token = bearerToken
        next()
    } else{
        res.sendStatus(403);
    }
}

app.listen(8081, () => console.log("Server ready"))

