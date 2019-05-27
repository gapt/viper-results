# Isaplanner

NOTE: Not up to date.

## Solved
- prop_01
- prop_06
- prop_07
- prop_08
- prop_09
- prop_10
- prop_11
- prop_12
- prop_13
- prop_16
- prop_19
- prop_22
- prop_23
- prop_26
- prop_27
- prop_31
- prop_32

## prop_02:

```
REJECTED:
('+2'(count(#v(ind: Nat), #v(ind_3: list)): Nat,
        count(#v(ind: Nat), #v(ind_1: list))):
    Nat) =
  count(#v(ind: Nat), ++(#v(ind_3: list), #v(ind_1: list)))

COUNTER:
('+2'(count(#c(Z: Nat), cons(#c(Z: Nat), nil:list): list): Nat, #c(Z: Nat)):
    Nat) =
  count(#c(Z: Nat), cons(#c(Z: Nat), nil))
```

Wrongfully because of `count`'s definition with implications doesn't normalise:
```
∀x count(x, nil) = Z,
∀x ∀z ∀ys (==(x, z) → count(x, cons(z, ys)) = S(count(x, ys))),
∀x ∀z ∀ys (¬ ==(x, z) → count(x, cons(z, ys)) = count(x, ys))
```

## prop_03, prop_04, prop_05

Same problem with definition of `count`.

## prop_14

First, why is this case produced:
```
REJECTED:
(filter(s_0:fun12, ++(s_1:list, #v(ind: list)): list): list) =
  ++(filter(s_0, s_1), filter(s_0, #v(ind: list)))
COUNTER:
(filter(s_0:fun12, ++(s_1:list, nil:list): list): list) =
  ++(filter(s_0, s_1), nil)
```

Expected case:
```
REJECTED:
(filter(s_0:fun12, ++(#v(ind_0: list), s_2:list): list): list) =
  ++(filter(s_0, #v(ind_0: list)), filter(s_0, s_2))
COUNTER:
(filter(s_0:fun12, cons(x_0:sk, s_2:list): list): list) =
  (++(filter(s_0, cons(x_0, nil)), filter(s_0, s_2)): list)
```

Definition of `filter`:
```
∀x filter(x, nil) = nil,
∀x ∀z ∀xs (apply12(x, z) → filter(x, cons(z, xs)) = cons(z, filter(x, xs))),
∀x ∀z ∀xs (¬apply12(x, z) → filter(x, cons(z, xs)) = filter(x, xs))
```

We don't synthesise function types and the implication would be a problem.

## prop_15

```
REJECTED:
(len(ins(#v(ind: Nat), #v(ind_0: list)): list): Nat) =
  (S(len(#v(ind_0: list))): Nat)
COUNTER:
(len(ins(#c(Z: Nat), cons(#c(Z: Nat), nil:list): list): list): Nat) =
  S(S(#c(Z: Nat)): Nat)
```

Problem with implications in definition of `ins`:

```
∀x ins(x, nil) = cons(x, nil),
∀x ∀z ∀xs ('<2'(x, z) → ins(x, cons(z, xs)) = cons(x, cons(z, xs))),
∀x ∀z ∀xs (¬'<2'(x, z) → ins(x, cons(z, xs)) = cons(z, ins(x, xs)))
```

## prop_17

Missing reduction rules for `==` and `<=2` for some reason.

## prop_18

```
REJECTED: '<2'(#v(ind: Nat), S('+2'(#v(ind: Nat), s_1:Nat): Nat): Nat): o
COUNTER: '<2'(#c(Z: Nat), S(#c(Z: Nat)): Nat): o
```

Missing reduction rules for `<2` for some reason.

## prop_20

```
REJECTED: (len(sort(#v(ind: list)): list): Nat) = len(#v(ind: list))
COUNTER: (len(insort(S(#c(Z: Nat)): Nat, cons(#c(Z: Nat), nil:list): list): list): Nat) = S(S(#c(Z: Nat)))
```

Definition of `insort` has implications so it doesn't normalise.

## prop_21

```
REJECTED: '<=2'(#v(ind: Nat), '+2'(#v(ind: Nat), s_1:Nat): Nat): o
COUNTER: '<=2'(#c(Z: Nat), #c(Z: Nat)): o
```

Missing reduction rules for `<2`.

## prop_24, prop_25

Missing reduction rules for '<=2'.

## prop_28, prop_29, prop_30

```
REJECTED: elem(s_0:Nat, ++(#v(ind: list), cons(s_0, nil:list): list): list): o
COUNTER: elem(#c(Z: Nat), cons(#c(Z: Nat), nil:list): list): o
```

Definition of `elem`:
```
∀x ¬elem(x, nil),
∀x ∀z ∀xs (elem(x, cons(z, xs)) ↔ ==(x, z) ∨ elem(x, xs))
```

There are no reduction rules for `elem` in the context.

## prop_33

No reduction rules for `==` or `<2`.
