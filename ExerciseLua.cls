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

\newlength{\myTextwidth}
\setlength{\myTextwidth}{495.07797pt}

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

%\RequirePackage{hyperref}
\RequirePackage{multicol} % Tabular top left field
\RequirePackage{tabularx} % Better tabular(x)

\RequirePackage{ifthen}
\RequirePackage{fancyhdr}% header and footer
\RequirePackage{lastpage}% get last page numberint
\RequirePackage{changepage}% indentation
\RequirePackage{xstring}% length of string
%\RequirePackage{cleveref}% For abbrv. befor references
\RequirePackage[autostyle=true,german=quotes]{csquotes}
\RequirePackage{printlen}
\RequirePackage{calc}

% Define coordinate system relative to page
\makeatletter
\def\parsecomma#1,#2\endparsecomma{\def\page@x{#1}\def\page@y{#2}}
\tikzdeclarecoordinatesystem{page}{
    \parsecomma#1\endparsecomma
    \pgfpointanchor{current page}{north east}
    % Save the upper right corner
    \pgf@xc=\pgf@x%
    \pgf@yc=\pgf@y%
    % save the lower left corner
    \pgfpointanchor{current page}{south west}
    \pgf@xb=\pgf@x%
    \pgf@yb=\pgf@y%
    % Transform to the correct placement
    \pgfmathparse{(\pgf@xc-\pgf@xb)/2.*\page@x+(\pgf@xc+\pgf@xb)/2.}
    \expandafter\pgf@x\expandafter=\pgfmathresult pt
    \pgfmathparse{(\pgf@yc-\pgf@yb)/2.*\page@y+(\pgf@yc+\pgf@yb)/2.}
    \expandafter\pgf@y\expandafter=\pgfmathresult pt
}
\makeatother


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

\DeclareOption{bw}{
    \def\uebColorful{False}
    \definecolor{goetheblau}{RGB}{0,0,0}
    \definecolor{senfgelb}{RGB}{0,0,0}
    \definecolor{emorot}{RGB}{0,0,0}
    \definecolor{betterGreen}{RGB}{0,0,0}
}

\DeclareOption{colorful}{
    \def\uebColorful{True}
    \definecolor{goetheblau}{HTML}{00618F}
    \definecolor{senfgelb}{RGB}{227,186,15}
    \definecolor{emorot}{RGB}{179,6,44}
    \definecolor{betterGreen}{RGB}{115,224,69}
}

\newlength{\headerOffset}%
\setlength{\headerOffset}{-7.5mm}%

\ExecuteOptions{german,bw}%
\ProcessOptions\relax

% Exercise environments

