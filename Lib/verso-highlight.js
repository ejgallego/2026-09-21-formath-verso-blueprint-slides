(function () {
  "use strict";

  function registerVerso(hljs) {
    if (!hljs || typeof hljs.registerLanguage !== "function") return;
    if (!hljs.getLanguage("lean")) {
      hljs.registerLanguage("lean", function (hljs) {
        return {
          name: "Lean",
          keywords: {
            keyword: "import open namespace end theorem lemma def example abbrev structure " +
              "inductive class instance variable section by exact intro apply calc simp " +
              "rfl have show from fun match with where let in if then else do return",
            built_in: "Nat Int Prop Type Sort",
            literal: "true false"
          },
          contains: [
            hljs.COMMENT(/--/, /$/),
            hljs.COMMENT(/\/-/, /-\//, { contains: ["self"] }),
            { className: "meta", begin: /@\[/, end: /\]/,
              contains: [hljs.QUOTE_STRING_MODE] },
            hljs.QUOTE_STRING_MODE,
            hljs.NUMBER_MODE
          ]
        };
      });
    }
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
          { begin: /^```lean\b[^\n]*\n/m, end: /^```\s*$/m,
            subLanguage: "lean", excludeBegin: true, excludeEnd: true },
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
