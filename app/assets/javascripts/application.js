// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min.js
//= require require.js
//= require modernizr.js
//= require spin.min.js
//= require main.js

function get_date(){
  var d = new Date();
  var date_string = "" + d.getFullYear().toString() + "-";
  var month = (d.getMonth() + 1);
  date_string += (month < 10 ? "0" + month.toString() : month.toString());
  date_string += "-" + d.getDate().toString();
  return date_string;
}

function get_timestamp(){
  var d = new Date();
  return d.getTime().toString();
}

/*
  returns true unless:
    empty string
    empty object
    NaN
    null
    false
    undefined
    empty array
*/

function exists(arg){
  if(typeof(arg) === 'undefined'){
    return false;
  } else if(arg === false){
    return false
  } else if(typeof(arg) === 'string'){
    return arg.trim().length > 0;
  } else if(typeof(arg) === 'number'){
    return !isNaN(arg);
  } else if(typeof(arg) === "object"){
    if(arg === null){
      return false;
    } else if(typeof(arg.length) !== 'undefined'){
      return arg.length > 0
    } else {
      // if it has any enumerable properties, return true
      for (var x in arg){ 
        return true;
      }
    }
  }
  return true;
}