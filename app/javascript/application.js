// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function() {
    var billingUnitSelect = document.getElementById('category_billing_unit');
    var hoursPricingDiv = document.getElementById('hours_pricing');
    var wordsPricingDiv = document.getElementById('words_pricing');
    const taskForm = document.getElementById('task_form');
  
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

    function calculateHoursTotal() {
      // Access the hourly rate from data attributes
      const hourlyRate = parseFloat(taskForm.dataset.hourlyRate) || 0;
      // Get the value entered for hours from the form
      const hours = parseFloat(document.getElementById('hours').value) || 0;
      // Calculate the total
      const total = hours * hourlyRate;
      // Now, display the total in your desired element
      console.log('Total for hours:', total);
    }
  
    // Event listener for when the billing unit selection changes
    billingUnitSelect.addEventListener('change', togglePricingFields);
  
    // Call the function to set the correct display on load
    togglePricingFields();
  });