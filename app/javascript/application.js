// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// import 'bootstrap';

document.addEventListener("turbo:render", function() {
  console.log('Turbo render is running');
  var billingUnitSelect = document.getElementById('category_billing_unit');
  var hoursPricingDiv = document.getElementById('hours_pricing');
  var wordsPricingDiv = document.getElementById('words_pricing');

  // Function to toggle pricing fields
  function togglePricingFields() {
      console.log('Toggling pricing fields');
      var billingUnit = billingUnitSelect.value;
      
      if (billingUnit === 'HOURS') {
          hoursPricingDiv.style.display = 'block';
          wordsPricingDiv.style.display = 'none';
      } else if (billingUnit === 'WORDS') {
          hoursPricingDiv.style.display = 'none';
          wordsPricingDiv.style.display = 'block';
      } else {
          hoursPricingDiv.style.display = 'none';
          wordsPricingDiv.style.display = 'none';
      }
  }

  // Initialize pricing fields on load
  togglePricingFields();

  // Add event listener for changes on the billing unit select
  billingUnitSelect.addEventListener('change', togglePricingFields);
});



  // document.addEventListener("turbo:load", function() {
  //   setTimeout(function() {
  //     document.querySelectorAll('.alert').forEach(function(alert) {
  //       alert.style.display = 'none';
  //     });
  //   }, 6000);

  // });