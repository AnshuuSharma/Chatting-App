const mongoose = require('mongoose');

const mongoURI = 'mongodb+srv://dbuser:dbUserPw@cluster0.xxkl3yq.mongodb.net/chatapp?retryWrites=true&w=majority&appName=Cluster0';

mongoose.connect(mongoURI)
  .then(() => console.log('MongoDB connected...'))
  .catch(err => console.log(`Could not connect to MongoDB: ${err}`));

module.exports = mongoose;
