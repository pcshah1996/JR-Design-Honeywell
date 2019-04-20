**_Current Release: 1.0_**

Note: new release notes will be appended to the top of this file and the above `Current Release` badge will be updated.

## Release 1.0
* New Features
    * Support for login system
    * Support for saving frequently used drone information
    * Support for creating flight plan, including:
        * Selecting which drone to fly with
        * Selecting what times to fly during
        * Selecting which regions to fly in
        * 2D drawing for flight plan
        * Cycle view to see past drawn polygons
        * GeoJSON Exporting
    * Support for viewing pending and approved flight plans
    * Support for viewing current restrictions on a map
* Bug Fixes
    * None, this is first release
* Known Defects
    * System has not been connected to an external server for:
        * Push notification service (boilerplate is completed)
        * Login auth (boilerplate is completed)
        * Flightplan validation (boilerplate is completed)
        * Current airspace restrictions (boilerplace is completed)
    * Flight region polygons are unable to be moved or altitude adjusted after they are created
