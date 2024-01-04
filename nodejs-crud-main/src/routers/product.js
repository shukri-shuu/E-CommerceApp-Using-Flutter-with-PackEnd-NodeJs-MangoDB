const express=require("express");
const {getProducts, getProduct, createProduct, updateProduct, deleteProduct } = require("../controllers/product");
const router=express.Router();

router.get("/products/",getProducts);
router.get("/product:id",getProduct),
router.post("/product/create",createProduct),
router.patch("/product:id",updateProduct),
router.delete("/product:id",deleteProduct)

module.exports=router;