local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Competitive Programming Boilerplate
  s("cp", {
    t({
      "use std::io::stdin;",
      "",
      "fn main(){",
      "\tlet mut input = String::new();",
      "\tstdin().read_line(&mut input).unwrap();",
      "\tlet t: i32 = input.trim().parse().unwrap();",
      "",
      "\tlet mut a"
    }), i(1), t({";", "", "\tfor _ in 0..t {", "\t\t"}), i(2), t({"", "\t}", "}"}),
  }),

  -- Take input line
  s("inp", {
    t("input.clear();"),
    t({"", "stdin().read_line(&mut input).unwrap();"})
  }),

  -- Input to vector
  s("i2v", {
    t("input.trim().split_whitespace().map(|x| x.parse().unwrap()).collect();")
  }),
}
