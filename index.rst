:html_theme.sidebar_primary.remove: true
:html_theme.sidebar_secondary.remove: true

.. toctree::
    :hidden:

    overview
    user_guide/index
    containers/index
    utils/index
    contributing

.. raw:: html

   <style>
     .mux-hero {
       text-align: center;
       max-width: 46rem;
       margin: 1.5rem auto 3.5rem auto;
       padding: 0 1rem;
     }
     .mux-hero__logo {
       width: clamp(11rem, 30vw, 18rem);
       height: auto;
       margin: 0 auto 1.5rem auto;
       display: block;
     }
     .mux-hero__tagline {
       font-size: clamp(1.1rem, 2.2vw, 1.4rem);
       line-height: 1.45;
       color: var(--pst-color-text-base);
       margin: 0 auto 1rem auto;
       max-width: 34rem;
     }
     .mux-hero__sub {
       font-size: 1rem;
       line-height: 1.6;
       color: var(--pst-color-text-muted);
       margin: 0 auto;
       max-width: 36rem;
     }
   </style>

   <div class="mux-hero">
     <img src="_static/logo/mux_light.svg" alt="mux"
          class="mux-hero__logo only-light" />
     <img src="_static/logo/mux_dark.svg" alt="mux"
          class="mux-hero__logo only-dark" />
     <p class="mux-hero__tagline">
       Web-based hardware control for adaptive optics and astronomy
     </p>
     <p class="mux-hero__sub">
       mux is a containerized software stack that exposes instrument hardware through
       web-based APIs. It handles the plumbing between hardware and the web, and pairs
       those endpoints with ready-made React components, so building an instrument 
       interface means assembling building blocks instead of starting from scratch.
     </p>
   </div>

.. grid:: 1 2 3 3
   :gutter: 3
   :class-container: sd-text-center

   .. grid-item-card:: Overview
      :link: overview
      :link-type: doc

      What mux is, the design philosophy behind it, and how the pieces fit
      together into a working system.

   .. grid-item-card:: User Guide
      :link: user_guide/index
      :link-type: doc

      How to architect a system using mux, build an integrated interface, 
      configure a host, and deploy containers.

   .. grid-item-card:: Containers
      :link: containers/index
      :link-type: doc

      Container reference: what they do, how to build and configure them, 
      and the endpoints they expose.

   .. grid-item-card:: Utilities
      :link: utils/index
      :link-type: doc

      Supporting libraries, simulators, and developer tooling that surround the
      core stack.

   .. grid-item-card:: Contributing
      :link: contributing
      :link-type: doc

      Getitng help, extending mux, and creating new containers.
