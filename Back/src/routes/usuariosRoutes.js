import express from "express";
import UsuarioController from "../controllers/usuariosController.js";
import passport from "passport";

const router = express.Router();

router
    .get("/usuarios", passport.authenticate('bearer', {session: false }), UsuarioController.listarUsuarios)
    .get("/usuarios/:id", passport.authenticate('bearer', {session: false }), UsuarioController.listarUsuarioPorId)
    .post("/usuarios", passport.authenticate('bearer', {session: false }), UsuarioController.cadastrarUsuario)
    .put("/usuarios/:id", passport.authenticate('bearer', {session: false }), UsuarioController.atualizarUsuario)
    .delete("/usuarios/:id", passport.authenticate('bearer', {session: false }), UsuarioController.excluirUsuario);

export default router;
