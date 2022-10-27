import express from "express";
import UsuarioController from "../controllers/usuariosController.js";
import passport from "passport";

const router = express.Router();

router
    .get("/usuarios", passport.authenticate('bearer', {session: false }), UsuarioController.listarUsuarios)
    .get("/usuarios/:id", passport.authenticate('bearer', {session: false }), UsuarioController.listarUsuarioPorId)
    .post("/usuarios", UsuarioController.cadastrarUsuario)
    .put("/usuarios/:id", passport.authenticate('bearer', {session: false }), UsuarioController.atualizarUsuario)
    .put("/usuarios-comunidade/:id", passport.authenticate('bearer', {session: false }), UsuarioController.insereComunidades)
    .delete("/usuarios/:id", passport.authenticate('bearer', {session: false }), UsuarioController.excluirUsuario)
    .delete("/usuarios-comunidade/:id", passport.authenticate('bearer', {session: false }), UsuarioController.removeComunidades);

export default router;
