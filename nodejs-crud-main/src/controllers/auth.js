const User = require("../models/users");
const bcrypt = require('bcrypt');
// const jwt = require('jsonwebtoken');
module.exports = {
register : async (req , res) =>{
    const { name, email,password} = req.body;
 try {
    // Check if the user already exists
    const existingUser = await User.findOne({email});
    if (existingUser) {
      return res.status(409).json({ message: 'User already exists' });
    }
    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);
    // Create a new user
    const newUser = new User({name, email, password: hashedPassword });
    const data =  await newUser.save();
    res.status(200).json({status: true, data: data, message: "USER CREATED SUCCESSFULLY ✅" },);
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
}, 
login: async (req, res) => {
  const { email, password } = req.body;
  try {
    // Check if the user exists
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    // Validate the password
    if (!password) {
      return res.status(400).json({ message: 'Password is required' });
    }
    if (!user.password) {
      return res.status(500).json({message: 'User password is missing' });
    }
    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      return res.status(401).json({ message: 'Invalid password' });
    }
    // Password is valid, return success message
    return res.status(200).json({ message: 'Login successful' });
  } catch (error) {
    console.error('Login error:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
}
}