I built a mini DevSecOps pipeline to demonstrate how security can be integrated into the software delivery lifecycle instead of being treated as a final checklist.

The project includes:

- Secrets scanning with Gitleaks
- Static code analysis with CodeQL
- Dependency and filesystem scanning with Trivy
- Infrastructure-as-Code and Kubernetes scanning
- Docker image vulnerability scanning
- OWASP ZAP baseline DAST scan
- Security gates that fail the build on high/critical findings
- SBOM generation and security reporting

I also added an intentional vulnerability, captured the finding, remediated it, and documented the before/after result.

This helped me better understand how DevSecOps connects secure coding, CI/CD automation, container security, and continuous feedback for developers.

GitHub repo: [add link]
