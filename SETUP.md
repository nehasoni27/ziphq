# GitHub repository and CI setup

## Create the GitHub repository and push this project

1. **Create the remote repository** (pick one):

   - **GitHub CLI** (after `gh auth login`):

     ```bash
     cd /path/to/zip_neha
     gh repo create <your-username>/zip-neha --private --source=. --remote=origin --push
     ```

     If the repo already exists empty:

     ```bash
     git init
     git add .
     git commit -m "Initial commit: Python scaffold with Ruff, pytest, and CI"
     git branch -M master
     git remote add origin https://github.com/<your-username>/zip-neha.git
     git push -u origin master
     ```

   - **GitHub web UI:** **New repository** → set name and visibility → **Create repository**. Do **not** add a README, `.gitignore`, or license if you will push this folder as the first commit (avoids unrelated history).

2. **Initialize git locally** (if you did not use `gh repo create --push`):

   ```bash
   cd /path/to/zip_neha
   git init
   git add .
   git commit -m "Initial commit: Python scaffold with Ruff, pytest, and CI"
   git branch -M master
   git remote add origin https://github.com/<your-username>/<repo-name>.git
   git push -u origin master
   ```

3. **Confirm CI:** Open the repo on GitHub → **Actions** → confirm the **CI** workflow ran successfully on the push to `master`.

---

## Branch protection on `master`

Configure in the repository: **Settings** → **Branches** → **Add branch protection rule** (or **Edit** if one exists) for branch name pattern `master`.

### Required: pull request + approval

- Enable **Require a pull request before merging**.
- Set **Required number of approvals before merging** to **1**.

### Required: status checks

- Enable **Require status checks to pass before merging**.
- Enable **Require branches to be up to date before merging** (recommended).
- Under **Status checks that are required**, add **`CI`** (the job name from [`.github/workflows/ci.yml`](.github/workflows/ci.yml)).  
  The check appears after at least one successful workflow run (e.g. from a PR or from the initial push).

### Merge strategy (squash; optional linear history)

- **Repository-wide merge buttons:** **Settings** → **General** → **Pull Requests** → **Merge button**:
  - Enable **Allow squash merging**.
  - To allow **only** squash merges, disable **Allow merge commits** and **Allow rebase merging**.
- **Branch protection (optional):** On the same rule for `master`, you can enable **Require linear history** if you want to forbid merge commits on that branch (squash merges to `master` already keep history linear in typical use).

### Optional

- **Require conversation resolution before merging** if you use review threads.
- **Do not allow bypassing the above settings** if admins should follow the same rules as everyone else.

After this, merging into `master` requires: green **`CI`** check, **one** approving review, and (if configured) squash-only merges.
