augroup filetypedetect
	autocmd!
	au BufRead,BufNewFile *.sql setfiletype sql
	au BufRead,BufNewFile *.md setfiletype markdown
	au BufRead,BufNewFile *.html setfiletype html
	au BufRead,BufNewFile *.ps1 setfiletype powershell
	au BufRead,BufNewFile *.json setfiletype json
	au BufRead,BufNewFile memo.txt $r!echo. & echo ---------------------------------------------------------------- \%date:~0,4\%年\%date:~5,2\%月\%date:~8,2\%日\%time:~0,8\%
	" au BufRead,BufNewFile *.md 
augroup END