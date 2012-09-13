" jinja syntax file
" Language: Jinja HTML template
" Maintainer: Hsiaoming Yang <lepture@me.com>
" Last Change: Sep 13, 2012

" only support 6.x+

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'html'
endif

runtime! syntax/html.vim
unlet b:current_syntax

syntax case match

" Mark illegal characters
syn match jinjaError "%}\|}}\|#}"

" jinja template built-in tags and parameters
" 'comment' doesn't appear here because it gets special treatment
syn keyword jinjaStatement contained autoescape csrf_token empty
" FIXME ==, !=, <, >, <=, and >= should be jinjaStatements:
" syn keyword jinjaStatement contained == != < > <= >=
syn keyword jinjaStatement contained and as block endblock by cycle debug else
syn keyword jinjaStatement contained extends filter endfilter firstof for
syn keyword jinjaStatement contained endfor if endif ifchanged endifchanged
syn keyword jinjaStatement contained ifequal endifequal ifnotequal
syn keyword jinjaStatement contained endifnotequal in include load not now or
syn keyword jinjaStatement contained parsed regroup reversed spaceless
syn keyword jinjaStatement contained endspaceless ssi templatetag openblock
syn keyword jinjaStatement contained closeblock openvariable closevariable
syn keyword jinjaStatement contained openbrace closebrace opencomment
syn keyword jinjaStatement contained closecomment widthratio url with endwith
syn keyword jinjaStatement contained get_current_language trans noop blocktrans
syn keyword jinjaStatement contained endblocktrans get_available_languages
syn keyword jinjaStatement contained get_current_language_bidi plural

" jinja templete built-in filters
syn keyword jinjaFilter contained add addslashes capfirst center cut date
syn keyword jinjaFilter contained default default_if_none dictsort
syn keyword jinjaFilter contained dictsortreversed divisibleby escape escapejs
syn keyword jinjaFilter contained filesizeformat first fix_ampersands
syn keyword jinjaFilter contained floatformat get_digit join last length length_is
syn keyword jinjaFilter contained linebreaks linebreaksbr linenumbers ljust
syn keyword jinjaFilter contained lower make_list phone2numeric pluralize
syn keyword jinjaFilter contained pprint random removetags rjust slice slugify
syn keyword jinjaFilter contained safe safeseq stringformat striptags
syn keyword jinjaFilter contained time timesince timeuntil title
syn keyword jinjaFilter contained truncatewords truncatewords_html unordered_list upper urlencode
syn keyword jinjaFilter contained urlize urlizetrunc wordcount wordwrap yesno

" Keywords to highlight within comments
syn keyword jinjaTodo contained TODO FIXME XXX

" jinja template constants (always surrounded by double quotes)
syn region jinjaArgument contained start=/"/ skip=/\\"/ end=/"/

" Mark illegal characters within tag and variables blocks
syn match jinjaTagError contained "#}\|{{\|[^%]}}\|[&#]"
syn match jinjaVarError contained "#}\|{%\|%}\|[<>!&#%]"

" jinja template tag and variable blocks
syn region jinjaTagBlock start="{%" end="%}" contains=jinjaStatement,jinjaFilter,jinjaArgument,jinjaTagError display
syn region jinjaVarBlock start="{{" end="}}" contains=jinjaFilter,jinjaArgument,jinjaVarError display

" jinja template 'comment' tag and comment block
syn region jinjaComment start="{%\s*comment\s*%}" end="{%\s*endcomment\s*%}" contains=jinjaTodo
syn region jinjaComBlock start="{#" end="#}" contains=jinjaTodo

syn cluster jinjaBlocks add=jinjaTagBlock,jinjaVarBlock,jinjaComment,jinjaComBlock

syn region jinjaTagBlock start="{%" end="%}" contains=jinjaStatement,jinjaFilter,jinjaArgument,jinjaTagError display containedin=ALLBUT,@jinjaBlocks
syn region jinjaVarBlock start="{{" end="}}" contains=jinjaFilter,jinjaArgument,jinjaVarError display containedin=ALLBUT,@jinjaBlocks
syn region jinjaComment start="{%\s*comment\s*%}" end="{%\s*endcomment\s*%}" contains=jinjaTodo containedin=ALLBUT,@jinjaBlocks
syn region jinjaComBlock start="{#" end="#}" contains=jinjaTodo containedin=ALLBUT,@jinjaBlocks


hi def link jinjaTagBlock PreProc
hi def link jinjaVarBlock PreProc
hi def link jinjaStatement Statement
hi def link jinjaFilter Identifier
hi def link jinjaArgument Constant
hi def link jinjaTagError Error
hi def link jinjaVarError Error
hi def link jinjaError Error
hi def link jinjaComment Comment
hi def link jinjaComBlock Comment
hi def link jinjaTodo Todo

let b:current_syntax = "jinja"
