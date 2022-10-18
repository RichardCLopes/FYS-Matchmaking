import plataformas from "../models/Plataformas.js";

class PlataformaController {
  static listarPlataformas = (req, res) => {
    plataformas.find((err, plataformas) => {
      res.status(200).json(plataformas);
    });
  };

  static listarPlataformasPorId = (req, res) => {
    const id = req.params.id;
    plataformas.findById(id, (err, plataforma) => {
      if (err) {
        res.status(400).send({
          message: `${err.message} - Id da plataforma não localizado`,
        });
      } else {
        res.status(200).send(plataforma);
      }
    });
  };

  static cadastrarPlataforma = (req, res) => {
    console.log("aqui");
    let plataforma = new plataformas(req.body);
    plataforma.save((err) => {
      if (err) {
        res
          .status(500)
          .send({ message: `${err.message} - falha ao cadastrar plataforma` });
      } else {
        res.status(201).send(plataforma.toJSON());
      }
    });
  };

  static atualizarPlataforma = (req, res) => {
    const id = req.params.id;
    plataformas.findByIdAndUpdate(id, { $set: req.body }, (err) => {
      if (!err) {
        res.status(200).send({ message: "plataforma atualizada com sucesso" });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  };

  static excluirPlataforma = (req, res) => {
    const id = req.params.id;
    plataformas.findByIdAndDelete(id, (err) => {
      if (!err) {
        res.status(200).send({ message: "plataforma removida com sucesso" });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  };
}

export default PlataformaController;
