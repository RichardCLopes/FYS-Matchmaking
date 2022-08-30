import express from "express";
import UsuarioController from "../controllers/usuarioController.js";

const router = express.Router();

router
  .get("/usuario", UsuarioController.listarLivros)
  .get("/usuario/:id", UsuarioController.listarLivroPorId)
  .post("/usuario", UsuarioController.cadastrarLivro)
  .put("/usuario/:id", UsuarioController.atualizarLivro)
  .delete("/usuario/:id", UsuarioController.excluirLivro);

export default router;
