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
function evdragoverwebsite (ev) {
    ev.preventDefault();
}
function evdropwebsite(ev,el) {
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
  $.post('/addtagtowebsite', relation);
}
function evdragenterwebsite (event,el) {
  $(el).toggleClass('over');
}

function evdragleavewebsite (event,el) {
  $(el).toggleClass('over');
}

$(function(){
  var CreateTag = function(){
    $('.js-create-tag').modal('show');
  }
  var CreateWebsite = function(){
    $('.js-create-website').modal('show');
  }
  var EditWebsite = function(e){
    var webid = $(this).attr('data-edit-web');
    var text = $('[data-edit-web-name=' + webid + ']').attr("contentEditable", true).focus();
    $(text).keydown(function(e){
      if (e.keyCode == 13){
        $(this).attr("contentEditable", false)
        var updateName = { web_name: $(text).text() }
        $.ajax({
          type: 'PUT',
          url: '/websites/' + webid,
          data : updateName
        });
      }
    })
  }

  var DeleteWebsite = function(){
    var webid = $(this).attr('data-delete-web');
    $.ajax({
      type: 'DELETE',
      url: '/websites/' + webid
    });
  }


  $(document).on('click','.newTag', CreateTag);
  $(document).on('click','.newWebsite', CreateWebsite);
  $(document).on('click','.edit-website', EditWebsite);
  $(document).on('click','.delete-website',DeleteWebsite)
  $(document).on('click','.submitTag', function(){
    $('.js-create-tag').modal('hide');
  })
  $(document).on('click','.submitWebsite', function(e){
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
