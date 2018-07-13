var express = require('express');
var validator = require('express-validator');
var logoutRouter = express.Router();

var router = express.Router();
var authMiddleware = require('../auth/middlewares/auth');
var indexController = require('./controllers/index');

router.get('/production_head', indexController);

router.use(authMiddleware.pHeadAuth);


// rendering production head pages

function index(req,res){
    res.render('production/views/index');
}
function inventory(req,res, next) {
    res.render('production/views/inventory');
}
function productions(req,res, next) {
    res.render('production/views/productions');
}
function reports(req,res, next) {
    res.render('production/views/reports');
}
function trans(req,res, next) {
    res.render('production/views/transactions');
}

router.get('/', index);
router.get('/inventory', inventory);
router.get('/productions', productions);
router.get('/reports', reports);
router.get('/transactions', trans);

//


logoutRouter.get('/', (req, res) => {
    req.session.destroy(err => {
        if (err) throw err;
        res.redirect('/login');
    });
  });

exports.production = router;
exports.logout = logoutRouter;