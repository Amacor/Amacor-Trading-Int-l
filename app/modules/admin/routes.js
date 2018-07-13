var swal = require('sweetalert')
var express = require('express');
var router = require('express').Router();
var logoutRouter = express.Router();
var authMiddleware = require('../auth/middlewares/auth');
router.use(authMiddleware.adminAuth);
// logoutRouter.use(authMiddleware.adminNoAuthed)

var indexController = require('./controllers/index');
router.get('/', indexController);

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

// rendering ADMIN pages

function admin(req,res , next){
  res.render('admin/views/index',
  swal({
    title: "hi",
    text: 'puasok ka'
    })
  );
}
function customers(req,res,next ) {
  res.render('admin/views/customers', {customers: req.displayCus});
}
function materials(req,res) {
  res.render('admin/views/materials', {materials: req.displayMat, same: req.displayMatSame});
}
function products(req,res) {
   res.render('admin/views/products');
}
function queries(req,res) {
  res.render('admin/views/queries');
}
function reports(req,res) {
  res.render('admin/views/reports');
}
function subcon(req,res) {
   res.render('admin/views/subcontractors', {subcontractors: req.displaySubcon});
}
function trans(req,res) {
   res.render('admin/views/transactions');
}
function util(req,res) {
  res.render('admin/views/utilities');
}

//adding subcon
router.post('/subcontractors', (req, res) =>{
    var db = require('../../lib/database')();
    var randomId= makeid();
    UID = 'AMACOR'+('-'+randomId+'-'+'SC');
      db.query("INSERT INTO tbluser ( intUID, strName, strEmail, strAddress, intContact, strPassword, strUserType, boolStatus, strStatus) VALUES ( ?, ?, ?, ?, ?, ?, 'subcontractor', 1, 'Active') ",
        [ UID, req.body.name, req.body.email, req.body.address, req.body.number, req.body.password], (err, results, fields)=>{
          if (err) console.log(err);
          console.log('nakapost na')
        res.redirect('/admin/subcontractors')
        });
});
//deleting subcon
router.post('/subcontractors/delete', (req, res) => {
    var db = require('../../lib/database')();{
      db.query("UPDATE tbluser SET boolStatus = 0, strStatus = 'Inactive' WHERE intUId = ?",[req.body.id], (err, results, fields)=>{
        if (err)
          console.log(err);
        else{
          return res.redirect('/admin/subcontractors');
        }
        });
      }
  });
//rever-delete subcon
router.post('/subcontractors/revert', (req, res) => {
    var db = require('../../lib/database')();{
      db.query("UPDATE tbluser SET boolStatus = 1, strStatus = 'Active' WHERE intUId = ?",[req.body.id], (err, results, fields)=>{
        if (err)
          console.log(err);
        else{
          return res.redirect('/admin/subcontractors');
        }
        });
      }
  });
//display subcon
function displaySubcon(req, res, next){
    var db = require('../../lib/database')();
    db.query('SELECT * FROM tbluser WHERE tbluser.strUserType = "subcontractor"', function (err, results, fields) {
        if (err) return res.send(err);
        console.log(results)
        req.displaySubcon = results;
        return next();
    });
}

//adding material
router.post('/materials', (req, res) =>{
    var db = require('../../lib/database')();
      db.query("INSERT INTO tbladdmaterials (strMatName, strUOM, intQuantity, strColor) VALUES ( ?, ?, ?, ?) ",
        [req.body.name, req.body.uom, req.body.qty, req.body.color], (err, results, fields)=>{
          if (err) console.log(err);
          console.log('nakapost na')
        res.redirect('/admin/materials')
        });
});
//edit Material
router.post('/materials/edit', (req, res) => {
    var db = require('../../lib/database')();{
      db.query("UPDATE tbladdmaterials SET strMatName = ?, strUOM = ?, intQuantity = ?, strColor = ? WHERE intNewMatID = ?",[req.body.name, req.body.uom, req.body.qty, req.body.color, req.body.id], (err, results, fields)=>{
        if (err)
          console.log(err);
        else{
          return res.redirect('/admin/materials');
        }
        });
      }
  });
//display Materials
function displaySame(req, res, next){
    var db = require('../../lib/database')();
    db.query('SELECT strMatName FROM tbladdmaterials GROUP BY strMatName', function (err, results, fields) {
        if (err) return res.send(err);
        console.log(results)
        req.displayMatSame = results;
        return next();
    });
}
function displayMat(req, res, next){
    var db = require('../../lib/database')();
    db.query('SELECT * FROM tbladdmaterials', function (err, results, fields) {
        if (err) return res.send(err);
        console.log(results)
        req.displayMat = results;
        return next();
    });
}
//displaying Custotmer
function displayCustomer(req, res, next){
    var db = require('../../lib/database')();
    db.query('SELECT * FROM tbluser WHERE tbluser.strUserType = "user"', function (err, results, fields) {
        if (err) return res.send(err);
        console.log(results)
        req.displayCus = results;
        return next();
    });
}
//deleting customer
router.post('/customers/delete', (req, res) => {
    var db = require('../../lib/database')();{
      db.query("UPDATE tbluser SET boolStatus = 0, strStatus = 'Inactive' WHERE intUId = ?",[req.body.id], (err, results, fields)=>{
        if (err)
          console.log(err);
        else{
          return res.redirect('/admin/customers');
        }
        });
      }
  });
//rever-delete customer
router.post('/customers/revert', (req, res) => {
    var db = require('../../lib/database')();{
      db.query("UPDATE tbluser SET boolStatus = 1, strStatus = 'Active' WHERE intUId = ?",[req.body.id], (err, results, fields)=>{
        if (err)
          console.log(err);
        else{
          return res.redirect('/admin/customers');
        }
        });
      }
  });

router.post('/customers/add', (req, res) => {
    var db = require('../../lib/database')();
    if(req.body.password === req.body.confirm && req.body.password != ""){
        var randomId= makeid();
        UID = 'AMACOR'+('-'+randomId+'-'+'CM');
          db.query("INSERT INTO tbluser ( intUID, strName, strEmail, strAddress, intContact, strPassword, strUserType, boolStatus, strStatus) VALUES ( ?, ?, ?, ?, ?, ?, 'user', 1, 'Active') ",
            [ UID, req.body.name, req.body.email, req.body.address, req.body.number, req.body.password], (err, results, fields)=>{
              if (err) console.log(err);
            else{
                return res.redirect('/admin/customers');
            }
            });
        }
            else{
                return res.redirect('/signup?passwordNotMatch');
            }
    });
router.get('/', admin );
router.get('/customers', displayCustomer, customers );
router.get('/customers/add', displayCustomer, customers );
router.get('/customers/delete' , displayCustomer, customers);
router.get('/customers/revert' , displayCustomer, customers);

router.get('/materials', displaySame, displayMat, materials );
router.get('/materials/edit', displaySame, displayMat, materials );


router.get('/products', products );

router.get('/queries', queries );

router.get('/reports', reports );

router.get('/subcontractors', displaySubcon, subcon );
router.get('/subcontractors/delete' , displaySubcon, subcon );
router.get('/subcontractors/revert' , displaySubcon, subcon );

router.get('/transactions', trans );

router.get('/utilities', util );


//


logoutRouter.get('/', (req, res) => {
    req.session.destroy(err => {
        if (err) throw err;
        res.redirect('/login');
    });
  });

exports.admin = router;
exports.logout = logoutRouter;