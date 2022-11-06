import { createServer } from 'http';
import app from "./src/app.js";
import { Server } from 'socket.io';
const port = process.env.PORT || 3000;
var server = createServer(app);
var io = new Server(server);

//middlewre
var clients = {};


io.on("connection", (socket) => {
    console.log("connetetd");
    console.log(socket.id, "has joined");
    socket.on("signin", (id) => {
      console.log(id);
      clients[id] = socket;
      console.log(clients);
    });
    socket.on("message", (msg) => {
      console.log(msg);
      let targetId = msg.targetId;
      if (clients[targetId]) clients[targetId].emit("message", msg);
    });
  });

app.listen(port, "0.0.0.0", () => {
    console.log(`Servidor escutando em http://localhost:${port}`)
})
