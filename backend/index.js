const express = require("express");
const http = require("http");
const cors = require("cors");
const mongoose = require('./models/connection'); // Import Mongoose connection
const Message = require('./models/messageSchema'); // Import the message schema

const app = express();
const port = process.env.PORT || 5000;
const server = http.createServer(app);
const io = require('socket.io')(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});

// Middlewares
app.use(express.json());
app.use(cors());

app.get('/messages/:sourceId/:targetId', async (req, res) => {
  const { sourceId, targetId } = req.params;

  try {
    const messages = await Message.find({
      $or: [
        { sourceId: sourceId, targetId: targetId },
        { sourceId: targetId, targetId: sourceId }
      ]
    }).sort({ timestamp: 1 }); // Sort messages by timestamp

    res.json(messages);
  } catch (error) {
    console.error('Error fetching messages:', error);
    res.status(500).send('Server error');
  }
});

const clients = {};

io.on("connection", (socket) => {
  console.log(`Client connected: ${socket.id}`);

  socket.on("signin", async (id) => {
    console.log(`User signed in with id: ${id}`);
    clients[id] = socket;
    console.log(clients);

    try {
      const messages = await Message.find({
        $or: [
          { sourceId: id },
          { targetId: id }
        ]
      }).sort({ timestamp: 1 });

      // Emit all messages to the client
      socket.emit('loadMessages', messages);
    } catch (error) {
      console.error('Error fetching messages:', error);
    }
  });

  socket.on("message", async (msg) => {
    console.log(msg);
    let targetId = msg.targetId;

    // Save the message to MongoDB
    const newMessage = new Message({
      message: msg.message,
      sourceId: msg.sourceId,
      targetId: msg.targetId,
      timestamp: new Date() // Ensure timestamp is included
    });

    try {
      await newMessage.save(); // Save message to the database
      console.log('Message saved successfully.');
    } catch (error) {
      console.error('Error saving message:', error);
    }

    // Emit the message to the intended recipient
    if (clients[targetId]) {
      clients[targetId].emit("message", msg);
    } else {
      socket.emit("message", msg);
    }
  });

  socket.on('disconnect', () => {
    console.log(`Client disconnected: ${socket.id}`);
    for (let id in clients) {
      if (clients[id].id === socket.id) {
        delete clients[id];
        break;
      }
    }
    console.log(clients);
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log("Server started on port " + port);
});
