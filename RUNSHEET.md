# Haskell excursion: run sheet

60 min total: **10 intro (slides) → 40 demo → 10 questions**.
Everything you type is in a `ghci` block. Everything you say is a **Say:** line.
Commands assume you're in the `haskell-excursion` folder.

---

## Before you present (Wednesday morning, 10 min)

1. Open VS Code on this folder: `code ~/Desktop/comp-lang/haskell-excursion`
2. Check the **Haskell** extension is installed (Extensions panel, search "Haskell", publisher: Haskell)
3. Open `demo/01_Basics.hs`, hover over `double`. A type popup appears = the language server works.
4. Open the VS Code terminal (`` Ctrl+` ``), run `ghci`, then `:q`. Works = you're ready.
5. Font size up: `Cmd +` three times in VS Code. Terminal too.

---

## Part A: the environment (0:00 – 5:00)

**Say:** "Haskell's toolchain: GHC is the compiler, GHCi is its interactive REPL, cabal is the package manager, and HLS is the language server that powers the editor."

1. In VS Code, open `demo/01_Basics.hs`. Hover over `square` (it has no type written).
   **Say:** "I never wrote a type for this, but the editor knows it. That's type inference."
2. In `01_Basics.hs`, above `double`, type this comment line, then click **Evaluate…** that appears above it:
   ```haskell
   -- >>> double 21
   ```
   **Say:** "The editor can run code inside comments. Great for docs and quick checks."
   (No **Evaluate…** link? Skip this step; it's a nice-to-have. Test it once before Wednesday.)
3. In the terminal:
   ```ghci
   ghci
   :load demo/01_Basics.hs
   ```
   **Say:** "GHCi commands start with a colon. The ones I'll use: `:load`, `:reload` (`:r`), `:type` (`:t`), `:info` (`:i`), `:quit` (`:q`)."

---

## Part B: basics (5:00 – 15:00) — `01_Basics.hs`

```ghci
answer
double 5
add 3 4
:t add
```
**Say:** "`Int -> Int -> Int`. Every function takes ONE argument and returns a function for the rest. That's currying."

```ghci
addTen 5
:t add 10
:t square
```
**Say:** "`square` works on any `Num` type: Int, Double, whatever. `Num a =>` is a constraint: 'a can be any number type'."

```ghci
square 3
square 2.5
grade 85
hypotenuse 3 4
twice double 5
twice (++ "!") "hi"
doubleThenAddTen 5
```
**Say:** "Functions are values. `twice` takes a function as input."

**Break it on purpose** (audiences love this):
```ghci
answer = 43
double "hello"
```
**Say:** "The first one doesn't change the file, GHCi just shadows the name. The second is a compile-time type error: it's caught BEFORE the program ever runs."

---

## Part C: lists & laziness (15:00 – 25:00) — `02_Lists.hs`

```ghci
:load demo/02_Lists.hs
mySum [1, 2, 3, 4]
myLength "hello"
```
**Say:** "Strings are just lists of characters, so `myLength` works on them too. Pattern matching: one line for empty, one for 'first thing, then the rest'."

```ghci
quicksort [5, 2, 9, 1, 5, 6]
quicksort "haskell"
squares
evens
total
```
**Say:** "map, filter, fold: no loops in Haskell. No `for`, no `while`. Recursion and these three cover everything."

**Laziness** (the wow moment):
```ghci
take 5 naturals
take 15 fibs
fibs !! 100
take 10 primes
```
**Say:** "`naturals` is infinite. Haskell is *lazy*: it only computes what's needed. `fibs` is defined in terms of itself. And `fibs !! 100` is a huge number: `Integer` never overflows."

Show your FizzBuzz:
```ghci
mapM_ (putStrLn . fizzbuzz) [1 .. 15]
```

---

## Part D: types (25:00 – 33:00) — `03_Types.hs`

```ghci
:load demo/03_Types.hs
area (Circle 1)
area (Rectangle 2 3)
totalArea [Circle 1, Rectangle 2 3]
alice
name alice
alice { age = 31 }
alice
```
**Say:** "Updating a record returns a new one. `alice` is untouched: everything is immutable."

```ghci
safeDiv 10 2
safeDiv 10 0
showResult (safeDiv 10 0)
:t safeDiv
```
**Say:** "No null, no null-pointer exceptions. If something can be missing, the type says `Maybe`, and the compiler makes you handle `Nothing`."

```ghci
describe (Circle 2)
describe True
:i Describable
```
**Say:** "Type classes are like interfaces. I made `Describable` and taught it about Shape and Bool."

**Break it on purpose**: in VS Code, comment out the `area (Rectangle w h)` line. A yellow squiggle appears (incomplete patterns). Undo it.
**Say:** "The compiler tells me I forgot a case."

---

## Part E: a real program (33:00 – 40:00) — `04_WordCount.hs`

Quit GHCi (`:q`), then in the terminal:
```bash
runghc demo/04_WordCount.hs < demo/sample.txt
```
**Say:** "`runghc` runs a file like a script."

```bash
ghc -O2 demo/04_WordCount.hs -o wordcount
./wordcount < demo/sample.txt
```
**Say:** "Or compile it to a native binary. Haskell compiles to fast machine code."

Open `04_WordCount.hs` in VS Code and point at the two type signatures.
**Say:** "`wordFreq :: String -> [(String, Int)]` has no `IO`, so it CAN'T print or read files. `main :: IO ()` can. Haskell separates pure logic from side effects, and the type system enforces it."

Point at the `.` chain in `wordFreq`.
**Say:** "Read it bottom-up: split into words, count with a Map, sort by count descending, take 5. A pipeline of small functions."

---

## Part F: questions (40:00 – 50:00+)

| Likely question | Short answer |
|---|---|
| Who uses Haskell? | Meta (spam filter Sigma), GitHub (Semantic code analysis), Standard Chartered, Cardano, Mercury bank. Strong in finance, compilers, and research. |
| Why "lazy"? Isn't that slow? | Lazy = values computed only when needed. Enables infinite lists and avoids wasted work. Downside: memory use can be hard to predict. |
| What's a monad? | A pattern for chaining steps that carry context (maybe-missing, IO, lists). `do` notation in `main` uses the IO monad. Honest answer: "it's a big topic, here's the one-line version". |
| How does it do I/O if it's pure? | IO actions are values describing effects; the runtime executes `main`. The type `IO` marks which code can do it. |
| Haskell vs Python? | Python: dynamic types, mutation, errors at runtime. Haskell: static types, immutability, most errors at compile time. Steeper start, fewer surprises later. |
| Can I learn it? | Free: "Learn You a Haskell" (learnyouahaskell.com), the Haskell MOOC (haskell.mooc.fi). |
| Where's the name from? | Haskell Curry, a logician. Language first defined 1990 by a committee. |

If you don't know: **"Good question, I'm not sure. That's one I'd look up in the Haskell docs."** That's a fine answer.
