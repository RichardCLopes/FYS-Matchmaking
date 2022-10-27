import comunidades from "../models/Comunidades.js";

class ComunidadeController {
  static listarComunidades = (req, res) => {
    comunidades
      .find()
      // .populate({ path: "criador", select: "nome & foto" })
      // .populate("jogo")
      // .populate({
      //   path: "membros",
      //   select: "nome & foto",
      //   populate: { path: "jogos" },
      // })
      // .populate("topicos")
      .exec((err, comunidades) => {
        res.status(200).json(comunidades);
      });
  };

  static listarComunidadePorId = (req, res) => {
    const id = req.params.id;
    comunidades
      .findById(id)
      // .populate({ path: "criador", select: "nome & foto" })
      // .populate("jogo")
      // .populate({
      //   path: "membros",
      //   select: "nome & foto",
      //   populate: { path: "jogos" },
      // })
      // .populate("topicos")
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
    console.log("Entrou insereMembros");
    let comunidadeId = req.body.comunidade;
    let usuarioId = req.params.id;
    comunidades.findById(comunidadeId).exec((err, comunidade) => {
      if (comunidade) {
        if (!comunidade.membros.includes(usuarioId)) {
          comunidade.membros.push(usuarioId);
          comunidade.save();
          console.log("inseriu Membro");
          res.status(200).send(comunidade);
        } else {
          res.status(400).send({
            message: `Usuario já incluído`,
          });
        }
      } else if (err) {
        res.status(400).send({
          message: `${err.message} - Id do comunidade não localizado`,
        });
      } else {
        res.status(400).send({
          message: `Comunidade não existe`,
        });
      }
    });
  };

  static removeMembros = (req, res) => {
    console.log("Entrou removeMembros");
    let comunidadeId = req.body.comunidade;
    let usuarioId = req.params.id;
    comunidades.findById(comunidadeId).exec((err, comunidade) => {
      if (comunidade) {
        const index = comunidade.membros.indexOf(usuarioId);
        if (index > -1) {
          comunidade.membros.splice(index, 1);
          console.log("Removeu Membro");
          comunidade.save();
          res.status(200).send(comunidade);
        } else {
          res.status(400).send({
            message: `Comunidade não possui o membro`,
          });
        }
      } else if (err) {
        res.status(400).send({
          message: `${err.message} - Id do comunidade não localizado`,
        });
      } else {
        res.status(400).send({
          message: `Comunidade não existe`,
        });
      }
    });
  };
}

export default ComunidadeController;
