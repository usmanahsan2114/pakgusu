# Comprehensive script to update all pages with content from info.md

# Update Products Pages
$productPages = @{
    'products/windows/index.html' = @{
        title = 'Cleanroom Windows | Flush, Double-Glazed Vision Panels - Pak Gusu'
        description = 'Flush cleanroom windows from Pak Gusu provide clear visibility and smooth, easy-to-clean surfaces, designed to integrate seamlessly with cleanroom panels.'
        h1 = 'Cleanroom Windows'
        intro = 'Pak Gusu supplies **flush, double-glazed cleanroom windows** that integrate seamlessly into our panel systems. Based on Gusu's cleanroom window concepts, the frames are designed for airtightness and easy cleaning.'
        features = @('Double-glazed glass with sealed perimeter', 'Flush with the wall surface – no dust-collecting ledges', 'Silicone-sealed joints to avoid air leakage and particle accumulation', 'Compatible with panel thicknesses used in Pharmaceutical and healthcare facilities')
        benefits = @('Improved visibility between rooms and corridors', 'Enhanced supervision and safety', 'Clean, modern aesthetic that supports GMP inspections')
    }
    'products/doors/index.html' = @{
        title = 'Cleanroom Doors | Single & Double-Leaf Cleanroom Doors - Pak Gusu'
        description = 'Pak Gusu offers cleanroom doors for Pharmaceutical, hospital and food projects, designed for air-tightness, durability and integration with cleanroom panels.'
        h1 = 'Cleanroom Doors'
        intro = 'Our cleanroom doors are designed around Gusu's door systems to offer durable, airtight access solutions for clean environments.'
        features = @('Single or double-leaf swing doors', 'Options for observation windows (double-glazed)', 'Hardware in stainless steel or cleanroom-compatible finishes', 'Provision for electromechanical locks and access control (if required)')
        design = @('Door frames integrated with panel systems for a flush finish', 'Gaskets and seals to maintain pressure differentials', 'Compatibility with interlock systems in high-critical airlocks')
    }
    'products/transfer-window/index.html' = @{
        title = 'Transfer Windows / Pass Boxes | Material Transfer for Cleanrooms - Pak Gusu'
        description = 'Pak Gusu provides cleanroom transfer windows and pass boxes for safe, low-contamination transfer of materials between rooms and areas.'
        h1 = 'Transfer Windows / Pass Boxes'
        intro = 'Transfer windows (pass boxes) are used to move materials in and out of cleanrooms while minimising cross-contamination. Pak Gusu supplies pass box designs aligned with Gusu's dynamic and static pass box concepts.'
        types = @('**Static pass box** – For transfers between areas with similar cleanliness levels.', '**Dynamic pass box** – Integrated fan-filter unit (FFU) and HEPA filtration for transfers between areas of different cleanliness grades.')
        features = @('Robust steel body with smooth internal corners', 'Interlocking doors to prevent simultaneous opening', 'Viewing windows to observe transfer', 'Optional UV lamps or other project-specific add-ons')
    }
    'products/aluminum-profile/index.html' = @{
        title = 'Aluminium Profiles & Accessories | Cleanroom Trims & Corners - Pak Gusu'
        description = 'Pak Gusu supplies aluminium profiles and accessories for cleanroom panel joints, corners and ceiling interfaces, ensuring a fully sealed and hygienic envelope.'
        h1 = 'Aluminium Profiles & Accessories'
        intro = 'Aluminium profiles are critical for sealing joints between panels, ceilings, doors and windows. Pak Gusu provides a range of extrusions and accessories equivalent to Gusu's aluminium accessories portfolio.'
        items = @('Internal and external corner profiles', 'Floor and ceiling connection profiles', 'U-channels and H-profiles for panel joints', 'Cover strips and finishing trims')
        benefits = @('Clean, rounded edges and smooth transitions', 'Easy to clean and maintain', 'Improved structural stability at joints', 'Consistent finish across the entire cleanroom envelope')
    }
    'products/clean-led-lights/index.html' = @{
        title = 'Cleanroom LED Lights | Energy-Efficient, Flush-Mounted Lighting - Pak Gusu'
        description = 'Cleanroom LED lights from Pak Gusu provide high light output, low energy consumption and dust-free integration into cleanroom ceilings.'
        h1 = 'Cleanroom LED Lights'
        intro = 'Pak Gusu offers cleanroom-grade LED light panels based on Gusu's LED light solutions for cleanrooms. These fixtures are designed to mount flush with ceilings and provide uniform illumination.'
        features = @('Flat, flush-mounted panels that minimise dust traps', 'High lumen output with low power consumption', 'Long LED life and reduced maintenance', 'Suitable for use in GMP-regulated and ISO-classified areas')
    }
}

