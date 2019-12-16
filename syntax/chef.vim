" Prelude {{{1
if exists("b:current_syntax")
  finish
endif

" this file uses line continuations
let s:cpo_sav = &cpo
set cpo&vim

" Folding Config {{{1
if has("folding") && exists("ruby_fold")
  setlocal foldmethod=syntax
endif

let s:foldable_groups = split(
      \	  get(
      \	    b:,
      \	    'ruby_foldable_groups',
      \	    get(g:, 'ruby_foldable_groups', 'ALL')
      \	  )
      \	)

function! s:foldable(...) abort
  if index(s:foldable_groups, 'NONE') > -1
    return 0
  endif

  if index(s:foldable_groups, 'ALL') > -1
    return 1
  endif

  for l:i in a:000
    if index(s:foldable_groups, l:i) > -1
      return 1
    endif
  endfor

  return 0
endfunction

function! s:run_syntax_fold(args) abort
  let [_0, _1, groups, cmd; _] = matchlist(a:args, '\(["'']\)\(.\{-}\)\1\s\+\(.*\)')
  if call('s:foldable', split(groups))
    let cmd .= ' fold'
  endif
  exe cmd
endfunction

com! -nargs=* SynFold call s:run_syntax_fold(<q-args>)



syn region fileResourceBlock start="\<file\>.*\<do\>" skip="\<end:" end="\<end\>" contains=fileResourceProperties

syn keyword fileResourceProperties contained checksum owner group mode path atomic_update backup content diff force_unlink manage_symlink_source verifications

hi link fileResourceBlock Statement
hi link fileResourceProperties Type

" Postscript {{{1
let b:current_syntax = "chef"

let &cpo = s:cpo_sav
unlet! s:cpo_sav

delc SynFold
