---
title: 'Search'
date: 2024-06-29T22:56:59+02:00
author: lup1n
---

<link href="/blog/pagefind/pagefind-ui.css" rel="stylesheet">
<script src="/blog/pagefind/pagefind-ui.js"></script>
<div id="search"></div>
<script>
    window.addEventListener('DOMContentLoaded', (event) => {
        new PagefindUI({ element: "#search", showSubResults: true });
    });
</script>
