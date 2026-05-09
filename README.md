# faldayani.us — Personal Website

Built with [Hugo](https://gohugo.io/) and the [PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme. Automatically deploys to [faldayani.us](https://faldayani.us) on every push to `main`.

---

## Where to Edit Your Information

### Your name, subtitle, and social links
**File:** `hugo.yaml`

```yaml
params:
  profileMode:
    title: "Faisal Al-Dayani"        # Your name on the homepage
    subtitle: "Software developer."   # Tagline shown below your name

  socialIcons:
    - name: github
      url: "https://github.com/faldayani"
    - name: linkedin
      url: "https://www.linkedin.com/in/faldayani"
    - name: email
      url: "mailto:faisal.aldayani@gmail.com"
```

### Profile photo
Add your photo to `static/images/avatar.jpg`, then in `hugo.yaml`:
```yaml
params:
  profileMode:
    imageUrl: "images/avatar.jpg"
```

### About page
**File:** `content/about.md`
Edit the body text — this is plain markdown.

---

## How to Add a Project

Create a new file in `content/projects/`:

```markdown
---
title: "My App"
date: 2026-01-01
description: "One-line description shown in the project list."
tags: ["Android", "Kotlin"]
draft: false
---

Full description here. Supports **markdown**.

[View on GitHub](https://github.com/faldayani/my-app)
```

- `title` — project name
- `description` — shown in the card preview
- `tags` — optional labels
- `draft: true` — hides it from the live site until you're ready

---

## How to Write a Blog Post

Create a new file in `content/posts/`:

```markdown
---
title: "My First Post"
date: 2026-05-08
description: "Short summary shown in the post list."
tags: ["thoughts"]
draft: false
---

Write your post here in **markdown**.
```

Then add a Posts link to the nav in `hugo.yaml`:

```yaml
menu:
  main:
    - identifier: posts
      name: Posts
      url: /posts/
      weight: 15
```

---

## How to Deploy

Push to `main` — GitHub Actions handles the rest:

```bash
git add .
git commit -m "your message"
git push
```

The site rebuilds and goes live at [faldayani.us](https://faldayani.us) within ~1 minute.

---

## Local Preview

```bash
hugo server --buildDrafts
```

Open [http://localhost:1313](http://localhost:1313) in your browser. Changes hot-reload automatically. The `--buildDrafts` flag shows posts/projects marked `draft: true`.

---

## File Structure

```
.
├── hugo.yaml                  # Site config — name, links, nav, theme settings
├── content/
│   ├── about.md               # About page
│   ├── search.md              # Search page (don't edit)
│   ├── projects/
│   │   ├── _index.md          # Projects section title/description
│   │   └── yellow-note.md     # Example project — duplicate for new ones
│   └── posts/                 # Create this folder for blog posts
├── static/
│   ├── CNAME                  # Custom domain — do not edit
│   └── images/                # Put your profile photo here
├── themes/PaperMod/           # Theme — do not edit files inside here
└── .github/workflows/
    └── deploy.yml             # Auto-deploy pipeline — do not edit
```

---

## Cloning on a New Machine

The theme is a git submodule, so clone with:

```bash
git clone --recurse-submodules https://github.com/faldayani/faldayani.us.git
```
