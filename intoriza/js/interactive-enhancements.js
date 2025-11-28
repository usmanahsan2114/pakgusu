/**
 * INTERACTIVE ENHANCEMENTS JAVASCRIPT
 * Advanced interactions for Pak Gusu Homepage
 */

(function ($) {
    'use strict';

    // ==================== SCROLL REVEAL ANIMATIONS ====================
    function initScrollReveal() {
        const revealElements = document.querySelectorAll('.scroll-reveal, .scroll-reveal-left, .scroll-reveal-right');

        const revealObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('revealed');
                    revealObserver.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        });

        revealElements.forEach(el => {
            revealObserver.observe(el);
        });
    }

    // ==================== ANIMATED NUMBER COUNTERS ====================
    function animateNumber(element, target, duration = 2000) {
        const startTime = Date.now();
        const startValue = 0;

        function update() {
            const currentTime = Date.now();
            const elapsed = currentTime - startTime;
            const progress = Math.min(elapsed / duration, 1);

            const currentValue = Math.floor(startValue + (target - startValue) * easeOutQuart(progress));
            element.textContent = currentValue.toLocaleString();

            if (progress < 1) {
                requestAnimationFrame(update);
            }
        }

        function easeOutQuart(t) {
            return 1 - Math.pow(1 - t, 4);
        }

        update();
    }

    // ==================== PROGRESS CIRCLES ====================
    function initProgressCircles() {
        const circles = document.querySelectorAll('.progress-circle');

        const circleObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('active');
                    circleObserver.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.5
        });

        circles.forEach(circle => {
            circleObserver.observe(circle);
        });
    }

    // ==================== STAT BARS ANIMATION ====================
    function initStatBars() {
        const statBars = document.querySelectorAll('.stat-bar');

        const barObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animated');
                    const percentage = entry.target.dataset.percentage || 100;
                    const fill = entry.target.querySelector('.stat-bar-fill');
                    if (fill) {
                        fill.style.width = percentage + '%';
                    }
                    barObserver.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.5
        });

        statBars.forEach(bar => {
            barObserver.observe(bar);
        });
    }

    // ==================== MAGNETIC BUTTON EFFECT ====================
    function initMagneticButtons() {
        const buttons = document.querySelectorAll('.magnetic-button');

        buttons.forEach(button => {
            button.addEventListener('mousemove', (e) => {
                const rect = button.getBoundingClientRect();
                const x = e.clientX - rect.left - rect.width / 2;
                const y = e.clientY - rect.top - rect.height / 2;

                button.style.transform = `translate(${x * 0.2}px, ${y * 0.2}px)`;
            });

            button.addEventListener('mouseleave', () => {
                button.style.transform = 'translate(0, 0)';
            });
        });
    }

    // ==================== BEFORE/AFTER SLIDER ====================
    function initBeforeAfterSlider() {
        const sliders = document.querySelectorAll('.before-after-slider');

        sliders.forEach(slider => {
            const after = slider.querySelector('.after-image');
            const handle = slider.querySelector('.slider-handle');
            let isDragging = false;

            function updatePosition(x) {
                const rect = slider.getBoundingClientRect();
                const position = Math.max(0, Math.min(100, ((x - rect.left) / rect.width) * 100));

                after.style.clipPath = `polygon(${position}% 0, 100% 0, 100% 100%, ${position}% 100%)`;
                handle.style.left = position + '%';
            }

            slider.addEventListener('mousedown', () => { isDragging = true; });
            document.addEventListener('mouseup', () => { isDragging = false; });

            slider.addEventListener('mousemove', (e) => {
                if (isDragging) {
                    updatePosition(e.clientX);
                }
            });

            slider.addEventListener('touchmove', (e) => {
                updatePosition(e.touches[0].clientX);
            });

            // Initialize at 50%
            updatePosition(slider.getBoundingClientRect().left + slider.offsetWidth / 2);
        });
    }

    // ==================== INTERACTIVE TIMELINE ====================
    function initInteractiveTimeline() {
        const timelineItems = document.querySelectorAll('.timeline-item');

        const timelineObserver = new IntersectionObserver((entries) => {
            entries.forEach((entry, index) => {
                if (entry.isIntersecting) {
                    setTimeout(() => {
                        entry.target.classList.add('visible');
                    }, index * 200);
                    timelineObserver.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.3
        });

        timelineItems.forEach(item => {
            timelineObserver.observe(item);
        });
    }

    // ==================== ADD PATTERN BACKGROUNDS ====================
    function addPatternBackgrounds() {
        // Add cleanroom pattern to Who We Are section
        $('.section-full.bg-gray').first().addClass('cleanroom-pattern-bg');

        // Add circuit pattern to sectors section
        $('.section-full').each(function () {
            if ($(this).find('.owl-carousel-filter').length) {
                $(this).addClass('circuit-pattern-bg');
            }
        });

        // Add molecular background to statistics
        $('.stats-counter-section').addClass('molecular-bg');
    }

    // ==================== ADD ANIMATED GRADIENTS ====================
    function addAnimatedGradients() {
        // Add animated gradient to CTA section
        $('.section-full.bg-gray').each(function () {
            if ($(this).find('h2').text().includes('Ready to start')) {
                $(this).removeClass('bg-gray').addClass('animated-gradient-bg');
            }
        });
    }

    // ====================RIPPLE EFFECTS ====================
    function addRippleEffects() {
        $('.wt-icon-box-wraper').addClass('ripple-effect');
        $('.line-filter-outer').addClass('ripple-effect');
    }

    // ==================== ICON ANIMATIONS ====================
    function addIconAnimations() {
        $('.flaticon-sketch, .flaticon-window, .flaticon-plant').addClass('icon-float');
        $('.flaticon-building, .flaticon-like, .flaticon-trophy').addClass('icon-spin-slow');
    }

    // ==================== GLOW BORDERS ====================
    function addGlowBorders() {
        $('.counter-box').addClass('glow-border');
    }

    // ==================== MICRO-INTERACTIONS ====================
    function initMicroInteractions() {
        // Add bounce on click
        $('.site-button, .site-button-link').on('click', function () {
            $(this).addClass('micro-bounce');
            setTimeout(() => {
                $(this).removeClass('micro-bounce');
            }, 500);
        });

        // Add shake on invalid form
        $('form').on('submit', function (e) {
            const invalidFields = $(this).find('input:invalid, textarea:invalid');
            if (invalidFields.length) {
                e.preventDefault();
                invalidFields.each(function () {
                    $(this).addClass('micro-shake');
                    setTimeout(() => {
                        $(this).removeClass('micro-shake');
                    }, 500);
                });
            }
        });
    }

    // ==================== PARALLAX EFFECT ====================
    function initParallaxEffect() {
        $(window).on('scroll', function () {
            const scrolled = $(window).scrollTop();

            // Parallax for background images
            $('.bg-cover, .bg-center').each(function () {
                const speed = 0.3;
                const yPos = -(scrolled * speed);
                $(this).css('background-position', `center ${yPos}px`);
            });
        });
    }

    // ==================== ADD SCROLL REVEAL CLASSES ====================
    function addScrollRevealClasses() {
        $('.section-head').addClass('scroll-reveal');
        $('.wt-icon-box-wraper').each(function (index) {
            if (index % 2 === 0) {
                $(this).addClass('scroll-reveal-left');
            } else {
                $(this).addClass('scroll-reveal-right');
            }
        });
    }

    // ==================== INITIALIZE ALL ====================
    $(document).ready(function () {
        // Add visual enhancements
        addPatternBackgrounds();
        addAnimatedGradients();
        addRippleEffects();
        addIconAnimations();
        addGlowBorders();
        addScrollRevealClasses();

        // Initialize interactions
        initScrollReveal();
        initProgressCircles();
        initStatBars();
        initMagneticButtons();
        initBeforeAfterSlider();
        initInteractiveTimeline();
        initMicroInteractions();
        initParallaxEffect();

        // Make FAB and buttons magnetic
        $('.fab-button, .site-button').addClass('magnetic-button');
        initMagneticButtons();

        console.log('%c 🎨 Interactive Enhancements Loaded! ', 'background: #29afe3; color: white; font-size: 14px; padding: 8px; font-weight: bold;');
        console.log('%c Patterns | Gradients | Parallax | Micro-interactions ', 'background: #004685; color: white; font-size: 10px; padding: 5px;');
    });

    // ==================== PERFORMANCE MONITORING ====================
    $(window).on('load', function () {
        // Log load time
        const loadTime = performance.now();
        console.log(`%c ⚡ Page loaded in ${(loadTime / 1000).toFixed(2)}s`, 'color: #29afe3; font-weight: bold;');
    });

})(jQuery);

// ==================== VANILLA JS FOR SVG ANIMATIONS ====================
document.addEventListener('DOMContentLoaded', function () {
    // Animate SVG icons when they come into view
    const svgIcons = document.querySelectorAll('.svg-icon-animate');

    if (svgIcons.length) {
        const svgObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animated');
                    svgObserver.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.5
        });

        svgIcons.forEach(icon => {
            svgObserver.observe(icon);
        });
    }
});
