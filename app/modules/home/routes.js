var express = require('express');
var validator = require('express-validator');
var logoutRouter = express.Router();
// var swal = require('sweetalert');
var router = express.Router();
var authMiddleware = require('../auth/middlewares/auth');
router.use(authMiddleware.hasAuth);

var indexController = require('./controllers/index');
router.get('/', displayInfo, indexController);


function index(req,res){
  res.render('home/views/clindex' , {information: req.displayInfoCus});
}
function newDesign(req , res){
  res.render('home/views/new_design');
  swal()
}
function pending(req , res){
  res.render('home/views/pending');
}
function payables(req , res){
  res.render('home/views/payables');
}
function transHist(req , res){
  res.render('home/views/transactions_history');
}

function returns(req , res){
  res.render('home/views/returns');
}

//dashboard
function displayInfo(req, res, next){
  var db = require('../../lib/database')();
  db.query('SELECT * FROM tbluser WHERE tbluser.strUserType = "user" AND intUId = ? ', [req.session.user.intUId] , function (err, results, fields) {
      if (err) return res.send(err);
      console.log(req.session.user.intUId)
      req.displayInfoCus = results;
      return next();
  });
}
//Edit INFO
router.post('/', (req, res) => {
  var db = require('../../lib/database')();{
    db.query("UPDATE tbluser SET strName = ?, strEmail = ?, strAddress = ?, intContact = ? WHERE intUId = ?",
      [req.body.name, req.body.email, req.body.add, req.body.no, req.body.id], (err, results, fields)=>{
      if (err)
        console.log(err);
      else{
        return res.redirect('/');
      }
      });
    }
});
//edit Password
router.post('/changePassword',(req, res) => {
    var db = require('../../lib/database')();
    if( req.body.new === req.body.confirm ){
      if(req.body.old === req.session.user.strPassword){
        db.query("UPDATE tbluser SET strPassword= ? WHERE intUId = ? ",[req.body.new, req.body.id], (err, results, fields) => {
            if (err) console.log(err);
            res.redirect('/?success');
        });
      }
      else
        return  res.redirect('/?passwordIncorrect');
    }
    else
      return res.redirect('/?passwordNotMatched');
  });

router.get('/', displayInfo, index  );
router.get('/createDesign', newDesign );
router.get('/pendingOrders', pending );
router.get('/payables', payables );
router.get('/transaction_history', displayInfo, transHist );
router.get('/returns', returns );

/**
 * Here we just export said router on the 'index' property of this module.
 */

logoutRouter.get('/', (req, res) => {
  req.session.destroy(err => {
      if (err) throw err;
      res.redirect('/login');
  });
});
exports.logout = logoutRouter;
exports.index = router;