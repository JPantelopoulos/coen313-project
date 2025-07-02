# COEN 313 Digital Design Project

## Goal  

The goal of this project was to design a digital system capable of tracking and monitoring the occupancy of a room.  
## Minimum Requirements  
The room has one entrance and one exit, each equipped with a photocell that generates a binary signal; any obstruction triggers a change in that signal. The system must have a programmable maximum occupancy threshold, adjustable via an eight-bit input. When this threshold is reached, the system should assert a `max_capacity` signal to indicate that the room has reached full capacity and that no additional entries are permitted until space becomes available. Additionally, when a reset signal is activated, the system must return to its initial state and resume occupancy tracking.
