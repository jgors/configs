// disable the automatic insertion of closing braces, brackets, and parentheses
IPython.CodeCell.options_default.cm_config.autoCloseBrackets = false;

// disable cursor blinking
IPython.Cell.options_default.cm_config.cursorBlinkRate=0;

// Configure CodeMirror
require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
  ], function() {
    // Map jj to <Esc>
    CodeMirror.Vim.map("jj", "<Esc>", "insert");

    // Move to beg of line (H) or end of line (L).
    CodeMirror.Vim.map("H", "^", "normal");
    CodeMirror.Vim.map("H", "^", "visual");
    CodeMirror.Vim.map("L", "$", "normal");
    CodeMirror.Vim.map("L", "$", "visual");

    // turn off highlighting for all highlighted stuff
    CodeMirror.Vim.map("<Space>", ":noh", "normal");

    //CodeMirror.Vim.map(",h", "<", "visual");
    //CodeMirror.Vim.map(",l", ">", "visual");

    CodeMirror.Vim.map(";", ":", "normal");

    // comment out all stuff visually highlighted
    // (these result in highlighted stuff at beg of lines)
    CodeMirror.Vim.map("c", ":'<,'>s/^/# /", "visual");
    // uncomment out all stuff visually highlighted
    CodeMirror.Vim.map("u", ":'<,'>s/# /", "visual");

    // custom operator for commenting
    // this works with visual selection ('vipc') and with motions ('cip')
    //CodeMirror.Vim.defineOperator("comment_op", function(cm) {
        //cm.toggleComment()});
    //CodeMirror.Vim.mapCommand("c", "operator", "comment_op", {});

    // Swap j/k and gj/gk (Note that <Plug> mappings)
    CodeMirror.Vim.map("j", "<Plug>(vim-binding-gj)", "normal");
    CodeMirror.Vim.map("k", "<Plug>(vim-binding-gk)", "normal");
    CodeMirror.Vim.map("gj", "<Plug>(vim-binding-j)", "normal");
    CodeMirror.Vim.map("gk", "<Plug>(vim-binding-k)", "normal");
});
