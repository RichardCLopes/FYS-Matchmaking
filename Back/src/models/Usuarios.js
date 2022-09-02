import mongoose from "mongoose";

const usuarioSchema = new mongoose.Schema(
    {
        id: { type: String },
        nome: { type: String, required: true, unique: true },
        email: { type: String, required: true, unique: true },
        senha: { type: String, required: true },
        dataNascimento: { type: Date, required: true },
        foto: { type: String },
        jogos: [{ type: mongoose.Schema.Types.ObjectId, ref: 'jogos' }],
        comunidades: [{ type: mongoose.Schema.Types.ObjectId, ref: 'comunidades' }]
    },
    {
        versionKey: false
    }
);

const usuarios = mongoose.model("usuarios", usuarioSchema);

export default usuarios;
