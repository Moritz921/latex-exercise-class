\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ExerciseLua}

\LoadClass[a4paper,ngerman]{article}
\RequirePackage{ifluatex}

\RequirePackage[ngerman]{babel}

\ifluatex
    \usepackage[tuenc]{fontspec}
    \setmainfont{cmun}[
        Extension=.otf,
        UprightFont=*rm,
        ItalicFont=*ti,
        BoldFont=*bx,
        BoldItalicFont=*bi,
    ]
\else
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    
    \RequirePackage[autostyle=true,german=quotes]{csquotes}
    
    \RequirePackage{lmodern}% use font latin modern
    \RequirePackage{fix-cm}% overrides restricions on sizes
    \rmfamily% use serif (roman) font family
    \DeclareFontShape{T1}{lmr}{b}{sc}{<->ssub*cmr/bx/sc}{}% declares font for small bold caps
    \DeclareFontShape{T1}{lmr}{bx}{sc}{<->ssub*cmr/bx/sc}{}% declares font for small bold caps
\fi

\RequirePackage[
    a4paper,
    hmargin=18mm,
    vmargin=23mm,
    headsep=15pt,
    marginparwidth=35pt,
    headheight=13pt
]{geometry}

\RequirePackage{graphicx}
\RequirePackage{amsmath,amsfonts,amssymb,amsthm,mathtools}
\RequirePackage{extarrows}% xrightarrow etc. (\arrowname[sub-script]{super-script})
\RequirePackage{commath}% provides commands for easier/better input in math
\RequirePackage{esdiff}% for easy derivatives (\diff)
\RequirePackage{enumitem} % For Enumerate
\RequirePackage{pdflscape}
\RequirePackage{varioref, xfrac}% vref includes the page of not on same + sfrac

\RequirePackage{siunitx}
\sisetup{per-mode=symbol-or-fraction,locale=DE,output-decimal-marker={.}}

\RequirePackage{tikz,pgfplots}
\pgfplotsset{compat=1.18}

\RequirePackage{hyperref}
\RequirePackage{multicol} % Tabular top left field
\RequirePackage{tabularx} % Better tabular(x)

\RequirePackage{ifthen}
\RequirePackage{fancyhdr}% header and footer
\RequirePackage{lastpage}% get last page numberint
\RequirePackage{changepage}% indentation
\RequirePackage{xstring}% length of string
\RequirePackage{cleveref}% For abbrv. befor references
\RequirePackage[autostyle=true,german=quotes]{csquotes}

\DeclareOption{german}
{
    % i18n: deutsch
    \def\uebcsassignment{\"Ubung}
    \def\uebcsexercise{Aufgabe}
    \def\uebcsgroup{Gruppe}
    \def\uebcsmatnr{Mat.-Nr.}
    \def\uebcspagenr{Blatt}
    \def\uebcstutor{Tutor}
}

\DeclareOption{english}
{
    % i18n: english
    \def\uebcsassignment{Assignment}
    \def\uebcsexercise{Exercise}
    \def\uebcsgroup{Group}
    \def\uebcsmatnr{Student ID number}
    \def\uebcspagenr{Page}
    \def\uebcstutor{Tutor}
}

\ProcessOptions\relax

% Exercise environments

\newenvironment{exercise}[1]{{%
        \vspace{1.25ex}%
        \large%
        \noindent\textbf{\uebcsexercise\ #1} %
        \par\vspace{0ex}%
}\begin{adjustwidth}{0.5\parindent}{}}{\end{adjustwidth}}%

%\newenvironment{exerciseAssignment}[1]{{%
%        \vspace{1.25ex}%
%        \large%
%        \noindent\textbf{\uebcsexercise\ \ex@assignment.#1} %
%        \par\vspace{0ex}%
%    }\begin{adjustwidth}{0.5\parindent}{}}{\end{adjustwidth}}%
%
%\newenvironment{exerciseDouble}[2]{{%
%        \vspace{1.25ex}%
%        \large%
%        \noindent\textbf{\uebcsexercise\ #1.#2} %
%        \par\vspace{0ex}%
%    }\begin{adjustwidth}{0.5\parindent}{}}{\end{adjustwidth}}%

% Defining variables for header data
\newcommand{\setLecture}[2][]{%
    \def\lectureLong{#2}%
    \ifthenelse{\equal{#1}{}}{\def\lectureShort{#2}}{\def\lectureShort{#1}}%
}

\newcommand{\setSemester}[1]{\def\semester{#1}}
\newcommand{\setName}[1]{\def\stdName{#1}}
\newcommand{\setStdID}[1]{\def\stdID{#1}}
\newcommand{\setAssignment}[1]{\def\assignment{#1}}

\def\stdGroup{No}
\newcommand{\setGroup}[1]{\def\stdGroup{#1}}

\def\tutor{}
\newcommand{\setTutor}[1]{\def\tutor{\; -- \;#1}}

% Defining header themselves

% short Header
\def\uebcsuebungheader{{
        \vspace*{-16mm}
        \hspace{-7.5mm}
        \LARGE\textsc{\textbf{\lectureLong}}\normalsize
        \hfill
        \stdName\; --\; \stdID
        \vskip1.5mm
        \hspace{-7.5mm}
        \parbox{.333\textwidth}{\large \semester\normalsize \hfill}
        \parbox{.333\textwidth}{\hfil \uebcsassignment\ \assignment\hfil}
        \parbox{.333\textwidth}{\hfill \uebcsgroup\ \stdGroup\tutor}
        \vskip1.5mm
        \hrule
        \vskip1mm
}}
% long Header
\def\uebcsuebungheaderlong{{
        \vspace*{-16mm}
        \hspace{-7.5mm}
        \LARGE\textsc{\textbf{\lectureLong}}\normalsize
        \vskip1.5mm
        \hfill
        \stdName\; --\; \uebcsmatnr: \stdID
        \vskip1.5mm
        \hspace{-7.5mm}
        \parbox{.333\textwidth}{\large \semester\normalsize \hfill}
        \parbox{.333\textwidth}{\hfil \uebcsassignment\ \assignment\hfil}
        \parbox{.333\textwidth}{\hfill \uebcsgroup\ \stdGroup\tutor}
        \vskip1.5mm
        \hrule
        \vskip1mm
}}

% header on all pages except first
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\textsc{\lectureShort}}
\fancyhead[C]{\normalfont \uebcsassignment\ \assignment}
\fancyhead[R]{\stdName\ --\ \stdID}
\fancyfoot[C]{\thepage$\slash$\pageref*{LastPage}}

% header of first page
\fancypagestyle{firstPageStyle}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{\thepage$\slash$\pageref*{LastPage}}
}
\thispagestyle{firstPageStyle}

% Add header to the beginning of the document
\AtBeginDocument{
    \StrLen{\lectureLong}[\uebcslecturelength]%
    \ifthenelse{\uebcslecturelength < 32}{%
        \uebcsuebungheader%
    }{%
        \uebcsuebungheaderlong%
    }%
}%
