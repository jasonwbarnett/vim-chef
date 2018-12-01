syn region fileResourceBlock start="\v^[^#]*file[\s]+" end="\v^[^#]*\zs<end>" contains=fileResourceProperties

syn keyword fileResourceProperties contained checksum owner group mode path atomic_update backup content diff force_unlink manage_symlink_source verifications

hi link fileResourceBlock Statement
hi link fileResourceProperties Type
