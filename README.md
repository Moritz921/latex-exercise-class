# Vorlage für Übungen

## Benutzung
Die Datei `ExerciseLua.csl` im richtigen Ordner abspeichern:

- MacOS: `/Users/$(user)/Library/texmf/tex/latex/commonstuff` 
- Linux: `~/texmf/tex/latex/commonstuff/`
- Windows: `C:/Users/$(user)/texmf/tex/latex/commonstuff`

Ganz am Anfang muss diese Klasse mit der gewünschten Sprache ausgewählt werden mit 
`\documentclass[german]{ExerciseLua}` oder `\documentclass[english]{ExerciseLua}`.

Die benötigten Variablen in der Präambel sind

| Variable | Bedeutung |
| ------ | ------ |
| `\setLecture[]{}` | Name der Veranstaltung [Kürzel der Veranstaltung] |
| `\setSemester{}` | Aktuelles Semester |
| `\setName{}` | Name des Studierenden |
| `\setstdID{}` | Matrikelnummer des Studierenden |
| `\setGroup{}` | Übungsgruppe |
| `\setTutor{}` | Name des Tutors (kann weggelassen werden) |
| `\setAssignment{}` | Nummer des Übungsblatts *zwingend zuletzt und erforderlich* |

Danach kann man loslegen.

## Beispiele
Minimales Beispiel:
```latex
\documentclass[german]{ExerciseLua}
    
\setLecture{kurze Veranstaltung}
\setSemester{Sommer 2022}

\setName{Moritz K}
\setStdID{1234567}
\setGroup{5}
\setTutor{Richard Bock}
\setAssignment{2}

\begin{document}
    \begin{exercise}{1}
        Hello World
    \end{exercise}
\end{document}
```
Stark veraltetes Beispiel aus einer Mathematik Übung:
```latex
\documentclass[german]{Exercise}% /Users/$(User)/Library/texmf/tex/latex/commonstuff

\usepackage{xfrac}
\usepackage{bbm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Defines for mathematical notation. Add additional defines as needed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\pr}[1]{\ensuremath{\mathbf{P}\left(#1\right)}}% probability
\newcommand{\ew}[1]{\ensuremath{\mathbf{E}\left[#1\right]}}% expected value
\newcommand{\var}[1]{\ensuremath{\mathbf{Var}\left[#1\right]}}% variant
\newcommand{\cov}[1]{\ensuremath{\mathbf{Cov}\left[#1\right]}}% covariant
\newcommand{\N}{\ensuremath{\mathbb{N}}}% natural number
\newcommand{\Z}{\ensuremath{\mathbb{Z}}}% whole numbers
\newcommand{\R}{\ensuremath{\mathbb{R}}}% real numbers
\newcommand{\Q}{\ensuremath{\mathbb{Q}}}% rational numbers
\newcommand{\C}{\ensuremath{\mathbb{C}}}% complex numbers
\newcommand{\uz}{\wegde}
\newcommand{\oz}{\vee}
\newcommand*\xor{\ensuremath{\mathbin{\oplus}}}
\newcommand{\ggt}[1]{\ensuremath{\text{ggT}\left(#1\right)}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Enter the lecture name, its abbreviation and semester
\lecture{Stochastik für die Informatik}
\lectureShort{Mathematik 3}
\semester{Winter 2020/21}

% Enter your data: Name, ID, Group and tutor
\stdName{Muster Student}
\stdID{1234567}
\stdGroup{1}
\tutor{\; -- \; Test Tutor}

% Enter the assignment
\assignment{3}

\begin{document}
\begin{exerciseSingle}{26}
    \begin{enumerate}[label=\alph*)]
        \item 
        \item \begin{enumerate}[label=(\roman*)]
            \item 
            \item 
        \end{enumerate}
        \item 
        \item 
        \item 
        \item \begin{enumerate}[label=(\roman*)]
            \item 
            \item 
            \item 
            \item 
        \end{enumerate}
    \end{enumerate}
\end{exerciseSingle}

\begin{exerciseSingle}{W.2}
    \begin{enumerate}[label=\alph*)]
        \item \begin{alignat*}{2}
        	\sigma_{M_n} & = \sqrt{\frac{\var{X}}{n}}                                                          &  \\
        	             & = \sqrt{\frac{\var{X_1 + \ldots + X_n}}{n}}                                         &  \\
        	             & = \sqrt{\frac{\var{X_1} + \ldots + \var{X_n} + 2 \cdot \sum_{i<j}\cov{X_i,X_j}}{n}} & \quad & \bigg\vert\text{Aus Folie AF6a4 Folie 8}       \\
        	             & = \sqrt{\frac{\sum_{i=1}^{n} \var{X_i} + 2 \sum_{i<j}^{} \cov{X_i,X_j}}{n}}         &       & \bigg\vert\text{Aus Aufgabe 24}                \\
        	             & = \sqrt{\frac{n \cdot \sigma^2 + n\left(n-1\right) \cdot \cov{X_1,X_2}}{n}}         &       & \big\vert \text{Aus Folie AF6A5 Folie 9}       \\
        	             & = \sqrt{\frac{n\sigma^2 - n\left(n-1\right)\frac{1}{g-1}\sigma^2}{n}}               &       & \big\vert n \text{ kürzen}                     \\
        	             & = \sqrt{\sigma^2 - \left(n-1\right) \cdot \frac{1}{g-1}\sigma^2}                    &       & \big\vert \sigma^2 \text{ ausklammern}         \\
        	             & = \sqrt{\sigma^2 \cdot \left(1 - \left(n-1\right) \cdot \frac{1}{g-1}\right)}       &       & \bigg\vert\sigma \text{ aus der Wurzel ziehen} \\
        	             & = \sigma \cdot \sqrt{1 - \frac{n-1}{g-1}}                                           &
        \end{alignat*}
        \item 
        \item 
    \end{enumerate}
\end{exerciseSingle}
\end{document}
```
