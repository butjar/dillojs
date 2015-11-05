var apiBaseUrl = 'http://localhost:8080/api'

Dillo = Backbone.Model.extend({ 
  idAttribute: '_id', 
  defaults: {
    weight: 1,
    alive: true
  }
});

DilloCollection = Backbone.Collection.extend({
  model: Dillo,
  url: apiBaseUrl + "/dillo" 
});

DilloView = Backbone.View.extend({
  tagName: 'tr',
  template: _.template($('#dillo-template').html()),
  render: function(){
    this.$el.html(this.template(this.model.attributes));
    return this;
  }
});

dilloCollection = new DilloCollection();

AppView = Backbone.View.extend({
  el: '#dillos',
  initialize: function () {
    dilloCollection.on("reset", this.render, this);
    dilloCollection.on("add", this.addOne, this );
    dilloCollection.fetch();
  },
  events: {
    'click #add': 'createDillo'
  },
  createDillo: function(evt){
    var weight = this.$('#weight-input').val().trim(),
        alive = this.$('#alive-input').prop('checked');
        _dillo = {_id: null, alive: alive}
    !parseInt(weight) === NaN ? _dillo.weight = weight : undefined

    var dillo = dilloCollection.create(_dillo);
    dillo.on("sync", this.render, this);
  },
  addOne: function(dillo){
    var view = new DilloView({ model: dillo });
    $('#dillo-collection').append(view.render().el);
  },
  render: function(){
    $('#dillo-collection').html('');
    dilloCollection.each(this.addOne, this);
    return this;
  }
});

var App = {
  init: function(){
    new AppView();
  }
};

module.exports = App;

var runOverDillo = function(){
};

var feedDillo = function(){
};
