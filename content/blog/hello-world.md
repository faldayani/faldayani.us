---
title: "Using Notion as My Personal Jira"
date: 2026-05-16
draft: false
summary: "How I set up Notion as a project tracker and wired it up to an API so I can create and update tasks from the terminal."
---

I've been using Notion for a while mostly as a notes app, but recently I set it up more like a proper project tracker — epics, issues, priorities, statuses, the whole thing. The kind of setup you'd normally see in Jira, but without the $20/month and the 47 tabs it takes to do anything.

The part I actually enjoyed was connecting it to the Notion API so I can manage tasks from the terminal instead of clicking around in the UI. Here's how it works.

## The setup

Inside Notion I have a project board with three databases:

- **Epics** — the big feature areas (e.g. "Blog Section", "Mobile App v2")
- **Issues** — the actual tasks, linked back to an epic
- **Sprints** — time boxes that issues can be assigned to

Issues have all the fields you'd expect: status, priority, labels, story points, assignee, due date. Epics and sprints have their own trimmed-down schemas.

To talk to all of this from outside Notion, you create an internal integration in your workspace settings, grab a token, and share the relevant pages with it. After that you're just making HTTP requests.

## Creating an epic

Here's what creating an epic looks like at the API level:

```bash
curl -X POST "https://api.notion.com/v1/pages" \
  -H "Authorization: Bearer $NOTION_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-06-28" \
  -d '{
    "parent": { "database_id": "your-epics-db-id" },
    "properties": {
      "Name": { "title": [{ "type": "text", "text": { "content": "Blog Section" } }] },
      "Status": { "select": { "name": "Backlog" } },
      "Priority": { "select": { "name": "Medium" } }
    }
  }'
```

You're just creating a new page inside the Epics database. Notion treats every row in a database as a page, so the API is the same regardless of whether you're making an epic, an issue, or a sprint.

## Creating issues under that epic

Issues work the same way, but you also pass a relation back to the epic. The thing to know here is that relations use the epic row's *page ID*, not the database ID — I got tripped up on that the first time.

```bash
curl -X POST "https://api.notion.com/v1/pages" \
  -H "Authorization: Bearer $NOTION_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-06-28" \
  -d '{
    "parent": { "database_id": "your-issues-db-id" },
    "properties": {
      "Name": { "title": [{ "type": "text", "text": { "content": "Add blog section to Hugo site" } }] },
      "Status": { "select": { "name": "To Do" } },
      "Priority": { "select": { "name": "High" } },
      "Labels": { "multi_select": [{ "name": "Frontend" }, { "name": "Feature" }] },
      "Epic": { "relation": [{ "id": "epic-page-id-here" }] }
    }
  }'
```

## Moving an issue through the board

Updating status is just a PATCH to the page with the new select value:

```bash
curl -X PATCH "https://api.notion.com/v1/pages/issue-page-id" \
  -H "Authorization: Bearer $NOTION_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-06-28" \
  -d '{ "properties": { "Status": { "select": { "name": "Done" } } } }'
```

## Wrapping it in a CLI

Typing all that curl by hand gets old fast. I wrote a small Node.js script (`notion.js`) that wraps the common operations so I can do things like:

```bash
# Create an epic
node notion.js create-epic --title "Blog Section" --priority Medium

# Create an issue under it
node notion.js create-issue --title "Deploy to production" --epic "Blog Section" --priority High --labels "Feature"

# See what's open
node notion.js list-issues --status "In Progress"

# Close it out
node notion.js move-issue --id page-id-here --status "Done"
```

The script finds the epic by name, looks up its page ID, and wires everything together — so I never have to paste IDs manually.

## Why bother

The main reason is that I find it easier to stay on top of side projects when the tracking is close to where the work is actually happening. Instead of switching to a browser and hunting for the right page, I can run a command in the same terminal I'm already working in.

It also means I can have Claude update the board automatically as tasks finish — writing notes on what was done, any errors that came up, and how things got resolved. So the board stays accurate without extra effort on my end.

Not something I'd recommend for a team, but for solo projects it's a nice middle ground between "sticky note on my monitor" and a full Jira setup.
