import express from "express";
import PlataformaController from "../controllers/plataformasController.js";
import passport from "passport";

const router = express.Router();

router
  .get("/plataformas", passport.authenticate("bearer", { session: false }), PlataformaController.listarPlataformas)
  .get(
    "/plataformas/:id",
    passport.authenticate("bearer", { session: false }),
    PlataformaController.listarPlataformasPorId
  )
  .post(
    "/plataformas",
    passport.authenticate("bearer", { session: false }),
    PlataformaController.cadastrarPlataforma
  )
  .put(
    "/plataformas/:id",
    passport.authenticate("bearer", { session: false }),
    PlataformaController.atualizarPlataforma
  )
  .delete(
    "/plataformas/:id",
    passport.authenticate("bearer", { session: false }),
    PlataformaController.excluirPlataforma
  );

export default router;
