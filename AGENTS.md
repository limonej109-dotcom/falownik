# AGENTS.md — kontekst pracy dla agentów AI

Repozytorium zawiera **projekt dyplomowy (pracę inżynierską)** pisany w LaTeX-u
na szablonie AGH (`Config/EngineeringThesis.cls`). Temat: **jednofazowy falownik
napięcia (mostek H) jako stanowisko laboratoryjne** — projekt, symulacje,
prototyp, badania i ocena przydatności dydaktycznej.

Język pracy i komunikacji: **polski**, z pełną terminologią techniczną.

---

## 1. Sposób pracy (workflow)

- **Agent (Claude) edytuje pliki, robi commity i pushe** do gałęzi `main`
  na GitHubie.
- **Autor tylko pobiera zmiany (pull) w Overleafie** (synchronizacja
  Overleaf ↔ GitHub) i tam czyta oraz kompiluje pracę.
- Przed każdym pushem agent:
  1. robi `git pull --rebase`, żeby nie nadpisać zmian wprowadzonych w Overleafie,
  2. kompiluje całą pracę (XeLaTeX + BibTeX) i sprawdza, czy nie ma błędów,
     nierozwiązanych odnośników (`??`) ani cytowań,
  3. commituje tylko pliki źródłowe (patrz `.gitignore`), nigdy PDF-a ani
     plików pomocniczych.
- Wiadomości commitów po polsku, krótko i rzeczowo, np.
  `Rozdział 4: dobór tranzystorów MOSFET`.
- Bez pytania **nie zmieniać** `Config/EngineeringThesis.cls` ani strony
  tytułowej. Zmiany w preambule `0_EngineeringThesis.tex` tylko wtedy, gdy są
  potrzebne (np. nowy pakiet), i z opisem w commicie.

## 2. Kompilacja

- Kompilator: **XeLaTeX** (klasa używa `fontspec`). W Overleafie:
  *Menu → Compiler → XeLaTeX*.
- Kolejność: `xelatex → bibtex → xelatex → xelatex`.
- Plik główny: `0_EngineeringThesis.tex`.
- Strona tytułowa wymaga fontów *Inter* i *TeX Gyre Heros* oraz pakietu `svg`
  (logo AGH). Przy kompilacji lokalnej bez tych fontów można tymczasowo
  zakomentować `\thesistitlepagepl` — **nie commitować tej zmiany**.
- Znany problem z szablonu: BibTeX zgłasza błąd w `Config/IEEEtranDOI.bst`
  (linia 1440, `"$" can't follow a literal`). Bibliografia mimo to generuje się
  poprawnie.
- Znany problem z szablonu: `\titleformat{\chapter}` w `Text/4_Symbols.tex`
  działa także na kolejne rozdziały, przez co rozdziały wyświetlają się bez
  numeru. Do decyzji autora.

## 3. Struktura repozytorium

```
0_EngineeringThesis.tex      plik główny (preambuła, kolejność rozdziałów)
Config/                      klasa, styl bibliografii, Bibliography.bib
Text/                        rozdziały (jeden plik = jeden rozdział)
Pictures/<n>_<Nazwa>/        rysunki danego rozdziału (TikZ .tex, SVG, PNG)
Scripts/                     skrypty generujące dane do rysunków
```

Mapowanie rozdziałów na pliki:

| Nr | Rozdział | Plik |
|----|----------|------|
| — | Wykaz akronimów | `Text/3_Acronyms.tex` |
| — | Wykaz oznaczeń | `Text/4_Symbols.tex` |
| 1 | Wprowadzenie (1.1 Cel i zakres pracy, 1.2 Założenia projektowe, 1.3 Struktura pracy) | `Text/5_Introduction.tex` |
| 2 | Falowniki jednofazowe – podstawy teoretyczne | `Text/6_1_OnePhaseInverters-Theory.tex` |
| 3 | Charakterystyka projektowanego stanowiska laboratoryjnego | `Text/6_2_CharacteristicsOfLaboratorySetup.tex` |
| 4 | Dobór elementów obwodu mocy falownika | `Text/6_3_PowerCircuitProject.tex` |
| 5 | Symulacje | `Text/6_4_Simulations.tex` |
| 6 | Wykonanie modelu falownika | `Text/6_5_InverterPrototype.tex` |
| 7 | Badania eksperymentalne | `Text/6_6_Experiment.tex` |
| 8 | Ocena przydatności dydaktycznej stanowiska | `Text/6_7_DidacticInverterUsage.tex` |
| — | Podsumowanie | `Text/7_Summary.tex` |

Stan na 2026-11-16: **rozdział 2 napisany w całości**, pozostałe rozdziały to
szkielety z nagłówkami podrozdziałów.

## 4. Konwencje redakcyjne (AGH)

- Forma bezosobowa („zaprojektowano”, „przyjęto”), bez „ja”/„my”.
- **Twarde spacje** po jednoliterowych wyrazach: `w~`, `z~`, `i~`, `a~`, `o~`,
  `u~` (bez „sierotek” na końcu wiersza).
- Etykiety w stylu szablonu: `\label{chap: Tytuł rozdziału}`,
  `\label{sec: Tytuł podrozdziału}`, a dla obiektów: `fig:…`, `tab:…`,
  `eq:…`. Do innych rozdziałów odwoływać się przez `\ref{chap: …}`, nie przez
  numer wpisany na sztywno.
- Wzory numerowane w obrębie rozdziału. Po wzorze objaśnienie symboli
  w środowisku szablonu:
  ```latex
  gdzie:
  \begin{conditions}
    U_\mathrm{DC} & napięcie obwodu pośredniczącego, \\
    f_\mathrm{s}  & częstotliwość łączeń.
  \end{conditions}
  ```
