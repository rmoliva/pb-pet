//= require lib/jquery-1.6.4
//= require lib/underscore
//= require lib/backbone
//= require lib/backbone-localstorage
//= require lib/json2
//= require lib/haml
//= require lib/lciberica

//= require todo/templates/item
//= require todo/templates/stats

//= require todo/models/todo
//= require todo/collections/todo_list

//= require todo/views/todo_view
//= require todo/views/application

// Create our global collection of **Todos**.
window.Todos = new Pet.todo.collections.TodoList;

