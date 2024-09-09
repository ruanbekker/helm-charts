# Changelog

All notable changes to the charts in this Helm repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Released]

### Bitcoin Chart

- [1.5.0]() - Adds `podAnnotations`
- Initial release

### Common Chart

- [4.0.0]() - Adds pdb and topology key constraints.
- [2.0.0]() - Adds pvc and statefulset support.
- [1.0.0]() - Initial release.

### Litecoin Chart

- [1.5.0]() - Adds `podAnnotations`
- Initial release

### Dogecoin Chart

- [1.5.0]() - Adds `podAnnotations`
- Initial release

### Microservice Chart

- Initial release

## [0.1.0] - 2024-02-28

### Added

- **Bitcoin Chart:** Initial chart version with basic deployment, service, and ingress configurations.
- **Litecoin Chart:** Initial chart version, similar to Bitcoin chart, adjusted for Litecoin specific configurations.
- **Microservice Chart:** Basic microservice application chart including deployment, service, secret management, and optional ingress.

### Changed

- **Bitcoin Chart:** Updated image version to 2.0, improved security settings.
- **Litecoin Chart:** Adjusted resource limits for better performance.

### Fixed

- **Microservice Chart:** Fixed a bug in the service definition that prevented proper external access.

### Deprecated

- **Bitcoin Chart:** Deprecated old securityContext settings in favor of new, more secure configurations.

### Removed

- **Litecoin Chart:** Removed unsupported configuration options related to legacy networking.

### Security

- **Microservice Chart:** None.

## [0.0.1] - 2024-02-14

### Added

- Initial setup of the Helm repository with placeholder charts for Bitcoin, Litecoin, and Microservice applications.

