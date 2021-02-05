const firebase = require("firebase");

const app =   firebase.initializeApp({
    apiKey: "AIzaSyAjv8kKbZQMNWYNj94GrLn-1zIoa9EK3hc",
    authDomain: "pet-s-meet.firebaseapp.com",
    databaseURL: "https://pet-s-meet.firebaseio.com/",
});

module.exports = app;