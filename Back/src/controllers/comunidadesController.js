import comunidades from "../models/Comunidades.js";

class ComunidadeController {
  static listarComunidades = (req, res) => {
    comunidades
      .find()
      .populate({ path: "criador", select: "nome & foto" })
      .populate("jogo")
      .populate({
        path: "membros",
        select: "nome & foto",
        populate: { path: "jogos" },
      })
      .populate("topicos")
      .exec((err, comunidades) => {
        res.status(200).json(comunidades);
      });
  };

  static listarComunidadePorId = (req, res) => {
    const id = req.params.id;
    comunidades
      .findById(id)
      .populate({ path: "criador", select: "nome & foto" })
      .populate("jogo")
      .populate({
        path: "membros",
        select: "nome & foto",
        populate: { path: "jogos" },
      })
      .populate("topicos")
      .exec((err, comunidade) => {
        if (err) {
          res.status(400).send({
            message: `${err.message} - Id do comunidade não localizado`,
          });
        } else {
          res.status(200).send(comunidade);
        }
      });
  };

  static cadastrarComunidade = (req, res) => {
    let comunidade = new comunidades(req.body);
    comunidade.save((err) => {
      if (err) {
        res
          .status(500)
          .send({ message: `${err.message} - falha ao cadastrar comunidade` });
      } else {
        res.status(201).send(comunidade.toJSON());
      }
    });
  };

  static atualizarComunidade = (req, res) => {
    const id = req.params.id;
    comunidades.findByIdAndUpdate(id, { $set: req.body }, (err) => {
      if (!err) {
        res.status(200).send({ message: "comunidade atualizado com sucesso" });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  };

  static excluirComunidade = (req, res) => {
    const id = req.params.id;
    comunidades.findByIdAndDelete(id, (err) => {
      if (!err) {
        res.status(200).send({ message: "comunidade removido com sucesso" });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  };

  static insereMembros = (req, res) => {
    let usuario = req.body.usuario;
    let comunidade = req.params.id;
    comunidades.findById(comunidade).exec((err, comunidade) => {
      console.log(comunidade);
      if (comunidade) {
        comunidade.membros.push(usuario);
        comunidade.save();
        if (err) {
          res.status(400).send({
            message: `${err.message} - Id do comunidade não localizado`,
          });
        } else {
          res.status(200).send(comunidade);
        }
      }
    });
  };
}

export default ComunidadeController;
