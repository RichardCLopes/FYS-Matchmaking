import express from "express";
import ComunidadeController from "../controllers/comunidadesController.js";

const router = express.Router();

router
    .get("/comunidades", ComunidadeController.listarComunidades)
    .get("/comunidades/:id", ComunidadeController.listarComunidadePorId)
    .post("/comunidades", ComunidadeController.cadastrarComunidade)
    .put("/comunidades/:id", ComunidadeController.atualizarComunidade)
    .delete("/comunidades/:id", ComunidadeController.excluirComunidade);

export default router;
