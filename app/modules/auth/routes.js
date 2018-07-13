var express = require('express');
var loginRouter = express.Router();
var logoutRouter = express.Router();
var signupRouter = express.Router();

var authMiddleware = require('./middlewares/auth');

function numberWithCommas(x) {
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}
function makeid() {
  var text = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  for (var i = 0; i < 10; i++)
    text += possible.charAt(Math.floor(Math.random() * possible.length));
  return text;
}

loginRouter.route('/')
    .get(authMiddleware.noAuthed, (req, res) => {
        res.render('auth/views/login', req.query);
    })
    .post((req, res) => {
        var db = require('../../lib/database')();

        db.query(`SELECT * FROM tbluser WHERE strEmail="${req.body.email}"`, (err, results, fields) => {
            if (err) throw err;
            if (results.length === 0) return res.redirect('/login?incorrect');

            var user = results[0];

            if (user.strPassword !== req.body.password) return res.redirect('/login?incorrect');
            if (user.strPassword !== req.body.password || user.boolStatus != 1) return res.redirect('/login?unregistered');
            

            if (user.strUserType == "admin"){
                delete user.password;
                req.session.admin = user;
                console.log(req.session)
                return res.redirect('/admin')
            }
                else if (user.strUserType == "production"){
                    delete user.password;
                    req.session.production = user;
                    console.log(req.session)
                    return res.redirect('/production')
                    }
                    else if (user.strUserType == "subcontractor"){
                        delete user.password;
                        req.session.subcontractor = user;
                        console.log(req.session)
                        return res.redirect('/subcontractor')
                        }
                        else if (user.strUserType == "user") {
                            delete user.password;
                            req.session.user = user;
                            console.log(req.session)
                            return res.redirect('/')
                            }
                

        });
    });
signupRouter.route('/')
    .get(authMiddleware.noAuthed, (req, res) => {
        res.render('auth/views/login', req.query);
    })
    .post((req, res) => {
        var db = require('../../lib/database')();
        if(req.body.password === req.body.confirm && req.body.password != ""){
            var randomId= makeid();
            UID = 'AMACOR'+('-'+randomId+'-'+'CM');
              db.query("INSERT INTO tbluser ( intUID, strName, strEmail, strAddress, intContact, strPassword, strUserType, boolStatus, strStatus) VALUES ( ?, ?, ?, ?, ?, ?, 'user', 1, 'Active') ",
                [ UID, req.body.name, req.body.email, req.body.address, req.body.number, req.body.password], (err, results, fields)=>{
                  if (err) console.log(err);
                else{
                    return res.redirect('/signup?success');
                }
                });
            }
                else{
                    return res.redirect('/signup?passwordNotMatch');
                }
        });

logoutRouter.get('/', (req, res) => {
    req.session.destroy(err => {
        if (err) throw err;
        res.redirect('/login');
    });
});

exports.login = loginRouter;
exports.logout = logoutRouter;
exports.signup = signupRouter;