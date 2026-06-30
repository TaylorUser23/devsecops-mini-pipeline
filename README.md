# DevSecOps Mini Pipeline

A portfolio-ready DevSecOps project that secures a small containerized web application through an automated CI/CD pipeline.

## Project Overview

This project demonstrates how security controls can be embedded into the software delivery lifecycle. The pipeline runs tests and multiple security scans before building and validating a Docker image.

## Tech Stack

- Node.js and Express
- Docker
- GitHub Actions
- Gitleaks for secrets scanning
- CodeQL for static code analysis
- Trivy for dependency, filesystem, container, and IaC scanning
- OWASP ZAP for baseline dynamic application security testing
- Kubernetes YAML for configuration scanning practice
- Terraform for IaC scanning practice

## Architecture

```text
Developer
   |
   v
GitHub Pull Request
   |
   v
GitHub Actions CI/CD
   |
   +--> Unit Tests
   +--> Secrets Scan
   +--> SAST
   +--> Dependency Scan
   +--> IaC/Kubernetes Scan
   +--> Docker Build
   +--> Container Image Scan
   +--> DAST Scan
   +--> SBOM Generation
   |
   v
Deploy or publish only after security gates pass
```

## Pipeline Flow

1. Checkout repository
2. Install application dependencies
3. Run unit tests
4. Scan for committed secrets with Gitleaks
5. Run static code analysis with CodeQL
6. Scan filesystem and dependencies with Trivy
7. Scan Infrastructure-as-Code and Kubernetes manifests with Trivy
8. Build Docker image
9. Scan Docker image for vulnerabilities
10. Run the app in CI
11. Run OWASP ZAP baseline DAST scan
12. Generate SBOM
13. Upload security reports as artifacts

## Security Controls

| Control | Tool | Purpose |
|---|---|---|
| Secrets scanning | Gitleaks | Detect hardcoded credentials and tokens |
| SAST | CodeQL | Find insecure code patterns |
| Dependency scanning | Trivy | Identify vulnerable packages |
| IaC scanning | Trivy config | Find risky Terraform/Kubernetes settings |
| Container scanning | Trivy image | Detect vulnerabilities in Docker images |
| DAST | OWASP ZAP | Test a running app for common web issues |
| SBOM | Trivy | Generate software bill of materials |

## Vulnerability Demo

The `/search` endpoint demonstrates a common secure coding issue: rendering user input into an HTML response.

The vulnerable pattern would be:

```js
app.get('/search', (req, res) => {
  const query = req.query.q;
  res.send(`<h1>Search results for ${query}</h1>`);
});
```

The remediated version uses output encoding:

```js
const escapeHtml = require('escape-html');

app.get('/search', (req, res) => {
  const query = escapeHtml(req.query.q || '');
  res.send(`<h1>Search results for ${query}</h1>`);
});
```

## Security Gates

The CI pipeline fails on high and critical findings from Trivy filesystem, config, and image scans. OWASP ZAP is configured in non-blocking mode for the first version of the project so findings can be reviewed without blocking the demo pipeline.

## Run Locally

```bash
cd app
npm install
npm test
npm start
```

Then open:

```text
http://localhost:3000
http://localhost:3000/health
http://localhost:3000/search?q=test
```

## Run with Docker

```bash
docker build -t devsecops-mini-app .
docker run -p 3000:3000 devsecops-mini-app
```

## Suggested Screenshots for LinkedIn

- GitHub Actions pipeline passing
- Failed scan from an intentional vulnerability or misconfiguration
- Fixed code commit
- Trivy scan output
- OWASP ZAP report artifact
- Architecture diagram

## Lessons Learned

This project shows how DevSecOps connects secure development, automated scanning, vulnerability management, CI/CD security gates, container hardening, and documentation into one repeatable workflow.
