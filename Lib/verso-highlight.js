(function () {
  "use strict";

  function registerVerso(hljs) {
    if (!hljs || typeof hljs.registerLanguage !== "function") return;
    if (typeof hljs.getLanguage === "function" && hljs.getLanguage("verso")) return;

    hljs.registerLanguage("verso", function (hljs) {
      var STRING = hljs.QUOTE_STRING_MODE;
      var INLINE_TICK = {
        className: "code",
        begin: /`/,
        end: /`/
      };
      var INLINE_MATH_CODE = {
        className: "formula",
        begin: /\$`/,
        end: /`/
      };
      var NAMED_ARG = {
        className: "attr",
        begin: /\b[A-Za-z_][A-Za-z0-9_-]*(?=\s*:=)/
      };
      var DIRECTIVE = {
        className: "keyword",
        begin: /^:{3,}\s*[A-Za-z_][A-Za-z0-9_-]*/m
      };
      var DIRECTIVE_CLOSE = {
        className: "keyword",
        begin: /^:{3,}\s*$/m
      };
      var ROLE = {
        className: "title",
        begin: /\{[A-Za-z_][A-Za-z0-9_-]*/,
        end: /\}\[\]/,
        contains: [STRING]
      };

      return {
        name: "Verso",
        aliases: ["vbp"],
        contains: [
          DIRECTIVE,
          DIRECTIVE_CLOSE,
          ROLE,
          NAMED_ARG,
          STRING,
          INLINE_MATH_CODE,
          INLINE_TICK
        ],
        illegal: /<\/|<script/
      };
    });
  }

  window.registerVersoHighlight = registerVerso;

  if (window.hljs) {
    registerVerso(window.hljs);
  }
})();
