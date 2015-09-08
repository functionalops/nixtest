{ mkModule, extractor, ... }:
let

  mkExpr = expression: result: { expression = expression; result = result; };

in rec {

  mkExamples = {
    definition = mkModule (extractor "examples");
    documentation = "Makes examples attrset with list of examples for each definition.";
    examples = [
      {
        expression = _: mkExamples.definition { id.examples = [ (mkExpr 1 1) (mkExpr "a" "a") ]; };
        result = { id = [ (mkExpr 1 1) (mkExpr "a" "a") ]; };
      }
    ];
  };

  mkDoc = {
    definition = mkModule (extractor "documentation");
    documentation = "Makes documentation attrset from an attrset of definitions.";
    examples = [
      {
        expression = _: mkDoc.definition { id.documentation = "identity function"; };
        result = { id = "identity function"; };
      }
      {
        expression = mkDoc.definition { id.documentation = "increment function"; };
        result = { id = "increment function"; };
      }
    ];
  };

  mkLib = {
    definition = mkModule (extractor "definition");
    documentation = "Makes library attrset from an attrset of definitions.";
    examples = [
      {
        expression = _: mkLib.definition { id.definition = x: x; };
        result = { id = x: x; };
      }
      {
        expression = builtins.attrNames (mkLib.definition { incr.definition = x: x + 1; });
        result = [ "incr" ];
      }
    ];
  };

}
