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
function evdragovertag (ev) {
    ev.preventDefault();
}
function evdroptag(ev,el) {
  ev.stopPropagation();
  ev.preventDefault();
  $(el).toggleClass('over');
  var usertag = ev.dataTransfer.getData("text");
  $.ajax({
    type: 'DELETE',
    url: '/tag_users/' + usertag
  });
}
function evdragentertag (event,el) {
  $(el).toggleClass('over');
}

function evdragleavetag (event,el) {
  $(el).toggleClass('over');
}

function evdragend(){
  $('.delete-tag').css('visibility','hidden');
}




function evdragstart(ev,el) {
    ev.dataTransfer.setData("text",$(el).attr('data-user-tag'));
    $('.delete-tag').css('visibility','visible');
}
function evdragoverwebsite (ev) {
    ev.preventDefault();
}
function evdropwebsite(ev,el) {
  ev.stopPropagation();
  ev.preventDefault();
  $(el).toggleClass('over');
  var userwebsite = $(el).attr('data-web');
  var usertag = ev.dataTransfer.getData("text");
  $.post('/tag_websites',
   {
      usertag_id: usertag,
      userwebsite_id: userwebsite
  });
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
    var userwebsiteid = $(this).attr('data-edit-web');
    var text = $('[data-edit-web-name=' + userwebsiteid + ']').attr("contentEditable", true).focus();
    $(text).keydown(function(e){
      if (e.keyCode == 13){
        $(this).attr("contentEditable", false)
        var updateName = { web_name: $(text).text() }
        $.ajax({
          type: 'PUT',
          url: '/user_websites/' + userwebsiteid,
          data : updateName
        });
      }
    })
  }

  var DeleteWebsite = function(){
    var userwebsiteid = $(this).attr('data-delete-web');
    $.ajax({
      type: 'DELETE',
      url: '/user_websites/' + userwebsiteid
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
    var website_class = $('<div>').addClass('website js-website');
    var individual_website = $('<div>').addClass('website_individual').text(a);
    var screenshot_class = $('<div>').addClass('screenshot preview');
    var image = $('<img>').attr('src','/assets/loading.gif');
    screenshot_class.append(image);
    individual_website.append(screenshot_class)
    website_class.append(individual_website);
    $('.col-sm-8').append(website_class);
  })
})
