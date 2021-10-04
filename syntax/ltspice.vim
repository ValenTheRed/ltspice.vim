" Vim syntax file
" Language:	LTSpice circuit simulator input netlist
" Maintainer:	ValenTheRed
"
" This is based on https://github.com/ftorres16/spice.vim

if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "ltspice"

" spice syntax is case INsensitive
syn case ignore

" Comments {{{1
syn keyword	spiceTodo	contained TODO NOTE XXX BUG FIXME
syn region spiceComment start="\v^\s*[*#$]" end="$" contains=@Spell,@spiceTodo
syn region spiceComment start="\v;" end="$" contains=@Spell,@spiceTodo
highlight link spiceTodo		Todo
highlight link spiceComment		Comment

" Numbers {{{1
" all with engineering suffixes and optional units
" floating point number (23.43), optional exponent
syn match spiceReal  "\v<-?\d+\.\d*(e[-+]?\d+)?(meg|mil|[fpnuμmkgt])?"
" floating point number, beginning with dot seperator (.32), optional exponent
syn match spiceReal  "\v<-?\.\d+(e[-+]?\d+)?(meg|mil|[fpnuμmkgt])?"
" integer number with optional exponent
syn match spiceInteger  "\v<-?\d+(e[-+]?\d+)?(meg|mil|[fpnuμmkgt])?"

highlight link spiceReal		Float
highlight link spiceInteger		Number

" Elements {{{1
" Non supported symbols [^\s{}(),;'=]
syn match spiceElement "\v^\s*r[^[:space:]{}(),;'=]*" " Resistors
syn match spiceElement "\v^\s*c[^[:space:]{}(),;'=]*" " Capacitor
syn match spiceElement "\v^\s*l[^[:space:]{}(),;'=]*" " Inductor
syn match spiceElement "\v^\s*v[^[:space:]{}(),;'=]*" " Independent voltage source
syn match spiceElement "\v^\s*i[^[:space:]{}(),;'=]*" " Independent current source
syn match spiceElement "\v^\s*E[^[:space:]{}(),;'=]*" " Voltage-controlled voltage source
syn match spiceElement "\v^\s*G[^[:space:]{}(),;'=]*" " Voltage-controlled current source
syn match spiceElement "\v^\s*H[^[:space:]{}(),;'=]*" " Current-controlled voltage source
syn match spiceElement "\v^\s*F[^[:space:]{}(),;'=]*" " Current-controlled current source
syn match spiceElement "\v^\s*d[^[:space:]{}(),;'=]*" " Diode
syn match spiceElement "\v^\s*q[^[:space:]{}(),;'=]*" " BJT
syn match spiceElement "\v^\s*m[^[:space:]{}(),;'=]*" " MOSFET
syn match spiceElement "\v^\s*x[^[:space:]{}(),;'=]*" " Op-amp

highlight link spiceElement		Type

" Directives {{{1
syn match spiceDirective "\v^\s*[,.]backanno>"
syn match spiceDirective "\v^\s*[,.]end>"
syn match spiceDirective "\v^\s*[,.]ferret>"
syn match spiceDirective "\v^\s*[,.]global>"
syn match spiceDirective "\v^\s*[,.]ic>"
syn match spiceDirective "\v^\s*[,.]inc>"
syn match spiceDirective "\v^\s*[,.]include>"
syn match spiceDirective "\v^\s*[,.]lib>"
syn match spiceDirective "\v^\s*[,.]load>"
syn match spiceDirective "\v^\s*[,.]loadbias>"
syn match spiceDirective "\v^\s*[,.]meas>"
syn match spiceDirective "\v^\s*[,.]nodealias>"
syn match spiceDirective "\v^\s*[,.]nodeset>"
syn match spiceDirective "\v^\s*[,.]opt>"
syn match spiceDirective "\v^\s*[,.]option>"
syn match spiceDirective "\v^\s*[,.]options>"
syn match spiceDirective "\v^\s*[,.]opts>"
syn match spiceDirective "\v^\s*[,.]probe>"
syn match spiceDirective "\v^\s*[,.]save>"
syn match spiceDirective "\v^\s*[,.]savebias>"
syn match spiceDirective "\v^\s*[,.]step>"
syn match spiceDirective "\v^\s*[,.]temp>"
syn match spiceDirective "\v^\s*[,.]wave>"

" Functions and parameters {{{2
syn match spiceDirective "\v^\s*([,.]|\.\.)funcs?>"
syn match spiceDirective "\v^\s*([,.]|\.\.)params?>"
syn match spiceDirective "\v^\s*([,.]|\.\.)parma>"

" State Machine directives {{{2
syn region spiceMachine start="\v^\s*[,.]mach>" end="\v^\s*[,.]endmach>"
syn region spiceMachine start="\v^\s*[,.]machine>" end="\v^\s*[,.]endmachine>"
syn match  spiceDirective "\v^\s*[,.]state>"
syn match  spiceDirective "\v^\s*[,.]rule>"
syn match  spiceDirective "\v^\s*[,.]output>"

" Models and subcircuits {{{2
syn region spiceModSub start="\v^\s*[,.]model>" end="\v^\s*[,.]ends>" contains=SpiceModSub,spiceMachine,spiceDirective
syn region spiceModSub start="\v^\s*[,.]subckt>" end="\v^\s*[,.]ends>" contains=SpiceModSub,spiceMachine,spiceDirective
syn match  spiceDirective "\v<params:>"
"}}}

highlight link spiceDirective Keyword
highlight link spiceModSub		Structure
highlight link spiceMachine		Structure

" Analysis {{{1
syn match spiceAnalysis "\v^\s*[,.]ac>"
syn match spiceAnalysis "\v^\s*[,.]dc>"
syn match spiceAnalysis "\v^\s*[,.]four>"
syn match spiceAnalysis "\v^\s*[,.]net>"
syn match spiceAnalysis "\v^\s*[,.]op>"
syn match spiceAnalysis "\v^\s*[,.]tf>"
syn match spiceAnalysis "\v^\s*[,.]tran>"

highlight link spiceAnalysis		Keyword

" Functions {{{1
syn keyword spiceFunc sin
syn keyword spiceFunc pulse
syn keyword spiceFunc pwl
syn keyword spiceFunc sqrt

highlight link spiceFunc		Function

" No idea what these are supposed to do {{{1
" Matching pairs of parentheses
syn region  spiceParen transparent matchgroup=spiceOperator start="(" end=")" contains=ALLBUT,spiceParenError
syn region  spiceSinglequote matchgroup=spiceOperator start=+'+ end=+'+

highlight link spiceOperator		Operator
highlight link spiceSinglequote	spiceExpr
highlight link spiceExpr		Function

" Strings
syntax region spiceString start=/\v"/ skip=/\v\\./ end=/\v"/

highlight link spiceString		String

" Errors
syn match spiceParenError ")"

highlight link spiceParenError		Error
" }}}

" Syncs
syn sync minlines=50

" vim: ts=8:fdm=marker:
