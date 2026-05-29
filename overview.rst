Overview
========

Introduction
------------

Mux is a containerized software stack for building web interfaces to adaptive
optics and astronomy instruments. It handles the plumbing between instrument
hardware — cameras, mechanisms (filter wheels, translation and tip/tilt stages,
fold mirrors, etc.), and other networked systems — and the scripts and services
that drive them. Each new instrument tends to grow its own tightly coupled
monolith of video streaming, status telemetry, command APIs, data recording,
and browser UIs. Mux instead provides independently deployable containers that
communicate over well-defined web protocols. A team picks the pieces it needs,
adds instrument-specific containers alongside, and assembles an interface from
ready-made parts rather than starting from scratch.

Containers and interfaces
-------------------------

The core of mux is a collection of containers. Each container exposes its
hardware over a web interface: HTTP for commands and data, WebSocket for status
and telemetry pushed to the browser, and WebRTC for live video. Everything a
client needs to operate the instrument is reachable over the web, and fully
specified, so you are never reverse-engineering a private protocol or linking
against a hardware SDK to talk to a device.

Because the contract is the interface and not any particular UI, you are free to
build whatever front end suits your instrument:

- **Use the bundled React components.** Mux ships a library of ready-made
  components — camera viewers, telemetry charts, control panels — that already
  speak the container endpoints. Building an interface becomes a matter of
  assembling and arranging building blocks.
- **Or write your own.** The same documented endpoints are available to any
  client. A team that wants a custom UI, a headless script, or integration
  with existing observatory software can target them directly and skip the
  component library entirely.

The components exist for convenience; the documented endpoints are what you
build on.

Architecture at a glance
------------------------

Mux runs as a small set of containers that together expose the instrument to
the browser and to other clients over web protocols. Where they run is a
deployment choice: on their own server, or on the same computer as a real-time
control loop when the instrument calls for it. Either way, mux stays off the
time-critical path. Latency-sensitive work, such as a real-time AO loop, keeps
running on whatever host owns it, while mux reads from it and exposes its data
to the web.

.. figure:: _static/architecture.svg
   :alt: Mux system architecture
   :align: center

   Clients reach mux over web protocols; mux containers run on a dedicated or
   shared host and connect to instrument hardware, servers, and other devices.

Within a deployment, containers are wired together by the same web protocols
they expose to clients, with shared memory carrying the high-rate image streams
between mux and the hardware that produces them. The full topology, the
containers that make up a running system, and the protocols they use are
detailed in the pages that follow.

Design philosophy
-----------------

- **Containerized.** Every component runs in a Podman container with explicit
  dependencies and configuration. Deployments are reproducible across
  development environments and production instrument servers.
- **Composable.** Containers communicate over network protocols, not shared
  process state. Any single container can be swapped — a different media
  server, a different message broker — without touching the rest of the stack.
- **Open.** Every interface is a documented web API. Nothing the system depends
  on is hidden behind an internal protocol, so clients of any kind can be
  built against it.
- **Reusable.** The core stack carries no assumptions about a specific
  instrument. The same containers are intended to move to the next instrument
  with configuration changes rather than code changes.

Next steps
----------

- :doc:`user_guide/index` — configure a host, build the images, and bring the
  full stack up from a cold start to a live UI.
- :doc:`containers/index` — reference for each container in a running
  instrument.
- :doc:`utils/index` — supporting libraries and tooling.
- :doc:`contributing` — extend mux, add a hardware container, or adapt the
  stack to your own instrument.
