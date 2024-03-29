# [Firefighter](https://github.com/VarunSAthreya/Firefighter/releases/download/release/firefighter.apk)

Firefighter inventory management and service app created for the hackathon [Hackwell2.0](https://www.jsshackwell.in/). Which was a 48 hour hackathon organized by [JSSATEB](https://www.jssateb.ac.in/) and [Honeywell India](https://www.honeywell.com/in/en), conducted on <code>2<sup>nd</sup> June 2021</code> to <code>4<sup>th</sup> June 2021</code>.
This project was selected as one of the [top 10 projects](https://www.linkedin.com/posts/varunsathreya_certificate-activity-6809581904493465600-Jq3l/) of the hackathon (One of the only 2 solo participants in top 10 teams).
Head to the [release](https://github.com/VarunSAthreya/Firefighter/releases/tag/release) section to download the [app](https://github.com/VarunSAthreya/Firefighter/releases/download/release/firefighter.apk).

## Problem Statement

- Fire extinguisher are maintained manually with paper tag for each fire extinguisher cylinder
- Can’t predict how many cylinders/equipment needs to be replace
- Don’t have report facility, mostly on papers with bare minimum insights
- Don’t have digital maintenance record

## App Demo

- Adding a `site` for asset management

    <img src="./assets/demo/add_site.gif" alt="Demo video" height="20%" width="20%"/>

- Adding a `asset` for service and management.

    <img src="./assets/demo/add_asset.gif" alt="Demo video" height="20%" width="20%"/>

- Scanning auto generated QR code for all `asset` and to start and finish servicing it.

    <img src="./assets/demo/scanning_qr_and_servicing.gif" alt="Demo video" height="20%" width="20%"/>

- Adding a `report` for an `asset` in a `site` and assigning a `site engineer` to it.

    <img src="./assets/demo/add_report.gif" alt="Demo video" height="20%" width="20%"/>

## Technology Stack

- Frontend: [Flutter](https://flutter.dev/)(with sound null safety).
- State management: [RiverPod](https://pub.dev/packages/riverpod) and [FlutterHooks](https://pub.dev/packages/flutter_hooks).
- Backend: [Firebase](https://firebase.google.com/)
- Database: [Cloud Firestore](https://firebase.google.com/docs/firestore)
- Storage: [Firebase Cloud Storage](https://firebase.google.com/products/storage)
- Location: [Google Maps](https://developers.google.com/maps)

## Getting Started

A complete guide for getting started is given **[here](https://github.com/VarunSAthreya/Firefighter/blob/main/CONTRIBUTING.md)**.

## Features Implemented

- `Email` authentication.
- Three user types: `Admin`, `Site Engineer`, `End User`. All integrated in the same app.
- Specific features only available for specific type of user.
- Integrated `Google Maps API` for `site's` location.
- CRUD operations of `site`, `asset`, ans `report`.
- Implemented `serice` feature to `asset` by uploading before and after `image` of the asset.
