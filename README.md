# To Markdown

Docker-based tools to batch-convert files to Markdown. Drop files into `.input/`, run the converter, pick up results from `.output/`.

## Folder Structure

```bash
to-markdown/
├── .input/              # Place source files here before running
└── .output/             # Converted Markdown files appear here
```


## epub2md - EPUB to Markdown

Converts every `.epub` file in `.input/` using [Pandoc](https://pandoc.org/).

**Input:** `.input/*.epub`

**Output** (per file):
```bash
.output/
└── <filename>/
  ├── <filename>.md     # Markdown content
  └── media/            # Extracted images (if any)
```

```bash
docker compose up --build epub2md
```


## pdf2md - PDF to Markdown

Converts every `.pdf` file in `.input/` using [markitdown](https://github.com/microsoft/markitdown).

> Requires cloning the markitdown submodule first:
> ```bash
> git clone --depth 1 https://github.com/microsoft/markitdown.git
> ```

**Input:** `.input/*.pdf`

**Output** (per file):
```bash
.output/
└── <filename>.pdf.md
```

```bash
docker compose up --build pdf2md
```
