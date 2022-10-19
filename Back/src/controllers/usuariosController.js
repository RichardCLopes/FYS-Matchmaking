import usuarios from "../models/Usuarios.js";
import bcrypt from "bcrypt";

class UsuarioController {
  static listarUsuarios = (req, res) => {
    usuarios
      .find({},{senha:0})
      .populate("jogos")
      .populate({
        path: "comunidades",
        select: "nome & foto",
        populate: { path: "jogo" },
      })
      .exec((err, usuarios) => {
        res.status(200).json(usuarios);
      });
  };

  static listarUsuarioPorId = (req, res) => {
    const id = req.params.id;
    console.log("listarUsuarioPorId")
    console.log("id = ", id)
    usuarios
      .findById(id, {senha:0})
      // .populate("jogos")
      // .populate({
      //   path: "comunidades",
      //   select: "nome & foto",
      //   populate: { path: "jogo" },
      // })
      .exec((err, usuario) => {
        if (err) {
          res
            .status(400)
            .send({ message: `${err.message} - Id do usuario não localizado` });
        } else {
          res.status(200).send(usuario);
        }
      });
  };

  static cadastrarUsuario = async (req, res) => {
    const custoHash = 12;
    let usuario = new usuarios(req.body);
    usuario.senha = await bcrypt.hash(req.body.senha, custoHash);
    usuario.save((err) => {
      if (err) {
        res
          .status(500)
          .send({ message: `${err.message} - falha ao cadastrar usuario` });
      } else {
        res.status(201).send(usuario.toJSON());
      }
    });
  };

  static atualizarUsuario = (req, res) => {
    const id = req.params.id;
    usuarios.findByIdAndUpdate(id, { $set: req.body }, (err) => {
      if (!err) {
        res.status(200).send({ message: "Usuario atualizado com sucesso" });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  };

  static excluirUsuario = (req, res) => {
    const id = req.params.id;
    usuarios.findByIdAndDelete(id, (err) => {
      if (!err) {
        res.status(200).send({ message: "Usuario removido com sucesso" });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  };

  static insereComunidades = (req, res) => {
    let comunidade = req.body.comunidade;
    let usuario = req.params.id;
    usuarios.findById(usuario).exec((err, usuario) => {
      console.log(comunidade);
      if (usuario) {
        usuario.comunidades.push(comunidade);
        usuario.save();
        if (err) {
          res.status(400).send({
            message: `${err.message} - Id do usuario não localizado`,
          });
        } else {
          res.status(200).send(usuario);
        }
      }
    });
  };

  static insereMatches = (usuarioId, usuarioMatch, res) => {
    usuarios.findByIdAndUpdate( 
      usuarioId,
      { $addToSet: { matches: usuarioMatch } },
      { upsert: true },
      (err) => {
        if (err) {
          res.status(500).send({ message: `${err.message} - falha ao inserir repetido` });
        }
    });
  }
}

export default UsuarioController;
