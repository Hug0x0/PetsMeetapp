const firebase = require("./firebase_connect");

module.exports = {
    saveData: function(req, callback){
        let name = req.name;
        firebase.database().ref("strolls/" + name).set({
            name: req.name,
            participants: req.participants,
        });
        callback(null, {"statuscode":200, "message": "Inserted successful"})
    }
}