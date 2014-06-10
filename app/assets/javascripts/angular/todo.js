var app = angular.module('todo', []);

app.controller('ListController', function(){

  this.lists = lists;

  this.initial = function(all_lists){
    var todo_count = 0;
    for(var i=0;i<all_lists.length;i++){

      $.ajax({
        url: '/lists/'+all_lists[i].id+'/count',
        type: 'GET',
        success: function(data) {
          todo_count = data;
        },
        async: false
      });

      lists.push({
        title: all_lists[i].title,
        count: todo_count,
        id: all_lists[i].id
      });
    }
  };

  this.addList = function(){
    var temp_id = 0;
    $.ajax({
      url: '/lists/',
      type: 'POST',
      data: {title: this.lists.title},
      success: function(data) {
        temp_id = data.id;
      },
      async: false
    });
    this.lists.push({title: this.lists.title, count: 0,id: temp_id});
    this.lists.title = '';
  };

});

app.controller('TodoController', function(){

  this.things = todos;

  this.change = function(id, status){
    $.ajax({
      url: '/lists/'+this.listId+'/todos/'+id,
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
          url: '/lists/'+this.listId+'/todos/'+old[i].id,
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
        url: '/lists/'+this.listId+'/todos',
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

  this.init = function(all_todos, alist){
    this.title = alist.title;
    this.listId = alist.id;

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
var lists = [];
