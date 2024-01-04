const mongoose=require("mongoose");
const validator = require('validator');

const UserSchema=new mongoose.Schema({
    name:{
        type:String, 
        required:true,
    },
    email:{
        type:String,
        required: true,
        unique: true,
        // lowwercase: true,
        validate:[validator.isEmail, "please enter a valid email"]
    },
    password:{
        type: String,
        required: true,
    }, 
    photo:{
        type:String, 
        default:"https://craftsnippets.com/articles_images/placeholder/placeholder.jpg"}
},{timestamps:true});


// UserSchema.pre("save", async function(next){

// })
module.exports=mongoose.model("users",UserSchema);