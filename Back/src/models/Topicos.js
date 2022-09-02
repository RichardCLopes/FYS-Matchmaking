import mongoose from "mongoose";

const topicoSchema = new mongoose.Schema(
    {
        id: { type: String },
        nome: { type: String, required: true }
    },
    {
        versionKey: false
    }
);

const topicos = mongoose.model("topicos", topicoSchema);

export default topicos;
