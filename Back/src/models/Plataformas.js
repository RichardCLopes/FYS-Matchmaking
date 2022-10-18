import mongoose from "mongoose";

const plataformaSchema = new mongoose.Schema(
  {
    id: { type: String },
    nome: { type: String, required: true, unique: true },
    foto: { type: String }
  },
  {
    versionKey: false,
  }
);

const plataformas = mongoose.model("plataformas", plataformaSchema);

export default plataformas;
