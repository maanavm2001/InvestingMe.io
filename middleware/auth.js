require("dotenv").config();
const jwt = require("jsonwebtoken");
const Cryptr = require('cryptr');
const cryptr = new Cryptr( process.env.SECRET);

const verifyToken = (req, res, next) => {
  const token =
    req.body.token || req.query.token || req.headers["x-access-token"];
  if (!token) {
    return res.status(403).send("A token is required for authentication");
  }
  try {
    const decryptedToken = cryptr.decrypt(token)
    const decoded = jwt.verify(decryptedToken, process.env.SECRET);
    req.user = decoded;
  } catch (err) {
      
    return res.status(401).send("Invalid Token");
  }
  return next();
};

module.exports = verifyToken;