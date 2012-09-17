" jinja indent file
" Language: Jinja HTML template
" Maintainer: Hsiaoming Yang <lepture@me.com>
" Last Change: Sep 13, 2012

" based on django indent by Steve Losh

if exists("b:did_indent")
  finish
endif

runtime! indent/html.vim
unlet! b:did_indent

if &l:indentexpr == ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
  endif
endif
let b:html_indentexpr = &l:indentexpr

let b:did_indent = 1

setlocal indentexpr=GetJinjaIndent()
setlocal indentkeys=o,O,*<Return>,{,},o,O,!^F,<>>

" Only define the function once.
if exists("*GetJinjaIndent")
  finish
endif

function! GetHtmlIndent()
  exe "let ind = ".b:html_indentexpr
  return ind
endfunction

if !exists("s:indent_tags")
  let s:indent_tags = {}
endif

function! AddBlockTags(taglist)
  for itag in a:taglist
    let s:indent_tags[itag] = 1
    let s:indent_tags['/'.itag] = -1
  endfor
endfunction

function! GetJinjaIndent(...)
  if a:0 && a:1 == '.'
    let v:lnum = line('.')
  elseif a:0 && a:1 =~ '^\d'
    let v:lnum = a:1
  endif
  let vcol = col('.')

  call cursor(v:lnum,vcol)

  let ind = GetHtmlIndent()

  let lnum = prevnonblank(v:lnum-1)
  let line = getline(lnum)
  let cline = getline(v:lnum)

  let blocktags = '\(block\|for\|if\|with\|autoescape\|filter\|macro\|raw\|call\)'
  let midtags = '\(elif\|else\)'

  if line =~# '^\s*{%-\?\s*'.blocktags.'\s*-\?%}$'
    echomsg "line start"
    let ind = ind + &sw
  if line =~# '^\s*{%-\?\s*'.midtags.'\s*-\?%}$'
    echomsg "line mid"
    let ind = ind + &sw
  endif

  if cline =~# '^\s*{%-\?\s*end'.blocktags.'\s*-\?%}$'
    echomsg = 'cline end'
    let ind = ind - &sw
  endif

  if cline =~# '^\s*{%-\?\s*'.midtags.'\s*-\?%}$'
    echomsg "mid end"
    let ind = ind - &sw
  endif

  return ind
endfunction
