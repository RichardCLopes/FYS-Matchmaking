import usuarios from "../models/Usuarios.js";
import jwt from "jsonwebtoken";


function criaTokenJWT(usuario) {
    const payload = {
        id: usuario._id,
        nome: usuario.nome
    }

    return jwt.sign(payload, 'senha-secreta');
}

class AuthController {

    static login = (req, res) => {
        const token = criaTokenJWT(req.user);
        res.set('Authorization', token);
        res.status(204).send();
    }
}

export default AuthController;