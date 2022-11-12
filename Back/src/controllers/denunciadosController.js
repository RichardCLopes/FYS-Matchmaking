import denunciados from "../models/Denunciados.js";

class DenunciadoController {
  static listarDenunciados = (req, res) => {
    denunciados.find()
    .populate({ path: "denunciado", select: "nome" })
    .populate({ path: "denunciador", select: "nome" })
    .exec((err, denunciados) => {
      res.status(200).json(denunciados);
    });
  };

  static listarDenunciadoPorId = (req, res) => {
    const id = req.params.id;
    denunciados.findById(id)
    .populate({ path: "denunciado", select: "nome" })
    .populate({ path: "denunciador", select: "nome" })
    .exec((err, Denunciado) => {
      if (err) {
        res
          .status(400)
          .send({ message: `${err.message} - Id do Denunciado não localizado` });
      } else {
        res.status(200).send(Denunciado);
      }
    });
  };

  static cadastrarDenunciado = (req, res) => {
    let Denunciado = new denunciados(req.body);
    Denunciado.save((err) => {
      if (err) {
        res
          .status(500)
          .send({ message: `${err.message} - falha ao cadastrar Denunciado` });
      } else {
        res.status(201).send(Denunciado.toJSON());
      }
    });
  };

  static atualizarDenunciado = (req, res) => {
    const id = req.params.id;
    denunciados.findByIdAndUpdate(id, { $set: req.body }, (err) => {
      if (!err) {
        res.status(200).send({ message: "Denunciado atualizado com sucesso" });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  };

  static excluirDenunciado = (req, res) => {
    const id = req.params.id;
    denunciados.findByIdAndDelete(id, (err) => {
      if (!err) {
        res.status(200).send({ message: "Denunciado removido com sucesso" });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  };
}

export default DenunciadoController;