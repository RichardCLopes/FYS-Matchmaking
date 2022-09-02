import express from "express";
import JogoController from "../controllers/JogosController.js";

const router = express.Router();

router
    .get("/jogos", JogoController.listarJogos)
    .get("/jogos/:id", JogoController.listarJogoPorId)
    .post("/jogos", JogoController.cadastrarJogo)
    .put("/jogos/:id", JogoController.atualizarJogo)
    .delete("/jogos/:id", JogoController.excluirJogo);

export default router;
