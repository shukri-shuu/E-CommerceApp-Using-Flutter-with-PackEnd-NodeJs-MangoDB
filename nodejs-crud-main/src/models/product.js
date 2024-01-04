const mongoose=require("mongoose");

const ProductSchema =new mongoose.Schema({
    pid: {
        type: Number,
        required: true,
        unique : true
      },
      imgUrl: {
        type: String,
        required: true,
        default:"https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
      },
      title: {
        type: String,
        required: true
      },
      price: {
        type: Number,
        required: true
      },
      shortDescription: {
        type: String,
        required: true
      },
      longDescription: {
        type: String,
        required: true
      },
      review: {
        type: Number,
        required: true
      },
      rating: {
        type: Number,
        required: true
      },
},{timestamps:true});

module.exports=mongoose.model("products",ProductSchema);
