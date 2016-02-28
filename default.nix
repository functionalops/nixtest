let

  extractor = field: attrs: name:
    { name = name; value = attrs.${name}.${field}; };

  mkModule = f: attrs:
    let
      mapper = f attrs;
      list = builtins.attrNames attrs;
    in builtins.listToAttrs (map mapper list);

  defs = import ./definitions.nix { inherit mkModule extractor; };

  exports = [ "mkLib" "mkDoc" "mkExamples" ];

in builtins.listToAttrs (map (n: { name = n; value = defs.${n}.definition; }) exports)
