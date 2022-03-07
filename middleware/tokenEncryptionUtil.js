require("dotenv").config();
const jwt = require("jsonwebtoken");
const Cryptr = require('cryptr');
const cryptr = new Cryptr( process.env.SECRET);
const User = require("../resources/user");

async function apiIDJWTResponse  (params)  {

    const token = jwt.sign(params, process.env.SECRET,{
        expiresIn: process.env.JWT_EXP,
    });
    const encryptedId = cryptr.encrypt(params.id)
    const encryptedJWT = cryptr.encrypt(token)
    await User.findOneAndUpdate({_id: params.id},{token:token});
    return [encryptedId ,encryptedJWT]
}

module.exports = apiIDJWTResponse;