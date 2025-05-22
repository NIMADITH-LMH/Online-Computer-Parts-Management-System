/**
 * Image Helper Script
 * This script provides utility functions to handle image loading errors
 * and provide fallback images for the online store.
 */

// Function to handle image loading errors
function handleImageError(img) {
    // Try to load a fallback image
    img.onerror = null; // Prevent infinite loop
    img.src = contextPath + '/image/76245.PNG';
    
    // Log the error
    console.log('Image failed to load, using fallback: ' + img.alt);
}

// Apply the error handler to all images on the page
document.addEventListener('DOMContentLoaded', function() {
    // Set a global context path if not already set
    if (typeof contextPath === 'undefined') {
        // Try to get it from a meta tag
        const metaContext = document.querySelector('meta[name="contextPath"]');
        window.contextPath = metaContext ? metaContext.getAttribute('content') : '';
    }
    
    // Apply error handler to all images
    const images = document.querySelectorAll('img');
    images.forEach(function(img) {
        img.addEventListener('error', function() {
            handleImageError(this);
        });
    });
});
