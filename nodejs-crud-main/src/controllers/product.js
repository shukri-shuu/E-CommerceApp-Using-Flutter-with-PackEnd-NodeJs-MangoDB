const Product = require("../models/product");

module.exports = {
    createProduct: async (req, res) => {
        const {pid,imgUrl,title,price,shortDescription,longDescription,review,rating} = req.body;
        try {
            const product = Product({
                pid: pid,
                imgUrl: imgUrl,
                title: title,
                price: price,
                shortDescription : shortDescription,
                longDescription: longDescription,
                review : review,
                rating: rating,        
            });
            const data = await product.save();
            res.status(201).json({ status: true, data: data, message: "PRODUCT CREATED SUCCESSFULLY ✅" },);
        } catch (e) {
            res.status(400).json({
                status: false,
                message: e.toString()
            })
        }
    },
    getProducts: async (req, res) => {
        try {
            const users =await Product.find();
            res.status(200).json({ status: true, data: users,});
        } catch (e) {
            res.status(400).json({
                status: false,
                message: e.toString()
            })
        }
    },
    getProduct: async (req, res) => {
        try {
            const product = await Product.findById({ _id: req.params.id });
            res.status(200).json({ status: true, data: product });
        } catch (e) {
            res.status(400).json({
                status: false,
                message: e.toString()
            })
        }
    },
    deleteProduct: async (req, res) => {
        try {
            const product = await Product.findByIdAndDelete({ _id: req.params.id });
            res.status(200).json({ status: true, data:"PRODUCT DELETED SUCCESSFULLY" });
        } catch (e) {
            res.status(400).json({
                status: false,
                message: e.toString()
            })
        }
    },
    updateProduct: async (req, res) => {
        try {
            const product = await Product.findOneAndUpdate({ _id: req.params.id }, req.body, { new: true });
            res.status(200).json({ status: true, message: "PRODUCT UPDATED SUCCESSFULLY ✅", data: product },);
        } catch (e) {
            res.status(400).json({
                status: false,
                message: e.toString()
            })
        }
    }
};