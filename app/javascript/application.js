// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function() {
  console.log('Page has loaded via Turbo');

  var billingUnitSelect = document.getElementById('category_billing_unit');
  var hoursPricingDiv = document.getElementById('hours_pricing');
  var wordsPricingDiv = document.getElementById('words_pricing');

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

  togglePricingFields();
  billingUnitSelect.addEventListener('change', togglePricingFields);

});

document.addEventListener('turbo:load', (event) => {
    const searchBarInput = document.getElementById('searchBarInput');
    console.log(searchBarInput);
    if (searchBarInput) {
      searchBarInput.addEventListener('keyup', function () {
        console.log('Search functionality is active');
        const query = this.value.toLowerCase();
        const rows = document.querySelectorAll("table tbody tr");
        rows.forEach(function (row) {
          const rowText = row.textContent.toLowerCase();
          row.style.display = rowText.includes(query) ? "" : "none";
        });
      });
    }
  });
  