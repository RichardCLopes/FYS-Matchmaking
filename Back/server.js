import { createServer } from "http";
import app from "./src/app.js";
import { Server } from "socket.io";
const port = process.env.PORT || 3000;
var server = createServer(app);
var io = new Server(server);

import bodyParser from "body-parser";
import * as fs from "fs";
import mime from "mime-types";

//-------------------------------
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const uploadImage = async (req, res, next) => {
  //declarar caminho para armazenar a imagem convertida
  var matches = req.body.base64image.match(/^data:([A-Za-z-+/]+);base64,(.+)$/),
    response = {};

  if (matches.length !== 3) {
    return new Error("Entrada invalida");
  }

  response.type = matches[1];
  response.data = new Buffer(matches[2], "base64");
  let decodedImg = response;
  let imageBuffer = decodedImg.data;
  let type = decodedImg.type;
  let extension = mime.extension(type);
  let fileName = "image." + extension;
  try {
    fs.writeFileSync("./images/" + fileName, imageBuffer, "utf8");
    return res.send({ status: "sucesso" });
  } catch (e) {
    next(e);
  }
};

app.post("/upload/image", uploadImage);

app.listen(port, () => console.log(`Server is listening on port ${port}`));
//--------------------------------

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
  console.log(`Servidor escutando em http://localhost:${port}`);
});
