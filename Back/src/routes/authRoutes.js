import express from "express";
import AuthController from "../controllers/authController.js";
import passport from "passport";

const router = express.Router();

router
    .post("/login", passport.authenticate('local', { session: false }), AuthController.login)

export default router;