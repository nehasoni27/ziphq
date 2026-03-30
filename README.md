# zip-neha

Minimal Python package used to demonstrate GitHub Actions CI (Ruff + pytest) and branch protection.

## Local development

```bash
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -e ".[dev]"
ruff check .
pytest
```

See [SETUP.md](SETUP.md) for creating the GitHub repository and configuring branch protection.
