" vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
function! AuditCut()
	silent 1,/^INSERT/ d
	silent %s/^INSERT.*\n//e
	silent %s/^(\([^,]*,\)\{4}\(\s*'[^']*',\)\{4}\s*[\'\"]\(.*\)[\'\"])[;,]\s*$/\3/e
	silent %s/^\/\*.*\*\/;\n//e
	silent %s/\'\'/\'/ge
	silent %s/^\(ALTER\|CREATE\|DROP\)\s\+TABLE\s\+\(IF NOT EXISTS\s\+\)\?`\([^`]*\)`/USE `\3`;\r\1 TABLE \2 `\3`/e
	silent " Reduce number of USE lines - but not totally
	silent %s/^USE `\([^`]*\)`;\n\(.*\)\nUSE `\1`;\n/USE `\1`;\r\2\r/e
	silent %s/\n$//e
	%y+
	1
endfunction
command! -nargs=0 AuditCut call AuditCut()

function! CharsetConv()
	if search('CREATE DATABASE')
		%s/CREATE DATABASE `\([^`]*\)`\( DEFAULT CHARACTER SET \w*\)\?\( COLLATE \w*\)\?;/ALTER DATABASE `\1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;/e
	else
		%s/-- Database: `\([^`]*\)`/ALTER DATABASE `\1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
	endif
	%s/^\s*PRIMARY\s*KEY.*\n//e
	%s/^\s*\(UNIQUE \)\?\s*KEY \(`[^`]*`\)\( ([^)]*)\)\?,\?/ALTER TABLE unknown ADD \1KEY \2\3;/e
	%s/^).*\n//e
	%s/^CREATE TABLE\( IF NOT EXISTS\)\? `\([^`]*\)` (/ALTER TABLE `\2` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;/e
	"Leave fields with CHARACTER SET already
	%s/^\s*`[^`]*` \(varchar\|char\|text\|tinytext\|mediumtext\)\((\d\+)\)\? \(CHARACTER SET utf8\|COLLATE utf8\).*\n//ei
	%s/^\s\+`[^`]*` \(varchar\|char\|text\|tinytext\|mediumtext\)\@!.*\n//ei
	%s/^\s\+`\([^`]*\)` \(varchar\|char\|text\|tinytext\|mediumtext\)\((\d\+)\)\?\%( CHARACTER SET \w*\)\?\%( COLLATE \w*\)\?\( NOT NULL\)\?\( AUTO_INCREMENT\)\?\( DEFAULT \(NULL\|'[^']*'\)\)\?,\?/ALTER TABLE unknown MODIFY `\1` \2\3 CHARACTER SET utf8 COLLATE utf8_general_ci\4\5\6;/ei
	while search('ALTER TABLE unknown')
		%s/^ALTER TABLE `\([^`]*\)`\(.*\)\nALTER TABLE unknown\(.*\)/ALTER TABLE `\1`\2\rALTER TABLE `\1`\3/
	endwhile
	%s/^ALTER DATABASE/\rALTER DATABASE/e
	let s:half=line('$')
	1s/\(\_.*\)/\1\r\r\1/
	execute s:half . ',$s/ALTER DATABASE `\([^`]*\)` DEFAULT CHARACTER SET.*;/ALTER DATABASE `\1` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;/e'
	execute '1,' . s:half . 's/ALTER TABLE `\([^`]*\)` DEFAULT CHARACTER SET.*;/ALTER TABLE `\1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;/e'
	execute '1,' . s:half . 's/ALTER TABLE `\([^`]*\)` ADD \(UNIQUE \)\?KEY `\([^`]*\)`.*/ALTER TABLE `\1` DROP KEY `\3`;/e'
	execute '1,' . s:half . 's/ALTER TABLE `\([^`]*\)` MODIFY `\([^`]*\)`.*/ALTER TABLE `\1` MODIFY `\2` BLOB;/e'
	execute '1,' . s:half . 's/\(\(ALTER TABLE `[^`]*` MODIFY `[^`]*` BLOB;\n\)\+\)\(\(ALTER TABLE `[^`]*` DROP \(UNIQUE \)\?KEY `[^`]*`;\n\)\+\)/\3\1/e'
endfunction
command! -nargs=0 CharsetConv call CharsetConv()
" vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
