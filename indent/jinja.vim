" jinja indent file
" Language: Jinja HTML template
" Maintainer: Hsiaoming Yang <lepture@me.com>
" Last Change: Sep 13, 2012

" based on django indent by Steve Losh

if exists("b:did_indent")
  finish
endif

runtime! indent/html.vim
