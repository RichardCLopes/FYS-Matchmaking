import express from "express";
import RepetidoController from "../controllers/repetidosController.js";
import passport from "passport";

const router = express.Router();

router
    .get("/repetidos", passport.authenticate('bearer', {session: false }), RepetidoController.listarRepetidos)
    .get("/repetidos/:id", passport.authenticate('bearer', {session: false }), RepetidoController.listarRepetidoPorId)
    .post("/repetidos", passport.authenticate('bearer', {session: false }), RepetidoController.cadastrarRepetido);

export default router;
