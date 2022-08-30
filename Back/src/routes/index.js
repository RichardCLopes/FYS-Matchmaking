import  express  from "express";
import usuario from "./usuarioRoutes.js";

const routes = (app) => {
    app.route('/').get((req, res) => {
        res.status(200).send({titulo: "Curso de node"})
    })

    app.use(
        express.json(),
        usuario
    )
}

export default routes