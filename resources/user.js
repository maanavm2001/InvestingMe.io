const { Decimal128 } = require('mongodb');
const mongoose = require('mongoose');

const Schema = mongoose.Schema, objectId = Schema.ObjectId;

userSchema = new Schema({

    firstName: {type: String, required: true},
    lastName: {type: String, required: true},
    email: {type: String, required: true},

    token :  String,

    totalInvested: Decimal128,
    totalMinutesSpent: Number,
    totalMade: Number,

    signUpDate: Date,
    daysComplete: [{type: mongoose.Schema.Types.ObjectId, ref: 'Day'}]

});

module.exports = mongoose.model('User', userSchema);