# Update Services Pages
$servicePages = @{
    'services/index.html' = @{
        title = 'Cleanroom Services | Design, Construction, Installation & Support - Pak Gusu'
        description = 'Pak Gusu supports clients through every stage of cleanroom development – planning and design, cleanroom construction, installation and after-sales services.'
        h1 = 'Cleanroom Services'
        intro = 'Pak Gusu is more than a product supplier – we act as a project partner throughout the life cycle of your cleanroom.'
        services = @('**Planning & Design** – GMP and layout consultancy', '**Cleanroom Construction** – Panel and envelope construction', '**Installation** – On-site installation and supervision', '**After-Sales Services** – Adjustments, expansions and technical support')
    }
    'services/planning-and-design/index.html' = @{
        title = 'Cleanroom Planning & Design | GMP Layout & Engineering Support - Pak Gusu'
        description = 'Pak Gusu provides cleanroom planning and design services, including GMP layout, panel design, HVAC coordination and detailed 2D drawings.'
        h1 = 'Planning & Design'
        intro = 'Every successful cleanroom project starts with a robust design. Pak Gusu offers front-end planning and design services that bring your process requirements, regulatory obligations and site constraints together in a practical layout.'
        whatWeDo = @('**GMP Layout Design** – We prepare room zoning, material/people flows and basic pressure cascades in line with GMP guidelines.', '**Panel & Ceiling Design** – Selection of appropriate panel types, thicknesses and ceiling systems to achieve the desired classification and fire performance.', '**HVAC & Machine Layout Coordination** – We coordinate with your HVAC and process equipment vendors to reflect air-handling, ducting and equipment footprints on drawings.')
        deliverables = @('2D drawings developed in AutoCAD for clear, shareable documentation', 'Layouts that can be used for internal approvals, budgeting and qualification documentation', 'Concept-level guidance even at early project stages')
    }
    'services/clean-room-construction/index.html' = @{
        title = 'Cleanroom Construction | Panel & Envelope Build - Pak Gusu'
        description = 'Pak Gusu manages cleanroom envelope construction using locally manufactured panels, doors and windows, working closely with your project and HVAC teams.'
        h1 = 'Cleanroom Construction'
        intro = 'Once the design is finalised, Pak Gusu coordinates the construction of the cleanroom envelope, working with your civil and MEP teams.'
        scope = @('Supply of panels, doors, windows, transfer windows and aluminium accessories', 'Deployment of installation teams and supervisors', 'Coordination with civil and HVAC contractors on sequencing and interfaces', 'Implementation of pressure cascades and zoning as per design')
        focus = @('Clean, aligned panel joints and corners', 'Proper sealing at floor, ceiling and wall connections', 'Integration of service cut-outs, FFUs/HEPAs and filters where required')
    }
    'services/installation/index.html' = @{
        title = 'Installation Services | On-Site Cleanroom Installation - Pak Gusu'
        description = 'Pak Gusu offers on-site cleanroom installation services, ensuring that panels, doors, windows and accessories are installed to specification and ready for qualification.'
        h1 = 'Cleanroom Installation'
        intro = 'A good product needs correct installation to perform as designed. Pak Gusu provides experienced technicians and site supervisors to:'
        services = @('Install wall and ceiling panels', 'Fit doors, windows and pass boxes', 'Apply aluminium profiles, gaskets and sealants', 'Check alignment, door operation and basic air-tightness')
        note = 'We align our work with your project schedule to minimise downtime and rework.'
    }
    'services/after-sale-services/index.html' = @{
        title = 'After-Sales Services | Cleanroom Modification & Support - Pak Gusu'
        description = 'Pak Gusu supports clients after handover with cleanroom maintenance, modifications, expansions and technical assistance.'
        h1 = 'After-Sales Services'
        intro = 'Cleanroom needs change over time – new products, new equipment, or regulatory updates can all require modifications.'
        services = @('Adjust or relocate panels and doors', 'Add new openings, windows or transfer hatches', 'Expand existing cleanroom areas with compatible panels and accessories', 'Provide technical advice when planning process changes')
        note = 'Our local presence in Pakistan ensures quicker response times compared to purely imported solutions.'
    }
}

