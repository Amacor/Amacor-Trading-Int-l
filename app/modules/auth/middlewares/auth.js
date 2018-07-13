//customer
exports.hasAuth = (req, res, next) => {
    if (req.session && req.session.user && Object.keys(req.session.user).length > 0 ) return next();
    return res.redirect('/login?unauthorized');
    }

exports.noAuthed = (req, res, next) => {
    if (req.session && req.session.user && Object.keys(req.session.user).length > 0 ) return res.redirect('/');
    return next();
    }

//admin
exports.adminAuth = (req, res, next) => {
    if (req.session && req.session.admin && Object.keys(req.session.admin).length > 0 ) return next();
    return res.redirect('/login?unauthorized');
    }
exports.adminNoAuthed = (req, res, next) => {
    if (req.session && req.session.admin && Object.keys(req.session.admin).length > 0 ) return res.redirect('/admin');
    return next();
    }


//subcontracors    
exports.subConAuth = (req, res, next) => {
    if (req.session && req.session.subcontractor && Object.keys(req.session.subcontractor).length > 0 ) return next();
    return res.redirect('/login?unauthorized');
    }

exports.subConNoAuthed = (req, res, next) => {
    if (req.session && req.session.subcontractor && Object.keys(req.session.subcontractor).length > 0 ) return res.redirect('/subcontractor');
    return next();
    }

//production head
exports.pHeadAuth = (req, res, next) => {
    if (req.session && req.session.production && Object.keys(req.session.production).length > 0 ) return next();
    return res.redirect('/login?unauthorized');
    }

exports.pHeadAuthed = (req, res, next) => {
    if (req.session && req.session.production && Object.keys(req.session.production).length > 0 ) return res.redirect('/production');
    return next();
    }