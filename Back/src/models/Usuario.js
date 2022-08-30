import mongoose from "mongoose";

const usuarioSchema = new mongoose.Schema({
  id: { type: String },
  email: { type: String, required: true },
  senha: { type: String, required: true },
  dataNascimento: { type: Date, required: true },
});

const livros = mongoose.model("livros", livroSchema);

export default usuario;
