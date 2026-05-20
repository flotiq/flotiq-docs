# AGENTS.md

## Project purpose and shape
- This repo builds the public Flotiq docs site with MkDocs Material; source lives in `docs/`, generated site goes to `site/` (or `public/docs` in CI).
- The IA is mostly hard-coded in `mkdocs.yml` under `nav:`; do not assume filesystem order drives navigation.
- `theme/` overrides Material templates (`theme/main.html`, `theme/partials/content.html`) to add JSON-LD, breadcrumbs, and the `#was-it-helpful` placeholder.
- `docs/js/flotiq.js` and `docs/css/flotiq.css` are loaded globally from `mkdocs.yml` and implement UX behaviors (auto-open nav, highlight.js refresh, helpful widget, scroll-to-top styling).

## Critical content pipeline
- Plugin API reference pages are fetched dynamically from Flotiq editor via `.github/scripts/get-plugins-docs.sh`; run this before local serve/build when plugin docs are relevant.
- The script writes into `docs/panel/PluginsDevelopment/PluginDocs`, renames files to `N_original.md`, and injects `alias:` metadata so legacy `[[Name.md]]` links still resolve.
- `mkdocs-include-dir-to-nav` is configured with `file_pattern: '\d.*\.md$'`, so those numbered generated files are auto-added to nav.

## Local workflows that matter
- Python path:
  - `pip install -r requirements.txt`
  - `bash .github/scripts/get-plugins-docs.sh`
  - `mkdocs serve` (binds to `0.0.0.0:4000` per `mkdocs.yml`)
- Docker path: `docker-compose up -d` (builds from `Dockerfile`, exposes port `4000`).
- Validation used in CI:
  - `mkdocs build`
  - `.github/check-excluded-snippets.sh` (fails PRs if fenced code blocks are not excluded from search)

## Repo-specific authoring conventions
- After fenced code blocks in markdown, include `{ data-search-exclude }` on the next/near-next line (enforced by `.github/check-excluded-snippets.sh`).
- This repo uses mkdocs alias links like `[[PluginInfo.md]]` and `[[PluginInfo.md#header|Label]]` (example in `docs/panel/PluginsDevelopment/plugins.md`).
- Page metadata is plain MkDocs meta at top of `.md` files (`title:`, `description:`, optional `tags:`).
- Jinja-like variables use `<< ... >>` syntax from `mkdocs-markdownextradata-plugin` (examples: `<< plan_names.free >>` in `docs/panel/user-roles.md`).

## Deployment and external integrations
- GitHub Actions in `.github/workflows/` build docs, move `site/` to `public/docs`, then deploy via Wrangler to Cloudflare Workers.
- `workers-site/index.js` serves static assets from KV and enforces canonical trailing slash redirects for non-file URLs.
- Worker response hardens headers (`X-Frame-Options`, `X-Content-Type-Options`, etc.) and applies long cache control (`max-age=31536000`).
- CI mutates `wrangler.toml` at runtime (name/account/bucket/route), so treat committed `wrangler.toml` as a template baseline.

## Safe change strategy for agents
- For nav/content moves, edit both markdown files and `mkdocs.yml` nav entries together.
- For UI behavior changes, check both template hooks (`theme/`) and static assets (`docs/js/flotiq.js`, `docs/css/flotiq.css`) to avoid partial updates.
- If generated PluginDocs are missing in your branch, regenerate instead of hand-editing assumptions about `PluginDocs` pages.

- never use emojis
- avoid idioms and slang
- use clear, direct language
- prefer active voice
- be concise and specific
- avoid unnecessary qualifiers (e.g. "very", "really")
- use consistent terminology (e.g. "nav" vs "navigation")
- avoid jargon unless defined (e.g. "IA", "UX", "CI")