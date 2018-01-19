// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require_tree .


window.objectToFormData = function (object, form, namespace) {
  var
    formData = form || new FormData(),
    formKey;

  if (typeof object !== 'object') {
    formData.append(namespace, object)
  } else {
    for ( var property in object ) {

      if ( object.hasOwnProperty(property)) {

        if ( namespace ) {
          formKey = namespace + '[' + property + ']';
        } else {
          formKey = property;
        }

        if (typeof object[property] === 'object' && !(object[property] instanceof File)) {
          if ( Array.isArray(object[property]) ) {
            var array = object[property];
            for (var i = 0 ; i < array.length; i++) {
              var arrayItem = array[i];
              objectToFormData(arrayItem, formData, formKey + '[]');
            }
          } else {
            objectToFormData(object[property], formData, formKey);
          }
        } else {
          formData.append(formKey, object[property]);
        }
      }
    }
  }

  return formData;
}
