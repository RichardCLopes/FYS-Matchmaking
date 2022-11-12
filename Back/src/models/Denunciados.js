import mongoose from "mongoose";

const denunciadoSchema = new mongoose.Schema(
    {
        id: { type: String },
        denunciado: { type: mongoose.Schema.Types.ObjectId, ref: 'usuarios' },
        denunciador: { type: mongoose.Schema.Types.ObjectId, ref: 'usuarios' },
        motivo: { type: String }
    },
    {
        versionKey: false
    }
);

const denunciados = mongoose.model("denunciados", denunciadoSchema);

export default denunciados;