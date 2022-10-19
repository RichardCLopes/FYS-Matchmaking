import mongoose from "mongoose";

const matchingSchema = new mongoose.Schema(
    {
        id: { type: String },
        usuarioBase: { type: mongoose.Schema.Types.ObjectId, ref: 'usuarios' },
        usuarioChecado: { type: mongoose.Schema.Types.ObjectId, ref: 'usuarios' },
        resposta: { type: Boolean }
    },
    {
        versionKey: false
    }
);

const matching = mongoose.model("matching", matchingSchema);

export default matching;
