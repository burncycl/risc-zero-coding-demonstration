## 2022/10 Michael Grate

## Summary of project from Original README.md

Objective:

Your assignment is to build a terraform configuration that sets up hosting
for the provided index.html file.

- Implement a terraform configuration to create the required infrastructure on AWS.
- Use terraform to 'deploy' the index.html ( application ) on the AWS infrastructure.
- Ensure that the application can only be accessed from: 3.121.56.176

Requirements:
- Terraform best practices.
- Choice of infrastructure
- Completeness: did you complete the features?
- Correctness: does the functionality act in sensible, thought-out ways?
- Maintainability: is it written in a clean, maintainable way?


## Best Practices Employed

- Docker is Entrypoint for work. Because it always "works on my machine". But, the next poor dev doesn't have your machine! We'll use Docker to help eliminate this issue.

## Getting Started

### Prerequisites

Install Docker on your Platform

- [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/)
- [Install Docker Desktop on Mac](https://docs.docker.com/desktop/install/mac-install/)
- [Install Docker Desktop on Linux](https://docs.docker.com/desktop/install/linux-install/)
- [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

Can Search for your specific Platform and `Docker Install` to get more clear references

Once Docker is installed, to instaitate the Dockerized local development environment use
```
docker build -t aws-deploy-ipcted:latest .
```
