return {
	"sainnhe/sonokai",
	lazy = false,
	priority = 1000,
	init = function()
		vim.o.termguicolors = true

		vim.g.sonokai_enable_italic = 1
		vim.g.sonokai_disable_italic_comment = 1
		vim.g.sonokai_transparent_background = 1

		vim.g.sonokai_dim_inactive_windows = 1

		vim.g.sonokai_diagnostic_text_highlight = 1
		vim.g.sonokai_diagnostic_virtual_text = "colored"
		vim.g.sonokai_better_performance = 1
	end,
	config = function()
		-- TODO: lua化
		vim.cmd([[
function! s:sonokai_custom() abort
    " lspsagaのversion0.2.3からhighlight
    " group名が変更になったためsonokaiで定義されているカラーと手動でリンクさせる
    " sonokai側で対応が行われたら削除すること
    "highlight! link TitleString LspSagaDiagnosticHeader
    highlight! link TitleSymbol LspSagaCodeActionTitle
    highlight! link TitleIcon LspSagaCodeActionTitle

    highlight! link FinderSelection LspSagaFinderSelection
    highlight! link FinderFileName TargetFileName
    "highlight! link FinderCount ReferencesCount
    "highlight! link FinderIcon ReferencesCount
    "highlight! link FinderType ReferencesCount
    "highlight! link FinderVirtText Fg
    highlight! link FinderNormal Fg
    highlight! link FinderBorder LspSagaDefPreviewBorder
    highlight! link FinderPreviewBorder LspSagaDefPreviewBorder

    highlight! link DefinitionNormal Fg
    highlight! link DefinitionBorder LspSagaDefPreviewBorder

    highlight! link RenameNormal Fg
    highlight! link RenameBorder LspSagaRenameBorder
    highlight! link RenameMatch LspSagaRenamePromptPrefix

    highlight! link DiagnosticSource LspSagaDiagnosticHeader
    highlight! link DiagnosticNormal Fg
    highlight! link DiagnosticBorder LspSagaDiagnosticBorder
    highlight! link DiagnosticError LspSagaDiagnosticError
    highlight! link DiagnosticWarn LspSagaDiagnosticWarn
    highlight! link DiagnosticHint LspSagaDiagnosticHint
    highlight! link DiagnosticInfo LspSagaDiagnosticInfo
    highlight! link DiagnosticErrorBorder LspSagaDiagnosticError
    highlight! link DiagnosticWarnBorder LspSagaDiagnosticWarn
    highlight! link DiagnosticHintBorder LspSagaDiagnosticHint
    highlight! link DiagnosticInfoBorder LspSagaDiagnosticInfo
    highlight! link DiagnosticPos LspSagaDiagnosticSource
    highlight! link DiagnosticWord LspSagaDiagnosticSource

    "highlight! link DiagnosticText Red
    "highlight! link DiagnosticTitleSymbol Red
    "highlight! link DiagnosticMsgIcon Red
    "highlight! link DiagnosticMsg Red
    "highlight! link DiagnosticActionTitle LspSagaCodeActionTitle
    "highlight! link DiagnosticTitleSymbol LspSagaDiagnosticHeader

    highlight! link ActionPreviewNormal Fg
    highlight! link ActionPreviewBorder LspSagaCodeActionBorder
    highlight! link CodeActionNormal Fg
    highlight! link CodeActionBorder LspSagaCodeActionBorder

    highlight! link HoverNormal Fg
    highlight! link HoverBorder LspSagaHoverBorder

    " completion menu customize
    highlight! link NormalFloat Fg
    highlight! link FloatBorder Fg
    highlight! link Pmenu Fg
    highlight! link PmenuSel CustomPmenuSel

    " Check: inlayHint Color, add feature neovim version 0.10.
    highlight! link LspInlayHint Comment

    let l:palette = sonokai#get_palette('default', {})
    call sonokai#highlight('CustomPmenuSel', l:palette.fg, l:palette.bg2)
endfunction

augroup SonokaiCustom
    autocmd!
    autocmd ColorScheme sonokai call s:sonokai_custom()
augroup END
        ]])

		vim.cmd("colorscheme sonokai")
	end,
}
