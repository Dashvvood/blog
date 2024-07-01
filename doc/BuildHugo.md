# BlogWithHugo

## Installtion

### Prerequisites: git + go + Dart Sass

```shell
### git
sudo apt install -y git

$ git --version
git version 2.34.1

### go
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

$ go version
go version go1.22.4 linux/amd64
```

**check**

```shell

```

### Hugo

```shell
wget https://github.com/gohugoio/hugo/releases/download/v0.128.0/hugo_extended_0.128.0_linux-amd64.tar.gz

mkdir hugo_ext_v0.128
tar -zxvf hugo_extended_0.128.0_linux-amd64.tar.gz -c hugo_ext_v0.128

sudo ln -s <abs path>/hugo /usr/local/bin/hugo

$ hugo version
hugo v0.128.0-e6d2712ee062321dc2fc49e963597dd5a6157660+extended linux/amd64 BuildDate=2024-06-25T16:15:48Z VendorInfo=gohugoio
```



## Usage

```shell
hugo new site blog --format yaml
```



**theme**

```shell
git submodule add -b dev https://github.com/Dashvvood/hugo-PaperMod.git themes/PaperMod
```



**default template**

```markdown
---
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
date: {{ .Date }}
draft: false
author: author
tags: ["default"]
toc: true
typora-copy-images-to: ${filename}.assets # only for typora
---
```

>path: blog/archetypes/default.md



**mermaid**

1. add html file

   ```html
   <pre class="mermaid">
       {{- .Inner | safeHTML }}
   </pre>
   {{ .Page.Store.Set "hasMermaid" true }}
   ```

   >path: blog/themes/PaperMod/layouts/_default/_markup/render-codeblock-mermaid.html

2. update `single.html` 

   ```html
   {{- if .Content }}
   <div class="post-content">
   {{- if not (.Param "disableAnchoredHeadings") }}
   {{- partial "anchored_headings.html" .Content -}}
   {{- else }}{{ .Content }}{{ end }}
   </div>
   
   <!-- New -->
   {{ if .Store.Get "hasMermaid" }}
       <script type="module">
         import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.esm.min.mjs';
         mermaid.initialize({ startOnLoad: true });
       </script>
   {{ end }}
   <!-- New -->
   ```



**math** (mathjax)

1. add html

   ```html
   <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js"></script>
   <script>
     MathJax = {
       tex: {
         displayMath: [['\\[', '\\]'], ['$$', '$$']],  // block
         inlineMath: [['\\(', '\\)']]                  // inline
       }
     };
   </script>
   ```

   >path: blog/themes/PaperMod/layouts/partials/math.html

2. update `baseof.html`

   ```html
   <head>
       {{- partial "head.html" . }}
        <!-- new -->
       {{ if .Param "math" }}
       	{{ partialCached "math.html" . }}
       {{ end }}
        <!-- new -->
   </head>
   ```



**pagefind**

https://pagefind.app/docs/running-pagefind/

```
npx pagefind --site public
```

**default**
```markdown
date: {{ .Date | time.Format "2006-01-02" }}
```


**hugo config**

```yaml
baseURL: https://Dashvvood.github.io/
languageCode: en-us
title: Empty Attic
paginate: 5
theme: PaperMod

markup:
  goldmark:
    renderer:
      unsafe: true
    extensions:
      passthrough:
        delimiters:
          block:
          - - \[
            - \]
          - - $$
            - $$
          inline:
          - - \(
            - \)
        enable: true
  tableOfContents:
    endLevel: 3
    ordered: true
    startLevel: 2


params:
  math: true
  author: lup1n
  toc: true

menu:
  main:
    - name: Archive
      url: archives/
      weight: 10
    - name: Search
      url: search/
      weight: 10
    - name: Tags
      url: tags/
      weight: 10
    - name: About
      url: about/
      weight: 10
    - name: Todo
      url: todo/
      weight: 10

```



## Reference

- https://github.com/adityatelange/hugo-PaperMod/tree/exampleSite
- 