# Update Sectors Pages
$sectorPages = @{
    'sectors/index.html' = @{
        title = 'Sectors We Serve | Cleanroom Solutions for Multiple Industries - Pak Gusu'
        description = 'Pak Gusu provides cleanroom solutions for Pharmaceutical, Nutraceutical, Hospitals, Food industry, Electronics, Laboratories and Medical device manufacturing.'
        h1 = 'Sectors We Serve'
        intro = 'Pak Gusu's cleanroom envelopes and accessories are used across a wide range of applications in Pakistan, including:'
        sectors = @('Pharmaceutical / Nutraceutical', 'Hospitals', 'Food Industry', 'Electronics', 'Laboratories', 'Medical / Surgical Devices')
    }
    'sectors/pharmaceutical-nutraceutical/index.html' = @{
        title = 'Pharmaceutical & Nutraceutical Cleanrooms - Pak Gusu'
        description = 'Pak Gusu designs and supplies cleanroom envelopes for Pharmaceutical and Nutraceutical plants, aligned with GMP and regulatory expectations in Pakistan.'
        h1 = 'Pharmaceutical & Nutraceutical'
        intro = 'We support solid dosage, liquid, injectable and nutraceutical facilities with:'
        features = @('GMP-based zoning and flow planning', 'Panels, doors and windows suitable for classified areas (ISO 5–8)', 'Integration of pass boxes for material transfer')
        note = 'Our systems are suitable for production, packaging, QC labs, stability rooms and supporting areas.'
    }
    'sectors/hospital/index.html' = @{
        title = 'Hospital & Healthcare Cleanrooms - Pak Gusu'
        description = 'Pak Gusu provides cleanroom envelopes for operating rooms, critical care units and specialised hospital departments requiring controlled environments.'
        h1 = 'Hospitals & Healthcare'
        intro = 'Hospitals require controlled environments for:'
        areas = @('Operating theatres and procedure rooms', 'ICUs, NICUs and isolation rooms', 'CSSD and sterile stores')
        note = 'Pak Gusu's partnership with Gusu – a drafting unit for hospital clean operating department standards in China – allows us to translate proven design concepts into the Pakistani context.'
    }
    'sectors/food-industry/index.html' = @{
        title = 'Food Industry Cleanrooms - Pak Gusu'
        description = 'Pak Gusu delivers cleanroom and hygienic envelope solutions for food and beverage manufacturing, packaging and cold-chain facilities.'
        h1 = 'Food Industry'
        intro = 'In food processing, controlled environments help reduce contamination, extend shelf life and support audits by local and export regulators.'
        features = @('Cleanable wall and ceiling systems with smooth finishes', 'Doors and windows resistant to wash-down protocols', 'Integration with temperature-controlled and cold rooms')
        applications = 'Applications include processing halls, filling and packaging rooms, high-care zones and R&D test kitchens.'
    }
    'sectors/electronics/index.html' = @{
        title = 'Electronics & Assembly Cleanrooms - Pak Gusu'
        description = 'Pak Gusu supplies cleanroom envelopes suitable for electronics, semiconductor and precision assembly applications.'
        h1 = 'Electronics & Precision Assembly'
        intro = 'Electronics and precision assembly lines often require low-particle, controlled environments to protect components and ensure product quality.'
        note = 'Working with Gusu's experience in **electronics and semiconductor cleanrooms**, we can provide panel and envelope systems suitable for:'
        applications = @('PCB assembly and testing', 'Cable, optical fibre and device assembly', 'Precision instrument manufacturing')
    }
    'sectors/laboratories/index.html' = @{
        title = 'Laboratory Cleanrooms - Pak Gusu'
        description = 'Pak Gusu supports QC, R&D and biosafety laboratories with cleanroom envelopes that integrate with laboratory equipment and safety requirements.'
        h1 = 'Laboratories'
        intro = 'Pak Gusu's solutions can be configured for:'
        types = @('QC and analytical laboratories', 'Microbiology labs', 'Biosafety laboratories')
        note = 'We design envelopes compatible with laminar flow cabinets, biosafety cabinets and other specialised equipment, drawing on Gusu's experience with laboratory cleanrooms and biosafety facilities.'
    }
    'sectors/medical-surgical-devices/index.html' = @{
        title = 'Medical & Surgical Device Cleanrooms - Pak Gusu'
        description = 'Cleanroom panels and accessories from Pak Gusu support ISO-class production for medical and surgical devices, from plastics to implants and disposables.'
        h1 = 'Medical & Surgical Devices'
        intro = 'Device manufacturing often requires ISO-classified assembly and packaging areas. Pak Gusu provides:'
        features = @('Panel systems compatible with device manufacturing lines', 'Cleanroom doors, windows and transfer hatches for material and product flow', 'Integration with HVAC and filtration solutions to achieve ISO classes required by product and regulatory standards')
    }
}

