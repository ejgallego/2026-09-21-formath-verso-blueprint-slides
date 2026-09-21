import VersoBlueprint

namespace ForMathDemo

/-- A left inverse recovers the input after applying the original function. -/
@[blueprint "left_inverse"]
def LeftInverse (f g : Nat → Nat) : Prop :=
  ∀ x, g (f x) = x

/-- A function is injective when equal images have equal preimages. -/
@[blueprint "injective"]
def Injective (f : Nat → Nat) : Prop :=
  ∀ x y, f x = f y → x = y

/-- Applying a function preserves equality. -/
@[blueprint "equality_transport"]
theorem transportEq (g : Nat → Nat) {a b : Nat} (h : a = b) :
    g a = g b := congrArg g h

end ForMathDemo