- Rysunki: podpis **pod** rysunkiem, tabele: podpis **nad** tabelą. Pod
  każdym rysunkiem i tabelą linia ze źródłem:
  `\zrodlo{opracowanie własne}` albo
  `\zrodlo{opracowanie własne na podstawie~\cite{…}}`.
- Rysunki rysowane w TikZ/circuitikz/pgfplots jako osobne pliki
  w `Pictures/<n>_<Nazwa>/` i wstawiane przez `\input{Pictures/...}`.
- Indeksy dolne opisowe pismem prostym: `U_\mathrm{DC}`, `f_\mathrm{s}`.
- Liczby z jednostkami przez `siunitx` (`\SI{100}{\volt}`); przecinek
  dziesiętny (`locale = PL`).
- Cytowania: `\cite{klucz}`, wpisy w `Config/Bibliography.bib`, styl
  `IEEEtranDOI`. Nie wymyślać pozycji literaturowych. Jeśli danych nie da się
  zweryfikować, oznaczyć wpis komentarzem `% UZUPEŁNIĆ`.

### Oznaczenia używane w pracy (trzymać się ich konsekwentnie)

| Symbol | Znaczenie |
|--------|-----------|
| `U_\mathrm{DC}` | napięcie obwodu pośredniczącego (DC) |
| `C_\mathrm{DC}` | pojemność obwodu pośredniczącego |
| `u_\mathrm{o}`, `i_\mathrm{o}` | napięcie i prąd wyjściowy falownika |
| `u_\mathrm{aN}`, `u_\mathrm{bN}` | napięcia gałęzi a i b względem bieguna N |
| `s_\mathrm{a}`, `s_\mathrm{b}` | funkcje przełączające gałęzi |
| `Q_1`–`Q_4` | tranzystory mostka (gałąź a: Q1 górny, Q2 dolny; gałąź b: Q3 górny, Q4 dolny) |
| `f_\mathrm{s}`, `T_\mathrm{s}` | częstotliwość i okres łączeń (nośnej) |
| `f_1` | częstotliwość podstawowa napięcia wyjściowego |
| `m_\mathrm{a}`, `m_\mathrm{f}` | współczynniki modulacji amplitudowej i częstotliwościowej |
| `t_\mathrm{d}` | czas martwy |
| `L_\mathrm{f}` | indukcyjność dławika filtru wyjściowego |

Nowe oznaczenia i akronimy dopisywać też do `Text/4_Symbols.tex`
i `Text/3_Acronyms.tex`.

## 5. Kontekst techniczny projektu

Dane do kolejnych rozdziałów (3–7). Przed użyciem w tekście warto potwierdzić
z autorem, czy nadal są aktualne.

- **Topologia:** jednofazowy mostek H na tranzystorach MOSFET, 4 w pełni
  izolowane kanały sterowania bramkowego.
- **Zasilanie obwodu DC:** z zasilacza laboratoryjnego (nie z prostownika
  sieciowego). Maksymalnie **100 V / 10 A**, częstotliwość wyjściowa **50 Hz**.
- **Kondensatory DC:** 4,4 mF (2 × 2200 µF, elektrolityczne), z rezystorem
  rozładowczym załączanym przekaźnikiem.
- **Tranzystory:** IRFP4568PbF (TO-247, 150 V, R_DS(on) = 4,8 mΩ),
  montowane w podstawce na płytce mocy.
- **Sterowniki bramkowe:** UCC27511A (4 A / 8 A).
  - Napięcia bramki: V_GS(on) = +12 V, V_GS(off) = −5 V (razem 17 V, przy
    dopuszczalnym zakresie 4,5–18 V).
  - IN+ to sygnał PWM, IN− na GND (może służyć jako sprzętowe wyłączenie).
  - Q_g ≈ 190 nC, co przy 100 kHz daje średnio ok. 19 mA na kanał.
- **Izolowane zasilanie każdego kanału:**
  - SN6507 (sterownik push-pull), wejście 12 V, UVLO ustawione dzielnikiem.
  - Transformator Würth 750319692 (przekładnia 1,4:1) z uzwojeniem z odczepem
    środkowym i prostownikiem, co daje ok. ±15 V.
  - Podwójny LDO TPS7A39 (jeden na kanał), wyjścia +12 V / −5 V względem
    źródła tranzystora.
  - Dzielniki: R1P = 90,9 kΩ, R2P = 10 kΩ; R1N = 42,2 kΩ, R2N = 10 kΩ.
- **Zabezpieczenie nadprądowe:**
  - Próg 10 A, pomiar 100 mV/A na boczniku: wzmacniacz różnicowy OPA192
    i komparator okienkowy TLV183x (±1 V).
  - Sygnały OV/OC przechodzą na stronę mikrokontrolera przez izolator ISO7720.
- **PCB:** KiCad, 4 warstwy, produkcja JLCPCB. Symulacje w ngspice.
- **Do zrobienia:** snubbery RC, filtr wyjściowy LC, pomiar napięcia DC,
  generator PWM z czasem martwym, bezpieczniki wejściowe, filtr EMI,
  zarządzanie temperaturą.

## 6. Otwarte sprawy w tekście

- `Config/Bibliography.bib`, wpis `instrukcja`: uzupełnić autorów i rok
  instrukcji „Falowniki jednofazowe – zajęcia symulacyjne” (AGH, KEiASPE).
- Zweryfikować w katalogu biblioteki dane pozycji `barlik1998`.
- Rozdział 2, akapit końcowy podrozdziału 2.4: sprawdzić, czy opis
  możliwości stanowiska zgadza się z rozdziałem 3.
- Dane autora, tytuł pracy i promotora w `0_EngineeringThesis.tex` są jeszcze
  przykładowe (z szablonu).
