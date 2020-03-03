# Add Servers Programming Test

## Background

This app is a sample implementation per the requirements to show how a simple app can connect to a server and optionally provide credentials using a mock Networking Layer.

## Clarifications

There is a discrepancy between the requirements document and the mock Networking layer because the IP addresses are different and one of the addresses is an invalid IP address.  We assume that this has been a simple oversight and typo.

The following are instead being used as the IP addresses of the server:

Type of Server | IP Address string
--- | ---
No Credentials Server | `192.168.0.10`
Require Credentials Server | `192.168.0.11`

## Running

This codebase is based upon Xcode 11.3.1 (11C504).
Target devices are from iPod Touch through to iPad Pro, and simulator equivalents.

In order to run the code, first change the code signing to be your own team. Click top folder "vaion" xcode project icon, then in the right panel, `Signing and Capabilities`, set your team for `Team`.

To automatically exercise the UI and run tests, use `Command+U`.  Otherwise to run interactively, use `Command+R`

## Test Coverage

The `Networking.swift` code wasn't unit tested as it is assumed that the rest of the class will be explored during a later session.  The remaining aspects of the code has Unit and User Interface testing in place.

## Design

This app was coded as if it were part of a substantial app even though the functionality it offers is limited and thus could be achieved with a simple use of view controllers.  That is because the project asks for how it would be constructed as a production quality implementation.  The architecture used is MVVM.

The user interface is somewhat plain, and slightly jerky at the end when it informs you of the connected server.  It would be straightforward to add polish to that using animations, etc., but this is outside the scope of the requirements.
