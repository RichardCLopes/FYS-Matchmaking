import mongoose from "mongoose";

const repetidosSchema = new mongoose.Schema(
    {
        id: { type: String },
        usuarioBase: { type: mongoose.Schema.Types.ObjectId, ref: 'usuarios' },
        usuarioChecado: [{ type: mongoose.Schema.Types.ObjectId, ref: 'usuarios' }]
    },
    {
        versionKey: false
    }
);

const repetidos = mongoose.model("repetidos", repetidosSchema);

export default repetidos;