# Update About Pages
$aboutPages = @{
    'about/about-pak-gusu/index.html' = @{
        title = 'About Pak Gusu | Pakistan's Local Cleanroom Manufacturer'
        description = 'Learn how Pak Gusu brought GUSU China's cleanroom technology to Pakistan, establishing a local manufacturing facility for cleanroom panels and accessories in Lahore.'
        h1 = 'About Pak Gusu'
        intro = 'Cleanrooms are now an essential requirement across **Pharmaceutical, Nutraceutical, Hospital, Laboratory and Food industries**. For many years, Pakistani manufacturers had no local option: every cleanroom system had to be imported, with challenges such as customs duties, long lead times, installation coordination and after-sales support.'
        story = 'Pak Gusu Technology (Pvt.) Ltd. was created to solve this gap.'
        timeline = @('In **2017**, Pak Gusu signed a technical collaboration agreement with **Jiangsu Gusu Purification Technology Co. Ltd. (China)**, one of China's leading cleanroom manufacturers.', 'In **2018**, we established our production site at **8-km, Sundar–Raiwind Road, Lahore** and installed complete panel production machinery imported from China.', 'By **2019**, our plant began commercial production of cleanroom panels, serving Pharmaceutical and related industries across Pakistan.')
        bringToPakistan = @('**Imported expertise, local manufacturing** – We bring more than two decades of Gusu's R&D, engineering and project experience into the Pakistani market, while manufacturing the envelope locally.', '**One-roof solution** – Pak Gusu can support GMP cleanroom projects from: Basic concept and GMP layout review, Cleanroom envelope & panel design, Coordination for HVAC layout and machine positioning, On-site installation of panels, doors, windows and accessories')
        team = @('Pharmaceutical production and validation experience', 'Mechanical and electrical engineers', 'Production and quality technicians', 'Procurement, sales and project coordination specialists')
        teamNote = 'This blend allows us to understand both the compliance side (GMP, ISO) and the practical constraints on Pakistani sites.'
    }
    'about/about-gusu-china/index.html' = @{
        title = 'About GUSU China | Pak Gusu's Technology Partner'
        description = 'Discover Jiangsu Gusu Purification Technology, Pak Gusu's Chinese partner and a nationally recognised leader in cleanroom design and construction.'
        h1 = 'About GUSU China'
        intro = 'Pak Gusu sources its cleanroom technology, designs and key components from **Jiangsu Gusu Purification Technology Co. Ltd.**, China – a company recognised as a leading provider of integrated cleanroom system solutions.'
        leader = @('A drafting unit for key national standards on cleanroom construction and hospital clean operating departments.', 'Certified with **ISO 9001**, **ISO 14001** and **OHSAS 18001** management systems.', 'Licensed as a national Grade II enterprise for air purification, building MEP, intelligent engineering, and interior decoration projects.')
        experience = 'Over **20+ years**, Gusu has delivered more than **1,000 cleanroom system projects** across China and over **30 countries**, covering approximately **1.5 million m²** of cleanroom area.'
        industries = @('Biopharmaceutical and life sciences', 'Electronics and semiconductor manufacturing', 'Medical & healthcare facilities, including clean operating rooms', 'Food, cosmetics and optical cable industries', 'Research laboratories and education institutions')
        note = 'By partnering with Gusu, Pak Gusu brings this experience and standardisation into Pakistan while remaining accessible and responsive as a local manufacturer.'
    }
    'about/cleanroom-classifications/index.html' = @{
        title = 'Cleanroom Classifications | ISO & GMP Cleanroom Standards - Pak Gusu'
        description = 'Understand how cleanrooms are classified (ISO 14644, FS 209E), what the classes mean, and how Pak Gusu designs cleanroom envelopes to help meet your required class.'
        h1 = 'Cleanroom Classifications'
        intro = 'Cleanrooms are controlled environments where airborne particles, temperature, humidity and pressure are regulated to strict limits. The "class" of a cleanroom indicates the maximum allowable concentration of particles in the air.'
        standards = @('**Federal Standard 209E (US)** – Defines cleanroom classes (e.g. Class 100, Class 10,000) based on the maximum number of particles ≥ 0.5 µm per cubic foot of air.', '**ISO 14644-1** – The current international standard, which defines classes (ISO 1 to ISO 9) based on particle counts per cubic meter for various particle sizes.')
        classes = @('**ISO 5–6 / Class 100–1,000**: High-critical areas like filling lines, sterile manufacturing zones, some laboratories.', '**ISO 7–8 / Class 10,000–100,000**: Support areas, preparation rooms, packaging, and less critical processing zones.')
        dependsOn = @('Product type (solid dosage, sterile, parenteral, food, medical devices, etc.)', 'Regulatory guidelines (GMP, local DRAP requirements, hospital regulations)', 'Process steps and contamination risk')
        howWeHelp = @('Define zones and pressure cascades based on your GMP concept.', 'Select appropriate wall and ceiling panels (Rockwool, PU, XPS) and finishes.', 'Plan door and window configurations and transfer hatches to minimise cross-contamination.', 'Support you with layout drawings that can be used for risk assessment and qualification')
    }
}

Write-Host "Content update script created. Ready to process files."

