import express from "express";
import JogoController from "../controllers/jogosController.js";
import passport from "passport";

const router = express.Router();

router
    .get("/jogos", passport.authenticate('bearer', {session: false }), JogoController.listarJogos)
    .get("/jogos/:id", passport.authenticate('bearer', {session: false }), JogoController.listarJogoPorId)
    .post("/jogos", passport.authenticate('bearer', {session: false }), JogoController.cadastrarJogo)
    .put("/jogos/:id", passport.authenticate('bearer', {session: false }), JogoController.atualizarJogo)
    .delete("/jogos/:id", passport.authenticate('bearer', {session: false }), JogoController.excluirJogo);

export default router;
