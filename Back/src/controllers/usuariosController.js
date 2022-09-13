import usuarios from "../models/Usuarios.js";

class UsuarioController {

    static listarUsuarios = (req, res) => {
        usuarios.find()
        .populate('jogos')
        .populate({ path: 'comunidades', select: 'nome & foto',  populate: { path : 'jogo' } })
        .exec((err, usuarios) => {
            res.status(200).json(usuarios)
        })
    }

    static listarUsuarioPorId = (req, res) => {
        const id  = req.params.id
        usuarios.findById(id)
        .populate('jogos')
        .populate({ path: 'comunidades', select: 'nome & foto',  populate: { path : 'jogo' } })
        .exec((err, usuario) => {
            if(err) {
                res.status(400).send({message: `${err.message} - Id do usuario não localizado`})
            } else {
                res.status(200).send(usuario);
            }
        })
    }

    static cadastrarUsuario = (req, res) => {
        let usuario = new usuarios(req.body);
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
        usuarios.findByIdAndUpdate(id, {$set: req.body}, (err) => {
            if(!err) {
                res.status(200).send({message: 'Usuario atualizado com sucesso'})
            } else {
                res.status(500).send({message: err.message})
            }
        })
    }

    static excluirUsuario = (req, res) => {
        const id  = req.params.id
        usuarios.findByIdAndDelete(id, (err) => {
            if(!err) {
                res.status(200).send({message: 'Usuario removido com sucesso' })
            } else {
                res.status(500).send({message: err.message});
            }
        })
    }
}

export default UsuarioController;