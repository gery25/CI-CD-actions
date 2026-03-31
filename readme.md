# Django CI/CD Pipeline with GitHub Actions & Render

This project implements a professional-grade automated workflow to ensure that code is validated through tests before being deployed to production. The architecture is split into two distinct stages: **Continuous Integration (CI)** and **Continuous Deployment (CD)**.

---

## Pipeline Architecture

### 1. Continuous Integration (CI)
**File:** `.github/workflows/ci.yml`

Triggered on every `push` or `pull_request` to the `main` branch. This stage ensures the codebase remains stable.
* **Environment:** Ubuntu Latest running Python 3.12.
* **Dependency Management:** Automated installation via `pip` and `requirements.txt`.
* **Automated Testing:** Runs Django unit tests using `python web_django/manage.py test`.

> **Safety Gate:** Deployment to production is automatically blocked if any test fails during this stage.

### 2. Continuous Deployment (CD)
**File:** `.github/workflows/cd.yml`

This workflow is orchestrated to run **only** after a successful CI run.
* **Trigger:** Completion of the "CI" workflow with a `success` status on the `main` branch.
* **Deployment Method:** Utilizes Render's *Deploy Hook* API.
* **Action:** Sends a secure POST request to Render to trigger a fresh Docker build and deployment of the Web Service.

---

## Setup & Configuration

### GitHub Secrets
To enable the deployment, the following secret must be configured in **Settings > Secrets and variables > Actions**:

| Secret Name | Description |
| :--- | :--- |
| `RENDER_DEPLOY_HOOK` | The unique URL provided by Render (found in Web Service Settings > Deploy Hook). |

### Docker Integration
The project is containerized for consistent environments:
1. **Dockerfile:** Render automatically detects the `Dockerfile` in the root directory.
2. **Infrastructure:** Render manages the container lifecycle, replacing the need for manual server configuration.
3. **Control:** By disabling "Auto-Deploy" in the Render dashboard, GitHub Actions gains full control over the release cycle.

---

## Useful Commands

* **Run CI locally:**
  ```bash
  python web_django/manage.py test