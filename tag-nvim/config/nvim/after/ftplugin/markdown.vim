" ~/.config/nvim/after/ftplugin/markdown.vim

setlocal spell
setlocal textwidth=92
iabbrev <buffer> ... …

"highlight YAML frontmatter in jekyll
let g:vim_markdown_frontmatter = 1

"normal mode key mappings for 'iamcco/markdown-preview.nvim'
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop
nmap <leader>mt <Plug>MarkdownPreviewToggle
