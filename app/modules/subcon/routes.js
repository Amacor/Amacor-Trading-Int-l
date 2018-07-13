var express = require('express');
var validator = require('express-validator');
var logoutRouter = express.Router();

var router = express.Router();
var authMiddleware = require('../auth/middlewares/auth');
var indexController = require('./controllers/index');
router.get('/subcontractors', indexController);

router.use(authMiddleware.subConAuth);


// rendering subcon pages

function index(req,res){
    res.render('subcon/views/index', {information: req.displayInfoSub});
}
function deliverables(req,res, next) {
    res.render('subcon/views/deliverables');
}
function monitoringSheet(req,res, next) {
    res.render('subcon/views/monitoring-sheet');
}
function receivables(req,res, next) {
    res.render('subcon/views/receivables');
}
function transHist(req,res, next) {
    res.render('subcon/views/transactions_history');
}
//Subcon Info
function displayInfo(req, res, next){
    var db = require('../../lib/database')();
    db.query('SELECT * FROM tbluser WHERE tbluser.strUserType = "subcontractor" AND intUId = ? ', [req.session.subcontractor.intUId] , function (err, results, fields) {
        if (err) return res.send(err);
        console.log(req.session.subcontractor.intUId)
        req.displayInfoSub = results;
        return next();
    });
  }
//Edit INFO SubCOn
router.post('/editInfo', (req, res) => {
  var db = require('../../lib/database')();{
    db.query("UPDATE tbluser SET strName = ?, strEmail = ?, strAddress = ?, intContact = ? WHERE intUId = ?",
      [req.body.name, req.body.email, req.body.add, req.body.no, req.body.id], (err, results, fields)=>{
      if (err)
        console.log(err);
      else{
        return res.redirect('/subcontractor/editInfo?success');
      }
      });
    }
});
//edit Password
router.post('/changePassword',(req, res) => {
    var db = require('../../lib/database')();
    if( req.body.new === req.body.confirm ){
        if(req.body.old === req.session.subcontractor.strPassword){
            db.query("UPDATE tbluser SET strPassword= ? WHERE intUId = ? ",[req.body.new, req.body.id], (err, results, fields) => {
                if (err) console.log(err);
                res.redirect('/subcontractor/change?success');
            });
        }
        else
            return res.redirect('/subcontractor/change?passwordIncorrect');
        }
    else
        return res.redirect('/subcontractor/change?passwordNotMatched');
    });


router.get('/', displayInfo, index);
router.get('/change', displayInfo, index);
router.get('/editInfo', displayInfo, index);



router.get('/deliverables', deliverables);
router.get('/monitoringSheet', monitoringSheet);
router.get('/receivables', receivables);
router.get('/transactionHistory', transHist);

//


logoutRouter.get('/', (req, res) => {
    req.session.destroy(err => {
        if (err) throw err;
        res.redirect('/login');
    });
  });

exports.subcontractor = router;
exports.logout = logoutRouter;