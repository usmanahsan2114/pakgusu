/**
 * DYNAMIC BACKGROUNDS GENERATOR
 * Creates and injects moving elements throughout the page
 */

(function ($) {
    'use strict';

    // ==================== CREATE MULTI-LAYER WAVES ====================
    function createWaveBackground(selector) {
        const sections = document.querySelectorAll(selector);

        sections.forEach(section => {
            if (!section.querySelector('.wave-bg-container')) {
                const waveContainer = document.createElement('div');
                waveContainer.className = 'wave-bg-container';
                waveContainer.innerHTML = `
                    <div class="wave-layer wave-layer-1"></div>
                    <div class="wave-layer wave-layer-2"></div>
                    <div class="wave-layer wave-layer-3"></div>
                `;

                section.style.position = 'relative';
                section.style.overflow = 'hidden';
                section.insertBefore(waveContainer, section.firstChild);
            }
        });
    }

    // ==================== CREATE FLOATING ORBS ====================
    function createFloatingOrbs(selector) {
        const sections = document.querySelectorAll(selector);

        sections.forEach(section => {
            if (!section.querySelector('.floating-orbs')) {
                const orbsContainer = document.createElement('div');
                orbsContainer.className = 'floating-orbs';
                orbsContainer.innerHTML = `
                    <div class="orb orb-1"></div>
                    <div class="orb orb-2"></div>
                    <div class="orb orb-3"></div>
                    <div class="orb orb-4"></div>
                `;

                section.style.position = 'relative';
                section.style.overflow = 'hidden';
                section.insertBefore(orbsContainer, section.firstChild);
            }
        });
    }

    // ==================== CREATE GEOMETRIC SHAPES ====================
    function createGeometricShapes(selector) {
        const sections = document.querySelectorAll(selector);

        sections.forEach(section => {
            if (!section.querySelector('.geometric-bg')) {
                const geoContainer = document.createElement('div');
                geoContainer.className = 'geometric-bg';

                // Create random shapes
                const shapes = [
                    { class: 'geo-triangle', top: '10%', left: '15%' },
                    { class: 'geo-square', top: '60%', right: '10%' },
                    { class: 'geo-circle', top: '30%', left: '70%' },
                    { class: 'geo-hexagon', bottom: '20%', left: '25%' },
                    { class: 'geo-triangle', top: '75%', left: '60%' },
                    { class: 'geo-square', top: '15%', right: '30%' }
                ];

                shapes.forEach(shape => {
                    const shapeDiv = document.createElement('div');
                    shapeDiv.className = `geo-shape ${shape.class}`;
                    shapeDiv.style.top = shape.top || '';
                    shapeDiv.style.bottom = shape.bottom || '';
                    shapeDiv.style.left = shape.left || '';
                    shapeDiv.style.right = shape.right || '';
                    geoContainer.appendChild(shapeDiv);
                });

                section.style.position = 'relative';
                section.style.overflow = 'hidden';
                section.insertBefore(geoContainer, section.firstChild);
            }
        });
    }

    // ==================== CREATE ANIMATED BLOBS ====================
    function createAnimatedBlobs(selector) {
        const sections = document.querySelectorAll(selector);

        sections.forEach(section => {
            if (!section.querySelector('.blob-container')) {
                const blobContainer = document.createElement('div');
                blobContainer.className = 'blob-container';
                blobContainer.innerHTML = `
                    <div class="blob blob-1"></div>
                    <div class="blob blob-2"></div>
                    <div class="blob blob-3"></div>
                `;

                section.style.position = 'relative';
                section.style.overflow = 'hidden';
                section.insertBefore(blobContainer, section.firstChild);
            }
        });
    }

    // ==================== CREATE DOTS BACKGROUND ====================
    function createDotsBackground(selector) {
        const sections = document.querySelectorAll(selector);

        sections.forEach(section => {
            if (!section.querySelector('.dots-bg')) {
                const dotsDiv = document.createElement('div');
                dotsDiv.className = 'dots-bg';

                section.style.position = 'relative';
                section.style.overflow = 'hidden';
                section.insertBefore(dotsDiv, section.firstChild);
            }
        });
    }

    // ==================== CREATE DIAGONAL LINES ====================
    function createDiagonalLines(selector) {
        const sections = document.querySelectorAll(selector);

        sections.forEach(section => {
            if (!section.querySelector('.diagonal-lines-bg')) {
                const linesDiv = document.createElement('div');
                linesDiv.className = 'diagonal-lines-bg';

                section.style.position = 'relative';
                section.style.overflow = 'hidden';
                section.insertBefore(linesDiv, section.firstChild);
            }
        });
    }

    // ==================== ADD SECTION BACKGROUND ANIMATIONS ====================
    function addSectionAnimations(selector) {
        const sections = document.querySelectorAll(selector);
        sections.forEach(section => {
            section.classList.add('section-bg-animated');
        });
    }

    // ==================== AUTO-APPLY TO SECTIONS ====================
    $(document).ready(function () {
        console.log('%c 🌊 Generating Dynamic Backgrounds... ', 'background: #29afe3; color: white; font-size: 14px; padding: 8px; font-weight: bold;');

        // Add waves to blue sections (stats counter)
        createWaveBackground('.stats-counter-section');
        createWaveBackground('.section-full.bg-primary');
        createWaveBackground('.animated-gradient-bg');

        // Add floating orbs to white/gray sections
        createFloatingOrbs('.section-full.bg-white');
        createFloatingOrbs('.section-full.bg-gray');

        // Add geometric shapes to specific sections
        createGeometricShapes('.section-full:nth-of-type(odd)');

        // Add blobs to sectors carousel section
        $('.section-full').each(function () {
            if ($(this).find('.owl-carousel-filter').length) {
                createAnimatedBlobs(this);
            }
        });

        // Add dots background to alternating sections
        createDotsBackground('.section-full:nth-of-type(even)');

        // Add diagonal lines to manufacturing section
        $('.section-full').each(function () {
            if ($(this).text().includes('Manufacturing Facility')) {
                createDiagonalLines(this);
            }
        });

        // Add radial pulse to all sections
        addSectionAnimations('.section-full');

        // Log completion
        console.log('%c ✨ Dynamic Backgrounds Active! ', 'background: #004685; color: white; font-size: 12px; padding: 6px; font-weight: bold;');
        console.log('%c Waves: ✓ | Orbs: ✓ | Shapes: ✓ | Blobs: ✓ | Dots: ✓ | Lines: ✓ ', 'background: #1a8bb5; color: white; font-size: 10px; padding: 5px;');
    });

    // ==================== MOUSE INTERACTIVE ORBS ====================
    $(document).mousemove(function (e) {
        // Make orbs slightly follow mouse (subtle effect)
        const mouseX = e.pageX;
        const mouseY = e.pageY;

        $('.orb').each(function (index) {
            const speed = (index + 1) * 0.005; // Different speed for each orb
            const x = (mouseX - $(window).width() / 2) * speed;
            const y = (mouseY - $(window).height() / 2) * speed;

            $(this).css({
                'transform': `translate(${x}px, ${y}px)`
            });
        });
    });

    // ==================== SCROLL-BASED PARALLAX FOR BLOBS ====================
    $(window).on('scroll', function () {
        const scrolled = $(window).scrollTop();

        $('.blob').each(function (index) {
            const speed = (index + 1) * 0.1;
            const yPos = scrolled * speed;
            $(this).css('transform', `translateY(${yPos}px)`);
        });

        // Parallax for geometric shapes
        $('.geo-shape').each(function (index) {
            const speed = (index % 2 === 0) ? 0.15 : -0.15;
            const yPos = scrolled * speed;
            $(this).css('transform', `translateY(${yPos}px)`);
        });
    });

    // ==================== CREATE PARTICLE BURST ON CLICK ====================
    let particleId = 0;
    $(document).on('click', '.site-button, .site-button-link', function (e) {
        const particleCount = 12;
        const x = e.pageX;
        const y = e.pageY;

        for (let i = 0; i < particleCount; i++) {
            const particle = $('<div>', {
                class: 'particle-burst',
                css: {
                    left: x + 'px',
                    top: y + 'px',
                    background: i % 2 === 0 ? '#29afe3' : '#004685'
                }
            });

            $('body').append(particle);

            const angle = (360 / particleCount) * i;
            const velocity = 50 + Math.random() * 50;
            const rad = angle * (Math.PI / 180);
            const translateX = Math.cos(rad) * velocity;
            const translateY = Math.sin(rad) * velocity;

            setTimeout(() => {
                particle.css({
                    'transform': `translate(${translateX}px, ${translateY}px)`,
                    'opacity': '1'
                });
            }, 10);

            setTimeout(() => {
                particle.remove();
            }, 1000);
        }
    });

    // ==================== ADD WAVE TO HERO SECTION ====================
    $(window).on('load', function () {
        // Add waves to revolution slider background
        if ($('#rev_slider_26_1_wrapper').length) {
            const heroSection = $('#rev_slider_26_1_wrapper').parent();
            createWaveBackground(heroSection[0]);
            createFloatingOrbs(heroSection[0]);
        }
    });

    // ==================== PERFORMANCE MONITORING ====================
    $(window).on('load', function () {
        const performanceData = performance.getEntriesByType('navigation')[0];
        if (performanceData) {
            console.log(`%c 📊 Page Performance:`, 'color: #29afe3; font-weight: bold;');
            console.log(`%c Load Time: ${(performanceData.loadEventEnd - performanceData.fetchStart) / 1000}s`, 'color: #004685;');
            console.log(`%c DOM Ready: ${(performanceData.domContentLoadedEventEnd - performanceData.fetchStart) / 1000}s`, 'color: #004685;');
        }
    });

})(jQuery);

// ==================== VANILLA JS ENHANCEMENTS ====================
document.addEventListener('DOMContentLoaded', function () {
    // Add smooth transitions to all new elements
    const animatedElements = document.querySelectorAll('.wave-layer, .orb, .blob, .geo-shape');
    animatedElements.forEach(el => {
        el.style.transition = 'transform 0.3s ease-out';
    });

    console.log('%c 🎬 All Animations Initialized! ', 'background: linear-gradient(135deg, #29afe3, #004685); color: white; font-size: 12px; padding: 10px; font-weight: bold; border-radius: 5px;');
});
