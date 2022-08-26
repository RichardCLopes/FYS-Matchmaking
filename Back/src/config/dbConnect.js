import mongoose from "mongoose"

mongoose.connect("mongodb+srv://admin:admin@projetos.u36cb2d.mongodb.net/projetob");

let db = mongoose.connection;

export default db;