<?php
$root = '../';
include($root . 'includes/head.php');
?>
<body class="footer-fixed">
    <div class="page-wraper">
        <?php include($root . 'includes/header.php'); ?>
        <!-- CONTENT START -->
        <!-- CONTENT START -->
        <div class="page-content">
        
            <!-- INNER PAGE BANNER -->
            <div class="wt-bnr-inr overlay-wraper bg-center" style="background-image:url(<?php echo $root; ?>images/banner/4.jpg);">
            	<div class="overlay-main bg-black opacity-07"></div>
                <div class="container">
                    <div class="wt-bnr-inr-entry">
                    	<div class="banner-title-outer">
                        	<div class="banner-title-name">
                        		<h2 class="text-white">Contact Us</h2>
                            </div>
                        </div>
                        <!-- BREADCRUMB ROW -->                            
                        
                            <div>
                                <ul class="wt-breadcrumb breadcrumb-style-2">
                                    <li><a href="<?php echo $root; ?>index.php">Home</a></li>
                                    <li>Contact Us</li>
                                </ul>
                            </div>
                        
                        <!-- BREADCRUMB ROW END -->                        
                    </div>
                </div>
            </div>
            <!-- INNER PAGE BANNER END -->
             
            <!-- SECTION CONTENTG START -->
            <div class="section-full small-device  p-tb80">
                <!-- LOCATION BLOCK-->
                <div class="container">
                    <div class="gmap-outline m-b80">
                        <div  class="google-map-gray google-map">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d387191.33750346623!2d-73.97968099999999!3d40.6974881!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c24fa5d33f083b%3A0xc80b8f06e177fe62!2sNew%20York%2C%20NY%2C%20USA!5e0!3m2!1sen!2sin!4v1671883239943!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
                    </div>
                </div>
                
                <div class="section-content m-b50">
					<div class="container">
                    
                        <!-- TITLE START -->
                        <div class="section-head text-center">
                            <div class="wt-separator-outer separator-center">
                                <div class="wt-separator">
                                    <span class="site-text-primary text-uppercase sep-line-one ">Trust and recommend</span>
                                </div>
                            </div>
                            <h2>Contact Us</h2>
                        </div>                                            
                        <!-- TITLE END -->                    
                    	<div class="row contact-info-section">
                            <div class="col-md-4 col-sm-12 m-b30">
                                <div class="wt-icon-box-wraper center p-lr30 p-tb50 bdr-1 bdr-gray">
                                    <div class="icon-md m-b10"><i class="flaticon-smartphone"></i></div>
                                    <div class="icon-content">
                                        <h4>Phone number</h4>
                                        <h5>+92 321 8073738</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-12 m-b30">
                                <div class="wt-icon-box-wraper center p-lr30 p-tb50  block-shadow">
                                    <div class="icon-md  m-b10"><i class="flaticon-email"></i></div>
                                    <div class="icon-content">
                                        <h4>Email address</h4>
                                        <h5>info@pakgusu.com</h5>
                                        <h5>pakgusu@gmail.com</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-12 m-b30">
                                <div class="wt-icon-box-wraper center p-lr30 p-tb50">
                                    <div class="icon-md	 m-b10"><i class="flaticon-placeholder"></i></div>
                                    <div class="icon-content">
                                        <h4>Address info</h4>
                                        <h5>8-km, Sundarâ€“Raiwind Road, Lahore, Pakistan</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
					</div>                    
                </div>                                  
                    <!-- GOOGLE MAP & CONTACT FORM -->
                <div class="section-content overlay-wraper ">
                    <div class="container">
                            <!-- TITLE START -->
                            <div class="section-head text-center">
                                <div class="wt-separator-outer separator-center">
                                    <div class="wt-separator">
                                        <span class="site-text-primary text-uppercase sep-line-one ">Contact Form</span>
                                    </div>
                                </div>
                                <h2>Get In Touch</h2>
                            </div>                                            
                            <!-- TITLE END -->                        
                            <form class="contact-form cons-contact-form" method="post" action="form-handler.php">
                                <div class="contact-one">
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6">
                                            <div class="form-group">
                                                <input name="username" type="text" required class="form-control" placeholder="Name">
                                                <span class="spin"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-sm-6">
                                            <div class="form-group">
                                                <input name="company" type="text" class="form-control" required placeholder="Company">
                                                <span class="spin"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-sm-6">
                                            <div class="form-group">
                                                <input name="email" type="email" class="form-control" required placeholder="Email">
                                                <span class="spin"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-sm-6">
                                            <div class="form-group">
                                                <input name="phone" type="tel" class="form-control" required placeholder="Phone">
                                                <span class="spin"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <input name="project_location" type="text" class="form-control" required placeholder="Project Location / City">
                                                <span class="spin"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-12"> 
                                            <div class="form-group">
                                                <textarea name="message" rows="4" class="form-control " required placeholder="Message (brief description of your cleanroom requirement)"></textarea>
                                                <span class="spin"></span>
                                            </div>
                                        </div>
                                        <div class="text-left col-md-12">
                                            <button name="submit" type="submit" value="Submit" class="site-button site-btn-effect">
                                                    Submit
                                            </button>
                                        </div>
                                    </div>
                               </div>     
                            </form>
                    </div>
               </div>
         
            <!-- SECTION CONTENT END -->
            
            </div>
        <!-- CONTENT END -->
		</div>
        <!-- CONTENT END -->
        <?php include($root . 'includes/footer.php'); ?>
    </div>
    <?php include($root . 'includes/scripts.php'); ?>
</body>
</html>
