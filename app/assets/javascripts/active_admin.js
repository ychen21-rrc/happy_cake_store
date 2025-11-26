// ActiveAdmin UJS Patch for Rails 8 + Propshaft
// This replaces the standard active_admin/base which requires Sprockets/jQuery
document.addEventListener('DOMContentLoaded', function() {
  console.log('ActiveAdmin UJS Patch Loaded');
  
  document.body.addEventListener('click', function(e) {
    let target = e.target;
    while (target && target !== document.body) {
      if (target.matches('a[data-method="delete"]')) {
        e.preventDefault();
        e.stopPropagation();

        const message = target.getAttribute('data-confirm');
        if (message && !confirm(message)) {
          return;
        }

        const url = target.getAttribute('href');
        const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

        console.log('Sending DELETE request to:', url);

        fetch(url, {
          method: 'DELETE',
          headers: {
            'X-CSRF-Token': csrfToken,
            'Accept': 'text/html, application/xhtml+xml'
          },
          redirect: 'manual' // Prevent automatic redirect following to avoid method preservation issues
        }).then(response => {
          console.log('Response status:', response.status, 'Type:', response.type);
          
          // If status is 0 (opaque redirect) or 3xx, it succeeded and tried to redirect.
          // If status is 200, it might have returned content directly.
          // In both cases, we should probably reload or navigate.
          if (response.type === 'opaqueredirect' || (response.status >= 200 && response.status < 400)) {
            // We can't read the Location header in opaque/manual mode easily with standard fetch in some contexts,
            // but ActiveAdmin delete usually redirects to the index.
            // Reloading the current page is a safe bet if we are on the index.
            // If we are on the show page, reloading might 404.
            
            // Best guess: Go to the resource collection path. 
            // We can try to infer it from the URL (remove the ID).
            // url is like /admin/categories/9
            // newUrl is like /admin/categories
            
            const currentUrl = window.location.href;
            // If we are on the show page (url ends with ID), we should go up one level.
            // If we are on the index page, we can just reload.
            
            window.location.reload(); 
          } else if (response.status === 404) {
             alert('Resource not found (404). It might have been already deleted.');
          } else {
            console.error('Delete failed with status:', response.status);
            alert('Delete failed. Please check console for details.');
          }
        }).catch(error => {
          console.error('Error:', error);
          alert('An error occurred while deleting.');
        });

        return;
      }
      target = target.parentElement;
    }
  });
});
