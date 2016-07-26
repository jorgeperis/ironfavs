// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
function evdragstart(ev,el) {
    ev.dataTransfer.setData("text",$(el).attr('data-tag'));
    $(el).toggleClass('opacity');
}
function evdragover (ev) {
    ev.preventDefault();
}
function evdrop(ev,el) {
  ev.stopPropagation();
  ev.preventDefault();
  $(el).toggleClass('over');
  var websiteid = $(el).attr('data-web');
  var tagid = ev.dataTransfer.getData("text");
  var tag = $("[data-tag=" + tagid + "]");
  tag.toggleClass('opacity');
  var relation = {
      tag_id: tagid,
      website_id: websiteid
  }
  console.log(relation);
  $.post('/addtagtowebsite', relation);

}
function evdragenter(event,el) {
  $(el).toggleClass('over');
}

function evdragleave(event,el) {
  $(el).toggleClass('over');
}

$(function(){
var CreateTag = function(){
  $('.js-create-tag').modal('show');
}
var CreateWebsite = function(){
  $('.js-create-website').modal('show');
}



$(document).on('click','.newTag', CreateTag);
$(document).on('click','.newWebsite', CreateWebsite);

$('.submitTag').on('click', function(){
  $('.js-create-tag').modal('hide');
})
$('.submitWebsite').on('click', function(e){
  var a = $('#website_url').val()
  if (a.length > 15) {
    a = a.slice(0,13) + "..."
  }
  $('.js-create-website').modal('hide');
  var mainDiv = $('<div>').addClass('website js-website');
  var individual = $('<div>').addClass('website_individual').text(a);

  var image = $('<img>').attr('src','/assets/loading.gif');
  individual.append(image);
  mainDiv.append(individual);
  $('.col-sm-8').append(mainDiv);
})





})
