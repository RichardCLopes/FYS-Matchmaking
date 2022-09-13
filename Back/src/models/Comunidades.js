import mongoose from "mongoose";

const comunidadeSchema = new mongoose.Schema(
    {
        id: { type: String },
        nome: { type: String, required: true },
        criador: { type: mongoose.Schema.Types.ObjectId, ref: 'usuarios' },
        jogo: { type: mongoose.Schema.Types.ObjectId, ref: 'jogos' },
        foto: { type: String },
        membros: [{ type: mongoose.Schema.Types.ObjectId, ref: 'usuarios' }],
        topicos: [{ type: mongoose.Schema.Types.ObjectId, ref: 'topicos' }]
    },
    {
        versionKey: false
    }
);

const comunidades = mongoose.model("comunidades", comunidadeSchema);

export default comunidades;
