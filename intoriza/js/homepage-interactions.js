/**
 * HOMEPAGE INTERACTIVE ENHANCEMENTS
 * Custom JavaScript for Pak Gusu Homepage
 */

(function ($) {
    'use strict';

    // ==================== PAGE LOAD ====================
    $(window).on('load', function () {
        // Hide loading screen after page loads
        setTimeout(function () {
            $('.loading-screen').addClass('hidden');
        }, 500);

        // Initialize all effects
        initializeParticles();
        initializeCounters();
        initializeLightbox();
        initializeTiltEffect();
        initializeSmoothScroll();
    });

    // ==================== DOCUMENT READY ====================
    $(document).ready(function () {
        // Add custom classes to existing elements
        enhanceExistingElements();

        // Initialize scroll progress bar
        initializeScrollProgress();

        // Initialize hover effects
        initializeHoverEffects();

        // Add scroll indicator to hero
        addScrollIndicator();
    });

    // ==================== PARTICLES.JS INITIALIZATION ====================
    function initializeParticles() {
        if (typeof particlesJS !== 'undefined' && $('#particles-js').length) {
            particlesJS('particles-js', {
                particles: {
                    number: {
                        value: 80,
                        density: {
                            enable: true,
                            value_area: 800
                        }
                    },
                    color: {
                        value: '#ffffff'
                    },
                    shape: {
                        type: 'circle',
                        stroke: {
                            width: 0,
                            color: '#000000'
                        }
                    },
                    opacity: {
                        value: 0.5,
                        random: false,
                        anim: {
                            enable: false,
                            speed: 1,
                            opacity_min: 0.1,
                            sync: false
                        }
                    },
                    size: {
                        value: 3,
                        random: true,
                        anim: {
                            enable: false,
                            speed: 40,
                            size_min: 0.1,
                            sync: false
                        }
                    },
                    line_linked: {
                        enable: true,
                        distance: 150,
                        color: '#ffffff',
                        opacity: 0.4,
                        width: 1
                    },
                    move: {
                        enable: true,
                        speed: 2,
                        direction: 'none',
                        random: false,
                        straight: false,
                        out_mode: 'out',
                        bounce: false,
                        attract: {
                            enable: false,
                            rotateX: 600,
                            rotateY: 1200
                        }
                    }
                },
                interactivity: {
                    detect_on: 'canvas',
                    events: {
                        onhover: {
                            enable: true,
                            mode: 'grab'
                        },
                        onclick: {
                            enable: true,
                            mode: 'push'
                        },
                        resize: true
                    },
                    modes: {
                        grab: {
                            distance: 140,
                            line_linked: {
                                opacity: 1
                            }
                        },
                        push: {
                            particles_nb: 4
                        }
                    }
                },
                retina_detect: true
            });
        }
    }

    // ==================== COUNTER ANIMATIONS ====================
    function initializeCounters() {
        if ($('.counter').length) {
            // Use Intersection Observer for better performance
            const counterObserver = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.isIntersecting && !$(entry.target).hasClass('counted')) {
                        animateCounter(entry.target);
                        $(entry.target).addClass('counted');
                    }
                });
            }, {
                threshold: 0.5
            });

            $('.counter').each(function () {
                counterObserver.observe(this);
            });
        }
    }

    function animateCounter(element) {
        const $element = $(element);
        const target = parseInt($element.data('target'));
        const duration = 2000;
        const increment = target / (duration / 16);
        let current = 0;

        const timer = setInterval(function () {
            current += increment;
            if (current >= target) {
                current = target;
                clearInterval(timer);
            }
            $element.text(Math.floor(current));
        }, 16);
    }

    // ==================== LIGHTBOX INITIALIZATION ====================
    function initializeLightbox() {
        if (typeof GLightbox !== 'undefined') {
            const lightbox = GLightbox({
                touchNavigation: true,
                loop: true,
                autoplayVideos: true,
                closeButton: true,
                closeOnOutsideClick: true
            });
        }
    }

    // ==================== TILT EFFECT ====================
    function initializeTiltEffect() {
        if (typeof VanillaTilt !== 'undefined') {
            const tiltElements = document.querySelectorAll('.hover-3d');
            if (tiltElements.length) {
                VanillaTilt.init(tiltElements, {
                    max: 15,
                    speed: 400,
                    glare: true,
                    'max-glare': 0.3
                });
            }
        }
    }

    // ==================== SMOOTH SCROLL ====================
    function initializeSmoothScroll() {
        // Smooth scroll for anchor links
        $('a[href^="#"]').on('click', function (e) {
            const target = $(this.getAttribute('href'));
            if (target.length) {
                e.preventDefault();
                $('html, body').stop().animate({
                    scrollTop: target.offset().top - 80
                }, 1000, 'easeInOutExpo');
            }
        });
    }

    // ==================== SCROLL PROGRESS BAR ====================
    function initializeScrollProgress() {
        if ($('.scroll-progress').length === 0) {
            $('body').prepend('<div class="scroll-progress"></div>');
        }

        $(window).on('scroll', function () {
            const scrollTop = $(window).scrollTop();
            const docHeight = $(document).height();
            const winHeight = $(window).height();
            const scrollPercent = (scrollTop / (docHeight - winHeight)) * 100;
            $('.scroll-progress').css('width', scrollPercent + '%');
        });
    }

    // ==================== ENHANCE EXISTING ELEMENTS ====================
    function enhanceExistingElements() {
        // Add glass effect to specific cards
        $('.wt-icon-box-wraper.bg-white').addClass('glass shine-effect');

        // Add 3D hover to product/service cards
        $('.hover-box-effect').addClass('hover-3d');

        // Add icon animations
        $('.icon-lg, .icon-md').addClass('icon-pulse');

        // Make buttons more interactive
        $('.site-button, .site-button-secondry').each(function () {
            $(this).addClass('shine-effect');
        });

        // Add parallax to background sections
        $('.bg-cover, .bg-center').each(function () {
            if ($(this).css('background-image') !== 'none') {
                $(this).addClass('parallax-section');
            }
        });

        // Add lightbox to carousel images
        $('.welcome-carousel-1 img').each(function () {
            const $link = $(this).parent('a');
            if ($link.length && !$link.hasClass('glightbox')) {
                $link.addClass('glightbox');
                $link.attr('data-gallery', 'welcome-gallery');
            }
        });
    }

    // ==================== HOVER EFFECTS ====================
    function initializeHoverEffects() {
        // Icon rotation on hover
        $('.icon-cell').parent().addClass('icon-rotate-hover');

        // Card lift effect enhancement
        $('.wt-icon-box-wraper').hover(
            function () {
                $(this).find('.icon-cell i').css('transform', 'scale(1.2)');
            },
            function () {
                $(this).find('.icon-cell i').css('transform', 'scale(1)');
            }
        );
    }

    // ==================== SCROLL INDICATOR ====================
    function addScrollIndicator() {
        // Add scroll indicator to hero section
        if ($('.slider-block').first().length) {
            const indicator = `
                <div class="scroll-indicator">
                    <i class="fa fa-angle-double-down"></i>
                </div>
            `;
            $('#rev_slider_26_1_wrapper').append(indicator);

            // Hide indicator on scroll
            $(window).on('scroll', function () {
                if ($(window).scrollTop() > 100) {
                    $('.scroll-indicator').fadeOut();
                } else {
                    $('.scroll-indicator').fadeIn();
                }
            });
        }
    }

    // ==================== FAB INTERACTIONS ====================
    $('.fab-button').on('click', function (e) {
        e.preventDefault();
        $(this).parent().toggleClass('active');
    });

    // Close FAB when clicking outside
    $(document).on('click', function (e) {
        if (!$(e.target).closest('.fab-wrapper').length) {
            $('.fab-wrapper').removeClass('active');
        }
    });

    // ==================== PARALLAX SCROLL EFFECT ====================
    $(window).on('scroll', function () {
        const scrolled = $(window).scrollTop();

        // Parallax for hero slider
        $('.rev-slidebg').each(function () {
            const speed = 0.5;
            $(this).css('transform', 'translateY(' + (scrolled * speed) + 'px)');
        });
    });

    // ==================== CUSTOM CURSOR (Optional) ====================
    function initializeCustomCursor() {
        if ($('.custom-cursor').length === 0) {
            $('body').append('<div class="custom-cursor"></div>');
        }

        $(document).on('mousemove', function (e) {
            $('.custom-cursor').css({
                left: e.clientX + 'px',
                top: e.clientY + 'px'
            });
        });

        $('a, button, .site-button, .site-button-link').hover(
            function () {
                $('.custom-cursor').addClass('expand');
            },
            function () {
                $('.custom-cursor').removeClass('expand');
            }
        );
    }

    // Initialize custom cursor (uncomment if desired)
    // initializeCustomCursor();

    // ==================== SECTION ANIMATIONS ====================
    // Stagger animations for list items
    if (typeof AOS !== 'undefined') {
        $('.wt-icon-box-wraper').each(function (index) {
            $(this).attr('data-aos', 'fade-up');
            $(this).attr('data-aos-delay', (index * 100));
        });

        // Refresh AOS
        AOS.refresh();
    }

    // ==================== MOBILE MENU ENHANCEMENTS ====================
    $(window).on('scroll', function () {
        if ($(window).scrollTop() > 100) {
            $('.header-nav').addClass('sticky');
        } else {
            $('.header-nav').removeClass('sticky');
        }
    });

    // ==================== IMAGE LAZY LOADING ====================
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver(function (entries, observer) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('lazy');
                    imageObserver.unobserve(img);
                }
            });
        });

        document.querySelectorAll('img.lazy').forEach(function (img) {
            imageObserver.observe(img);
        });
    }

    // ==================== PERFORMANCE OPTIMIZATION ====================
    // Debounce scroll events
    let scrollTimeout;
    $(window).on('scroll', function () {
        if (scrollTimeout) {
            clearTimeout(scrollTimeout);
        }
        scrollTimeout = setTimeout(function () {
            // Add any heavy scroll operations here
        }, 100);
    });

    // ==================== ANALYTICS & TRACKING ====================
    // Track FAB interactions
    $('.fab-option').on('click', function () {
        const action = $(this).hasClass('whatsapp') ? 'WhatsApp' :
            $(this).hasClass('email') ? 'Email' : 'Phone';
        console.log('FAB Action:', action);
        // Add Google Analytics or other tracking here
    });

})(jQuery);

// ==================== VANILLA JS ENHANCEMENTS ====================
document.addEventListener('DOMContentLoaded', function () {

    // Add loading screen if not exists
    if (!document.querySelector('.loading-screen')) {
        const loadingScreen = document.createElement('div');
        loadingScreen.className = 'loading-screen';
        loadingScreen.innerHTML = '<div class="loading-logo"><img src="images/logo.png" alt="Pak Gusu Loading"></div>';
        document.body.prepend(loadingScreen);
    }

    // Prevent FOUC (Flash of Unstyled Content)
    document.body.style.opacity = '1';

    // Console branding
    console.log('%c Pak Gusu Cleanroom Solutions ', 'background: #FF6B35; color: white; font-size: 16px; padding: 10px;');
    console.log('%c Website Enhanced by Modern UI/UX ', 'background: #333; color: white; font-size: 12px; padding: 5px;');
});
