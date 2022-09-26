import express from "express";
import ComunidadeController from "../controllers/comunidadesController.js";
import passport from "passport";

const router = express.Router();

router
    .get("/comunidades", passport.authenticate('bearer', {session: false }), ComunidadeController.listarComunidades)
    .get("/comunidades/:id", passport.authenticate('bearer', {session: false }), ComunidadeController.listarComunidadePorId)
    .post("/comunidades", passport.authenticate('bearer', {session: false }), ComunidadeController.cadastrarComunidade)
    .put("/comunidades/:id", passport.authenticate('bearer', {session: false }), ComunidadeController.atualizarComunidade)
    .put("/comunidades-membros/:id", passport.authenticate('bearer', {session: false }), ComunidadeController.insereMembros)
    .delete("/comunidades/:id", passport.authenticate('bearer', {session: false }), ComunidadeController.excluirComunidade);

export default router;
