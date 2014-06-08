var app = angular.module('todo', []);

app.controller('TodoController', function(){
  this.things = todos;

  this.change = function(id, status){
    $.ajax({
      url: '/todos/'+id,
      type: 'PUT',
      data: {done: status},
      success: function(result) {
      },
      async: false
    });
  };

  this.archive = function(){
    var old = this.things;
    this.things = [];
    for(var i=0;i<old.length;i++){
      if(!old[i].done){
        this.things.push(old[i]);
      }else{
        $.ajax({
          url: '/todos/'+old[i].id,
          type: 'DELETE',
          success: function(result) {
          }
        });
      }
    }
  };

  this.remaining = function(){
    var count = 0;
    angular.forEach(this.things, function(thing){
      count += (thing.done) ? 0 : 1;
    });
    return count;
  };

  this.addTodo = function(){
    var temp_id = 0;

    if(this.things.text){
      $.ajax({
        url: '/todos/',
        type: 'POST',
        data: {todo: this.things.text, done: false},
        success: function(data) {
          temp_id = data.id;
        },
        async: false
      });

      this.things.push({text: this.things.text, done: false, id: temp_id});
      this.things.text = '';
    }
  };

  this.init = function(all_todos){
    for(var i=0;i<all_todos.length;i++){
      todos.push({
        text: all_todos[i].todo,
        done: all_todos[i].done,
        id: all_todos[i].id
      });
    }
  };

});

var todos = [];
