# Risk Register

| ID | Finding | Severity | Tool | Status | Remediation |
|---|---|---|---|---|---|
| R-001 | Reflected input rendered without encoding | High | SAST/DAST | Fixed | Added output encoding with escape-html |
| R-002 | Hardcoded secret in source control | High | Gitleaks | Prevented | Gitleaks runs on every pull request |
| R-003 | Vulnerable container package | Critical | Trivy | Prevented | Pipeline fails on high/critical image findings |
| R-004 | Kubernetes container used default security context | High | Trivy config | Fixed | Added pod-level securityContext, RuntimeDefault seccomp profile, non-root user, read-only root filesystem, and dropped Linux capabilities |
| R-005 | S3 bucket missing customer-managed KMS encryption | High | Trivy config | Fixed | Added customer-managed KMS key and configured SSE-KMS encryption |
| R-006 | Vulnerable Node.js transitive dependencies | High | Trivy fs | Fixed | Updated npm dependencies and regenerated package-lock.json |
| R-007 | Vulnerable OpenSSL packages in Alpine container image | High | Trivy image | Fixed | Upgraded Alpine packages during Docker image build |