require("dotenv").config();
const Cryptr = require('cryptr');
const cryptr = new Cryptr( process.env.SECRET);
const jwt = require("jsonwebtoken");
const auth = require('../middleware/auth')
var moment = require('moment');

const usersEndpoint = require("express").Router();

const User = require("../resources/user");

const apiIDJWTResponse = require("../middleware/tokenEncryptionUtil")

let encryptedId, encryptedJWT

usersEndpoint.get('/create/', async (req, res) =>  {
    let reqData = req.body;
    let firstName = reqData.firstName;
    let lastName = reqData.lastName;
    let email = reqData.email;

  
    User.find({email:email}).exec( async function(err,results){
      if (err) 
      {

        console.log('err or user exists');
        res.status(500)
      }
      else if(results.length == 0)
      {
        var date = new Date();
        date.setDate(date.getDate() - 7);
        newUser = new User(
          {
            firstName: firstName,
            lastName: lastName,
            email: email,
            signUpDate: date
          }
        );

        await newUser.save().then(console.log('User account created'));

        const userTokenParams = {
          email: newUser.email,
          id: newUser._id,
        };
        var encryptedContent  = await apiIDJWTResponse(userTokenParams)
        encryptedId = encryptedContent[0]
        encryptedJWT = encryptedContent[1]
        responseBody = {_id:encryptedId, jwt:encryptedJWT }

        res.status(201).json(responseBody);
      } 
      else if (results.length > 0)
      {
        res.status(200).json({userExists: true});
      };
    });
})

usersEndpoint.post('/create/', async (req, res) =>  
{
  let reqData = req.body;
  let firstName = reqData.firstName;
  let lastName = reqData.lastName;
  let email = reqData.email;


  User.find({email:email}).exec( async function(err,results){
    if (err)
     {

      console.log('err or user exists');
      res.status(500)
    } 
     if(results.length == 0)
     {
      var date = new Date();
      date.setDate(date.getDate() - 7);
      newUser = new User(
        {
          firstName: firstName,
          lastName: lastName,
          email: email,
          signUpDate: date
        }
      );

      await newUser.save().then(console.log('User account created'));

      const userTokenParams =
      {
        email: newUser.email,
        id: newUser._id,
      };
      var encryptedContent  = await apiIDJWTResponse(userTokenParams)
      encryptedId = encryptedContent[0]
      encryptedJWT = encryptedContent[1]

      responseBody = {_id:encryptedId, jwt:encryptedJWT }

      res.status(201).json(responseBody);
    } 
    else if (results.length > 1)
    {
      console.log(results.toString)
      res.status(200).json({userExists: true});
    }
    else if (results.length ==1)
    {
      user = results[0]
      const userTokenParams = 
      {
        email: user.email,
        id: user._id,
      };
      var encryptedContent  = await apiIDJWTResponse(userTokenParams)
      encryptedId = encryptedContent[0]
      encryptedJWT = encryptedContent[1]

      responseBody = {_id:encryptedId, jwt:encryptedJWT }
      res.status(201).json(responseBody);

    };
  });
})

usersEndpoint.get('/:id', auth, async (req, res) =>  
{
  let reqId = req.params.id;

  decryptedId = cryptr.decrypt(reqId);

  User.findOne({_id:decryptedId}).select({'firstName':0,'lastName':0}).exec( async function(err,user){
    if (err) 
    {
      console.log('err or user exists');
      res.status(500); 
    };

    const userTokenParams = 
    {
      email: user.email,
      id: user._id,
    };
    var encryptedContent  = apiIDJWTResponse(userTokenParams)
    encryptedId = encryptedContent[0]
    encryptedJWT = encryptedContent[1]

    responseBody = 
    {
      _id:encryptedId, 
      jwt:encryptedJWT,
      totalInvested: user.totalInvested,
      totalMinutesSpent: user.totalMinutesSpent,
      totalMade: user.totalMade, 
      signUpDate: moment(user.signUpDate).format('YYYY-MM-DD')
    }
    res.status(200).json(responseBody);
  });
});

module.exports = usersEndpoint;