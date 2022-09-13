import mongoose from "mongoose";

const jogoSchema = new mongoose.Schema(
    {
        id: { type: String },
        nome: { type: String, required: true, unique: true },
        tipo: { type: String, required: true },
        foto: { type: String }
    },
    {
        versionKey: false
    }
);

const jogos = mongoose.model("jogos", jogoSchema);

export default jogos;
