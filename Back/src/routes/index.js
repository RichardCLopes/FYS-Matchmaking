import  express  from "express";
import usuarios from "./usuariosRoutes.js";
import jogos from "./jogosRoutes.js";
import topicos from "./topicosRoutes.js";
import comunidades from "./comunidadesRoutes.js";
import autenticacao from "./authRoutes.js";

const routes = (app) => {
    app.route('/').get((req, res) => {
        res.status(200).send({titulo: "Curso de node"})
    })

    app.use(
        express.json(),
        usuarios,
        jogos,
        topicos,
        comunidades,
        autenticacao
    )
}

export default routes