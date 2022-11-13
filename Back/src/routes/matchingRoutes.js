import express from "express";
import MatchingController from "../controllers/matchingController.js";
import passport from "passport";

const router = express.Router();

router
    .get("/matching", passport.authenticate('bearer', {session: false }), MatchingController.listarMatching)
    .get("/matching/:id", passport.authenticate('bearer', {session: false }), MatchingController.listarMatchingPorId)
    .post("/matching", passport.authenticate('bearer', {session: false }), MatchingController.cadastrarMatching)
    .post("/matching-proximo", passport.authenticate('bearer', {session: false }), MatchingController.proximoMatching)
    .delete("/matching/:id", passport.authenticate('bearer', {session: false }), MatchingController.excluirMatch);

export default router;
