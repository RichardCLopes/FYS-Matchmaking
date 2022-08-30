import usuario from "../models/Usuario.js";

class UsuarioController {

    static listarUsuario = (req, res) => {
        usuario.find((err, usuario) => {
            res.status(200).json(usuario)
        })
    }

    static listarUsuarioPorId = (req, res) => {
        const id  = req.params.id
        usuario.findById(id, (err, usuario) => {
            if(err) {
                res.status(400).send({message: `${err.message} - Id do usuario não localizado`})
            } else {
                res.status(200).send(usuario);
            }
        })
    }

    static cadastrarUsuario = (req, res) => {
        let usuario = new usuario(req.body);
        usuario.save((err) => {
            if(err) {
                res.status(500).send({message: `${err.message} - falha ao cadastrar usuario`})
            } else {
                res.status(201).send(usuario.toJSON())
            }
        })
    }

    static atualizarUsuario = (req, res) => {
        const id  = req.params.id
        usuario.findByIdAndUpdate(id, {$set: req.body}, (err) => {
            if(!err) {
                res.status(200).send({message: 'Usuario atualizado com sucesso'})
            } else {
                res.status(500).send({message: err.message})
            }
        })
    }

    static excluirUsuario = (req, res) => {
        const id  = req.params.id
        usuario.findByIdAndDelete(id, (err) => {
            if(!err) {
                res.status(200).send({message: 'Usuario removido com sucesso' })
            } else {
                res.status(500).send({message: err.message});
            }
        })
    }
}

export default UsuarioController;