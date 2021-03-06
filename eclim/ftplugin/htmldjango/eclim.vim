" Author:  Eric Van Dewoestine
"
" Description: {{{
"
" License:
"
" Copyright (C) 2005 - 2009  Eric Van Dewoestine
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.
"
" }}}

runtime ftplugin/html.vim
runtime indent/html.vim
runtime ftplugin/html/eclim.vim

" Global Variables {{{

if !exists('g:HtmlDjangoCompleteEndTag')
  let g:HtmlDjangoCompleteEndTag = 1
endif
if !exists('g:HtmlDjangoUserBodyElements')
  let g:HtmlDjangoUserBodyElements = []
endif

let g:HtmlDjangoBodyElements = [
    \ ['block', 'endblock'],
    \ ['comment', 'endcomment'],
    \ ['filter', 'endfilter'],
    \ ['for', 'endfor'],
    \ ['if', 'else', 'endif'],
    \ ['ifchanged', 'else', 'endifchanged'],
    \ ['ifequal', 'else', 'endifequal'],
    \ ['ifnotequal', 'else', 'endifnotequal'],
    \ ['spaceless', 'else', 'endspaceless']
  \ ] + g:HtmlDjangoUserBodyElements

" add matchit.vim support for django tags
if exists("b:match_words")
  for element in g:HtmlDjangoBodyElements
    let pattern = ''
    for tag in element[:-2]
      if pattern != ''
        let pattern .= ':'
      endif
      let pattern .= '{%\s*\<' . tag . '\>.\{-}%}'
    endfor
    let pattern .= ':{%\s*\<' . element[-1:][0] . '\>\s*%}'
    let b:match_words .= ',' . pattern
  endfor
endif

" }}}

" Mappings {{{

if g:HtmlDjangoCompleteEndTag
  imap <buffer> <silent> e <c-r>=eclim#python#django#template#CompleteEndTag()<cr>
endif

" }}}

" Command Declarations {{{

if !exists(':DjangoFind')
  command -buffer DjangoFind :call eclim#python#django#find#TemplateFind()
endif

" }}}

" vim:ft=vim:fdm=marker