\newenvironment{exercise}[1]{{%
        \vspace{1.25ex}%
        \large%
        \noindent\textbf{\uebcsexercise\ #1} %
        \par\vspace{0ex}%
}\begin{adjustwidth}{0.5\parindent}{}}{\end{adjustwidth}}%

\newenvironment{exerciseAss}[1]{{%
       \vspace{1.25ex}%
       \large%
       \noindent\textbf{\uebcsexercise\ \assignment.#1} %
       \par\vspace{0ex}%
   }\begin{adjustwidth}{0.5\parindent}{}}{\end{adjustwidth}}%
%
%\newenvironment{exerciseDouble}[2]{{%
%        \vspace{1.25ex}%
%        \large%
%        \noindent\textbf{\uebcsexercise\ #1.#2} %
%        \par\vspace{0ex}%
%    }\begin{adjustwidth}{0.5\parindent}{}}{\end{adjustwidth}}%

% Defining variables for header data
% \gdef\lectureLong{}
\newcommand{\setLecture}[2][]{%
    \gdef\lectureLong{#2}%
    \ifthenelse{\equal{#1}{}}{\def\lectureShort{#2}}{\def\lectureShort{#1}}%
}

\newcommand{\setSemester}[1]{\def\semester{#1}}
\newcommand{\setName}[1]{\def\stdName{#1}}
\newcommand{\setStdID}[1]{\def\stdID{#1}}

\newcommand{\setAssignment}[1]{\def\assignment{#1}}%

\def\stdGroup{No}
\newcommand{\setGroup}[1]{\def\stdGroup{#1}}

\def\tutor{}
\newcommand{\setTutor}[1]{\def\tutor{\; -- \;#1}}

% Defining header themselves

% short Header
\def\uebcsuebungheader{{
        \vspace*{-16mm}
        \hspace{\headerOffset}
        \LARGE\textsc{\textbf{\color{goetheblau}\lectureLong}}\normalsize
        \hfill
        \stdName\; --\; \stdID
        \vskip1.5mm
        \hspace{\headerOffset}
        \parbox{.333\textwidth}{\large \semester\normalsize \hfill}
        \parbox{.333\textwidth}{\color{goetheblau}\hfil \uebcsassignment\ \assignment\hfil}
        \parbox{.333\textwidth}{\hfill \uebcsgroup\ \stdGroup\tutor}
        \vskip1.5mm
        {\color{goetheblau}\hrule height 1px }
        \vskip1mm
}}
% long Header
\def\uebcsuebungheaderlong{{
        \vspace*{-16mm}
        \hspace{\headerOffset}
        \LARGE\textsc{\textbf{\color{goetheblau}\lectureLong}}\normalsize
        \vskip1.5mm
        \hfill
        \stdName\; --\; \uebcsmatnr: \stdID
        \vskip1.5mm
        \hspace{\headerOffset}
        \parbox{.333\textwidth}{\large \semester\normalsize \hfill}
        \parbox{.333\textwidth}{\color{goetheblau}\hfil \uebcsassignment\ \assignment\hfil}
        \parbox{.333\textwidth}{\hfill \uebcsgroup\ \stdGroup\tutor}
        \vskip1.5mm
        {\color{goetheblau}\hrule height 1px }
        \vskip1mm
}}

% header on all pages except first
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\textsc{\lectureShort}}
\fancyhead[C]{{\color{goetheblau}\normalfont \uebcsassignment\ \assignment}}
\fancyhead[R]{{\stdName\ --\ \stdID}}
\fancyfoot[C]{{\color{goetheblau}\thepage$\slash$\pageref*{LastPage}}}

% header of first page
\let\oldheadrule\headrule% Copy \headrule into \oldheadrule
\renewcommand{\headrule}{\color{goetheblau}\oldheadrule}% Add colour to \headrule
\renewcommand{\headrulewidth}{1px}
\fancypagestyle{firstPageStyle}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{{\color{goetheblau}\thepage$\slash$\pageref*{LastPage}}}
}
\thispagestyle{firstPageStyle}

\ProcessOptions

% Add header to the beginning of the document
\AtBeginDocument{
    \newlength{\lengthNameID}%
    \newlength{\lengthStdName}%
    \newlength{\halfTextwidth}%
    \newlength{\lengthHeaderFirstLine}%
    \newlength{\lengthOverfullFirstLine}%
    \settowidth{\lengthNameID}{\stdName\ --\ \stdID}%
    \settowidth{\lengthStdName}{\stdName}%
    \settowidth{\lengthHeaderFirstLine}{\LARGE\textsc{\textbf{\lectureLong}}\normalsize\hfill\stdName\; --\; \stdID}%
    \setlength{\lengthOverfullFirstLine}{\myTextwidth - (\lengthHeaderFirstLine + \headerOffset)}
    \setlength{\halfTextwidth}{0.45\myTextwidth}
    \def\zuLangKurs{}

    \ifthenelse{\lengthOverfullFirstLine < 0}{%
        \def\zuLangKurs{True}%
        \uebcsuebungheaderlong%
    }{%
        \def\zuLangKurs{False}
        \uebcsuebungheader%
    }%

    \ifthenelse{\lengthNameID > \halfTextwidth}{%
        \ifthenelse{\lengthStdName > \halfTextwidth}{%
            \newlength{\heightCorrection}%
            \setlength{\heightCorrection}{-\baselineskip-1ex}%
            \newlength{\bigHeaderHeight}%
            \settototalheight{\bigHeaderHeight}{\parbox[t]{\halfTextwidth}{\vspace*{\heightCorrection}\begin{flushright}\stdName\end{flushright}}}%
            \fancyhead[R]{\parbox[t]{\halfTextwidth}{\vspace*{\heightCorrection}\begin{flushright}\stdName\end{flushright}}}%
            \geometry{headsep=\bigHeaderHeight}%
        }{%
            \fancyhead[R]{\stdName}%
        }%
    }{}%
}%
