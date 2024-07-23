const mongoose =require('mongoose');
const schema=mongoose.Schema;

const messageSchema=new schema({
    message:{
        type:String,
        required:true
    },
    sourceId:{
        type:Number,
        required:true
    },
    targetId:{
        type:Number,
        required:true
    },
    timestamp:{
        type:Date,
        default:Date.now
    }
});

module.exports=mongoose.model('message',messageSchema);