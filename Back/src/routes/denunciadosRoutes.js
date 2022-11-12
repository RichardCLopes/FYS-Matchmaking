import express from "express";
import DenunciadoController from "../controllers/denunciadosController.js";
import passport from "passport";

const router = express.Router();

router
    .get("/denunciados", passport.authenticate('bearer', {session: false }), DenunciadoController.listarDenunciados)
    .get("/denunciados/:id", passport.authenticate('bearer', {session: false }), DenunciadoController.listarDenunciadoPorId)
    .post("/denunciados", DenunciadoController.cadastrarDenunciado)
    .put("/denunciados/:id", passport.authenticate('bearer', {session: false }), DenunciadoController.atualizarDenunciado)
    .delete("/denunciados/:id", passport.authenticate('bearer', {session: false }), DenunciadoController.excluirDenunciado);

export default router;
