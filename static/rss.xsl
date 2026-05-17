<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="/rss/channel/title"/> — RSS Feed</title>
        <style>
          *, *::before, *::after { box-sizing: border-box; }
          body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            max-width: 720px;
            margin: 60px auto;
            padding: 0 24px;
            color: #1a1a1a;
            background: #fff;
            line-height: 1.6;
          }
          @media (prefers-color-scheme: dark) {
            body { background: #1a1a1a; color: #e0e0e0; }
            a { color: #7eb3f5; }
            .meta { color: #888; }
            .badge { background: #2a2a2a; color: #aaa; border-color: #444; }
          }
          h1 { font-size: 1.5rem; margin: 0 0 4px; }
          h2 { font-size: 1.1rem; margin: 0 0 6px; }
          h2 a { color: inherit; text-decoration: none; }
          h2 a:hover { text-decoration: underline; }
          p { margin: 0; }
          a { color: #0070f3; }
          .header { margin-bottom: 40px; padding-bottom: 24px; border-bottom: 1px solid #eee; }
          .description { color: #555; margin: 4px 0 16px; font-size: 0.95rem; }
          .badge {
            display: inline-block;
            font-size: 0.75rem;
            padding: 3px 10px;
            border-radius: 20px;
            border: 1px solid #ddd;
            color: #666;
            text-decoration: none;
          }
          .badge:hover { text-decoration: none; border-color: #0070f3; color: #0070f3; }
          .items { list-style: none; padding: 0; margin: 0; }
          .item { padding: 24px 0; border-bottom: 1px solid #eee; }
          .item:last-child { border-bottom: none; }
          .meta { font-size: 0.85rem; color: #666; margin-top: 6px; }
          @media (prefers-color-scheme: dark) {
            .header { border-color: #333; }
            .item { border-color: #333; }
            .description { color: #aaa; }
          }
        </style>
      </head>
      <body>
        <div class="header">
          <h1><xsl:value-of select="/rss/channel/title"/></h1>
          <p class="description"><xsl:value-of select="/rss/channel/description"/></p>
          <a class="badge" href="{/rss/channel/link}">&#8592; Back to site</a>
          &#160;
          <a class="badge" href="{/rss/channel/atom:link/@href}">Subscribe to feed</a>
        </div>
        <ul class="items">
          <xsl:for-each select="/rss/channel/item">
            <li class="item">
              <h2><a href="{link}"><xsl:value-of select="title"/></a></h2>
              <p><xsl:value-of select="description"/></p>
              <p class="meta"><xsl:value-of select="pubDate"/></p>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
