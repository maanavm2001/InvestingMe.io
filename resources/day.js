const { Decimal128 } = require("mongodb");
const { default: mongoose } = require("mongoose");

daySchema = new mongoose.Schema({
    
    isActive: {type: Boolean, required: true},
    date: {type: Date, required: true},
    userID: {type: mongoose.SchemaTypes.ObjectId, required: true},

    currentDayBalance: {type: Decimal128, default: 0.0},
    currentDayInvenstment: {type: Decimal128, default: 0.0},
    minutesSpent: {type: Number, default: 0.0},
    meditationFive : {type:Boolean, default: false},
    meditationTen : {type:Boolean, default: false},
    readingFive : {type:Boolean, default: false},
    readingTen : {type:Boolean, default: false}
    
});

module.exports = mongoose.model('Day', daySchema);
