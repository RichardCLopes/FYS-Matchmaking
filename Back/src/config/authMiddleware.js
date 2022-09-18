import passport from "passport";
import { Strategy as LocalStrategy } from "passport-local";
import { Strategy as BearerStrategy } from "passport-http-bearer";
import usuarios from "../models/Usuarios.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

passport.use(
    new LocalStrategy(
        {
            usernameField: 'email',
            passwordField: 'senha',
            session: false
        },
        async (email, senha, done) => {
            usuarios.findOne({ email: email }, async function (err, usuario) {
                if (err) { 
                    return done(err); 
                }
                if (!usuario) { 
                    return done(null, false); 
                }
                if (!await bcrypt.compare(senha, usuario.senha)) { 
                    return done(null, false); 
                }
                return done(null, usuario);
            });
            
        }
    )
);

passport.use(
    new BearerStrategy(
        (token, done) => {
            const payload = jwt.verify(token, 'senha-secreta');
            usuarios.findOne({ id: payload._id }, function (err, usuario) {
                if (err) { return done(err); }
                if (!usuario) { return done(null, false); }
                return done(null, usuario, { scope: 'all' });
            }); 
        }
    )
)

export default passport;