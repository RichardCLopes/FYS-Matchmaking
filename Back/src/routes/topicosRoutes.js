import express from "express";
import TopicoController from "../controllers/topicosController.js";
import passport from "passport";

const router = express.Router();

router
    .get("/topicos", passport.authenticate('bearer', {session: false }), TopicoController.listarTopicos)
    .get("/topicos/:id", passport.authenticate('bearer', {session: false }), TopicoController.listarTopicoPorId)
    .post("/topicos", passport.authenticate('bearer', {session: false }), TopicoController.cadastrarTopico)
    .put("/topicos/:id", passport.authenticate('bearer', {session: false }), TopicoController.atualizarTopico)
    .delete("/topicos/:id", passport.authenticate('bearer', {session: false }), TopicoController.excluirTopico);

export default router;
