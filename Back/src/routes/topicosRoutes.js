import express from "express";
import TopicoController from "../controllers/topicosController.js";

const router = express.Router();

router
    .get("/topicos", TopicoController.listarTopicos)
    .get("/topicos/:id", TopicoController.listarTopicoPorId)
    .post("/topicos", TopicoController.cadastrarTopico)
    .put("/topicos/:id", TopicoController.atualizarTopico)
    .delete("/topicos/:id", TopicoController.excluirTopico);

export default router;
