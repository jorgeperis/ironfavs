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
//= require twitter/typeahead
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


function evdragoverminitag (ev) {
    ev.preventDefault();
}

function evdropminitag(ev,el) {
  ev.stopPropagation();
  ev.preventDefault();
  $(el).toggleClass('over');
  var tag_website = ev.dataTransfer.getData("text");
  $.ajax({
    type: 'DELETE',
    url: '/tag_websites/' + tag_website
  });
}

function evdragenterminitag (event,el) {
  $(el).toggleClass('over');
}

function evdragleaveminitag (event,el) {
  $(el).toggleClass('over');
}

function evdragendminitag(){
  $('.delete-mini-tag').css('display','none');
}

function evdragstartminitag(ev,el) {
    ev.dataTransfer.setData("text",$(el).attr('data-tag-website'));
    $(el).parent().parent().parent().children('.delete-mini-tag').css('display','block');
}

function evdragovertag (ev) {
    ev.preventDefault();
}
function evdroptag(ev,el) {
  ev.stopPropagation();
  ev.preventDefault();
  if (confirm("Are you sure to delete this tag?") == true){
    $(el).toggleClass('over');
    var usertag = ev.dataTransfer.getData("text");
    $.ajax({
      type: 'DELETE',
      url: '/tag_users/' + usertag
    });
  }
}

function evdroptagcolor (ev,el) {
  ev.stopPropagation();
  ev.preventDefault();
  $(el).toggleClass('over');
  $('.js-edit-tag').modal('show');
  var idUserTag = ev.dataTransfer.getData("text");
  var color = $('[data-user-tag=' + idUserTag + ']').attr('data-user-tag-color');
  var name = $('[data-user-tag=' + idUserTag + ']').attr('data-tag-name');
  $('[data-color=' + color + ']').css('display','none');
  $('.js-edit-tag-title').text("Change color of " + name);
  $('.js-user-tag-id').attr('data-user-tag-id', idUserTag);
}
function evdragentertag (event,el) {
  $(el).toggleClass('options-tags-hover');
}

function evdragleavetag (event,el) {
  $(el).toggleClass('options-tags-hover');
}

function evdragendtag(){
  $('.option-tags').css('visibility','hidden');
}

function evdragstarttag(ev,el) {
    ev.dataTransfer.setData("text",$(el).attr('data-user-tag'));
    $('.option-tags').css('visibility','visible');
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

function AjaxSearcher(suggestions,tags,inputText) {
  $.get('/websites',{
    suggest: suggestions,
    selectedtag: tags,
    inputtext: inputText
  });
}




var suggested_websites = [];
var tagsId = [];

$(function(){
  setTimeout(function(){ $('.alert').css('display','none'); }, 1500);

  var substringMatcher = function(strs) {
    return function findMatches(q, cb) {
      var matches, substringRegex;
      matches = [];
      substrRegex = new RegExp(q, 'i');
      $.each(strs, function(i, str) {
        if (substrRegex.test(str)) {
          matches.push({ value: str });
        }
      });
      cb(matches);
    };
  };

  $(document).on('turbolinks:load', function() {
    var userwebsites = $('.temp_information').data('temp')

    $('.typeahead').typeahead({
      hint: false,
      highlight: false,
      minLength: 1,
    },
    {
      name: 'userwebsites',
      displayKey: 'value',
      source: substringMatcher(userwebsites),
      templates: {
        empty: [
          '<div class="message">',
          'No username matches found. Enter an email instead!',
          '</div>'
        ].join('\n'),
        suggestion: function(userwebsite){
          suggested_websites.push(userwebsite.value);
          return  '<div id="website-selection">' +
                  '<p><strong>' + userwebsite.value + '</strong></p>' +
                  '</div>' ;

        }
      }
    });
    $('.typeahead').on('keyup', function(e){
      var inputText = $('[name="search"]').val();
      AjaxSearcher(suggested_websites,tagsId,inputText);
    });
    $('.typeahead').on('keydown',function(e){
      suggested_websites = [];
    });
  });





  $('.side-tags').removeClass('over');

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

  var ShowEditTagColors = function(){
    $('.js-edit-tag').modal('show');
    var idUserTag = $(this).attr('data-edit-tag');
    var color = $(this).attr('data-user-tag-color');
    var name = $(this).attr('data-tag-name');
    $('[data-color=' + color + ']').css('display','none');
    $('.js-edit-tag-title').text("Change color of " + name);
    $('.js-user-tag-id').attr('data-user-tag-id', idUserTag);
  }

  var EditTagColor = function(){
    $('.js-edit-tag').modal('hide');
    $('.edit-tag-colors').css('display','block');
    var idUserTag = $('.js-user-tag-id').attr('data-user-tag-id');
    var newColor = $(this).attr('data-color');
    $.ajax({
      type: 'PUT',
      url: '/tag_users/' + idUserTag,
      data : {color_name: newColor}
    });
  }
var OnClickTags = function(e) {
  // if ($(e.target).hasClass('side-tags')) {
    tagsId = [];
    $(this).toggleClass('btn-fill');
    var tags = $('.side-tags.btn-fill');
    tags.each( function(i,tag){
      tagsId.push(parseInt($(tag).attr('data-user-tag')));
    });
    var inputText = $('[name="search"]').val();
    AjaxSearcher(suggested_websites,tagsId,inputText);
  // } else {
  //   EditTagColor;
  // }
}
  $(document).on('click', '.user', function(){
    $('.js-edit-user').modal('show');
  })
  $(document).on('click','.enter', function(){
    $('.js-enter-user').modal('show');
  });
  $(document).on('click','.register', function(){
    $('.js-register-user').modal('show');
  });
  $(document).on('click','.side-tags', OnClickTags);
  $(document).on('click','.edit-tag-colors',EditTagColor);
  $(document).on('click','.newTag', CreateTag);
  $(document).on('click','.newWebsite', CreateWebsite);
  $(document).on('click','.edit-website', EditWebsite);
  $(document).on('click','.submitTag', function(){
    $('.js-create-tag').modal('hide');
  })
  $(document).on('click','.submitWebsite', function(e){
    var a = $('#website_url').val()
    if (a.length > 25) {
      a = a.slice(0,23) + "..."
    }
    $('.js-create-website').modal('hide');
    var website_class = $('<div>').addClass('website js-website').attr('tabindex',0);
    var individual_website = $('<div>').addClass('website_individual font_style').text(a);
    var screenshot_class = $('<div>').addClass('screenshot preview');
    var image = $('<img>').attr('src','/assets/loading.gif');
    if ($('.while_charge').length) {
      $('.while_charge').remove();
      individual_website.addClass('charge_website');
    }
    screenshot_class.append(image);
    individual_website.append(screenshot_class)
    website_class.append(individual_website);
    $('.websites_dashboard').append(website_class);
    website_class.focus();
  })
})
