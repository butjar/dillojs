// Require scripts
var express = require('express'),
    bodyParser = require('body-parser'),
    mongoose   = require('mongoose'),
    MongoClient = require('mongodb').MongoClient,
    //path = require("path"),
    cors = require('cors')

// Base setup
var app = express();
var port = process.env.PORT || 8080;
var router = express.Router();
var Dillo = mongoose.model('Dillo', { weight: Number, alive: Boolean });
var mongoUrl = process.env.MONGO_URL || 'localhost'

//app.use(express.static(path.join(__dirname, '../', 'web/public')));
app.use(cors());

app.use(bodyParser.json());
mongoose.connect('mongodb://' + mongoUrl + ':27017/dillojs');

// CRUD
router.route('/dillo')

// CREATE
  .post(function(req, res) {
    console.log("Create Dillo");
    var dillo = new Dillo({
      weight: req.body.weight,
      alive: req.body.alive
    });

    dillo.save(function(err) {
      if (err) {
        res.send(err);
      }
      res.json(dillo);
    });
  })

// READ
  .get(function(req, res) {
    console.log("Return all dillos");
    Dillo.find(function(err, dillos) {
      if (err) {
        res.send(err);
      }
      res.json(dillos);
  });
});

router.route('/dillo/:dillo_id')

  .get(function(req, res) {
    Dillo.findById(req.params.dillo_id, function(err, dillo) {
      if (err) {
        res.send(err);
      }
      res.json(dillo);
    });
  })

//UPDATE
  .put(function(req, res) {
    Dillo.findById(req.params.dillo_id, function(err, dillo) {
      if (err) {
        res.send(err);
      }
      console.log(req.body);
      dillo.weight = req.body.weight;
      dillo.alive = req.body.alive;
      dillo.save(function(err) {
        if (err) {
          res.send(err);
        }
        res.json(dillo);
      });
    });
  })
  
// DELETE
  .delete(function(req, res) {
    Dillo.remove({ _id: req.params.dillo_id }, function(err, dillo) {
      if (err) {
        res.send(err);
      }
      res.json({ message: 'Successfully deleted' });
    });
  });

// Start app
app.use('/api', router);
app.listen(port);
