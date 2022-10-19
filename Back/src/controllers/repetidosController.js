import repetidos from "../models/Repetidos.js";

class RepetidoController {
  static listarRepetidos = (req, res) => {
    repetidos
      .find()
      .exec((err, repetidos) => {
        res.status(200).json(repetidos);
      });
  };

  static listarRepetidoPorId = (req, res) => {
    const id = req.params.id;
    repetidos
      .findById(id)
      .exec((err, repetido) => {
        if (err) {
          res
            .status(400)
            .send({ message: `${err.message} - Id do repetido não localizado` });
        } else {
          res.status(200).send(repetido);
        }
      });
  };

  static cadastrarRepetido = (req, res) => {
    let repetido = new repetidos(req.body);
    repetido.save((err) => {
      if (err) {
        res
          .status(500)
          .send({ message: `${err.message} - falha ao cadastrar repetido` });
      } else {
        res.status(201).send(repetido.toJSON());
      }
    });
  };

  static insereRepetido = (usuarioBase, usuarioChecado, res) => {
    repetidos.updateOne( 
      { usuarioBase: usuarioBase },
      { $addToSet: { usuarioChecado: usuarioChecado } },
      { upsert: true },
      (err) => {
        if (err) {
          res.status(500).send({ message: `${err.message} - falha ao inserir repetido` });
        }
    });
  };

}

export default RepetidoController;
