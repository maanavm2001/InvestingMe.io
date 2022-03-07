require("dotenv").config();
const { Double } = require("mongodb");
const Cryptr = require('cryptr');
const cryptr = new Cryptr( process.env.SECRET);
const jwt = require("jsonwebtoken");
const auth = require('../middleware/auth')
var moment = require('moment');

const daysEndpoint = require("express").Router();

const User = require("../resources/user");
const Day = require("../resources/day");

const apiIDJWTResponse = require("../middleware/tokenEncryptionUtil");
let encryptedId, encryptedJWT

daysEndpoint.get('/:date/:id', auth, async (req, res) =>  {
  let reqId = req.params.id;
  let reqDate = req.params.date;
  decryptedId = cryptr.decrypt(reqId);


  await Day.find({userID: decryptedId, date: reqDate}).exec( async function(err,day){
    if(err){console.log(err)}

    var returnDay = Day;

    const userTokenParams = {
        id: decryptedId,
    };
    var encryptedContent  = await apiIDJWTResponse(userTokenParams)
    encryptedId = encryptedContent[0]
    encryptedJWT = encryptedContent[1]

    if(day.length == 0){
        var newDay = Day({
            date: reqDate,
            isActive: false,
            userID: decryptedId
        })

        await newDay.save().then(day => User.updateOne({_id:decryptedId},{$push:{'daysComplete':day._id}}));
        returnDay = newDay
          
    }
    else if(day.length ==1){
        returnDay = day[0]
    }

    returnDay = returnDay.toObject();
    delete returnDay._id
    delete returnDay.userID
    returnDay.date = moment(returnDay.date).format('YYYY-MM-DD')
    returnDay.currentDayBalance = Double(returnDay.currentDayBalance.toString());
    returnDay.currentDayInvenstment = Double(returnDay.currentDayInvenstment.toString());

    responseBody = {
        _id: encryptedId,
        jwt: encryptedJWT,
        date: JSON.stringify(returnDay)
    }
    res.status(200).json(responseBody)
  }
);
})

daysEndpoint.post('/create/', auth, async (req, res) =>  {
    let reqData = req.body;
    let reqId = reqData.id;
    let reqRange = reqData.dates;
    let invstmntAmt = reqData.investmentAmt;

    decryptedId = cryptr.decrypt(reqId);

    const userTokenParams = {
        id: decryptedId,
    };
    var encryptedContent  = await apiIDJWTResponse(userTokenParams)
    encryptedId = encryptedContent[0]
    encryptedJWT = encryptedContent[1]
    responseBody = {_id:encryptedId, jwt:encryptedJWT }

    if(typeof(reqRange) == 'string'){
        await Day.find({userID: decryptedId, date: reqRange}).exec(async function(err, day){
            if(err){res.status(500)}
            if(day.length == 0)
            {
                var newDay = Day(
                {
                    date: reqRange,
                    isActive: true,
                    currentDayInvenstment:invstmntAmt,
                    userID: decryptedId
                });
        
                await newDay.save().then(day => User.updateOne({_id:decryptedId},{$push:{'daysComplete':day._id}}));
            }
            else 
            {
                day = day[0];
                day.isActive = true;
                day.currentDayInvenstment = invstmntAmt;
                day.save();
            }
    });
    res.status(200).json(responseBody);
    }
    else
    {
        reqRange.forEach(function(date){
            Day.find({userID: decryptedId, date: date}).exec(async function(err, day) {
                if(err){res.status(500)}
                if(day.length == 0)
                {
                    var newDay = Day({
                        date: date,
                        isActive: true,
                        currentDayInvenstment: invstmntAmt,
                        userID: decryptedId
                    });
            
                    await newDay.save().then(day => User.updateOne({_id:decryptedId},{$push:{'daysComplete':day._id}}));
                }
                else 
                {
                    day = day[0];

                    day.isActive = true;
                    day.currentDayInvenstment = invstmntAmt;

                    day.save();
                }
        });
        });
        res.status(200).json(responseBody);
    }
})


module.exports = daysEndpoint;