\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Exercise}

\LoadClass[a4paper]{article}


\RequirePackage[ngerman]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[autostyle=true,german=quotes]{csquotes}

\RequirePackage{lmodern}% use font latin modern
\RequirePackage{fix-cm}% overrides restricions on sizes
\rmfamily% use serif (roman) font family
\DeclareFontShape{T1}{lmr}{b}{sc}{<->ssub*cmr/bx/sc}{}% declares font for small bold caps
\DeclareFontShape{T1}{lmr}{bx}{sc}{<->ssub*cmr/bx/sc}{}% declares font for small bold caps

\RequirePackage[a4paper,hmargin=18mm,vmargin=23mm,headsep=15pt,marginparwidth=35pt]{geometry}
\RequirePackage{graphicx}
\RequirePackage{amsmath,amsfonts,amssymb,amsthm,mathtools}
\RequirePackage{extarrows}% xrightarrow etc. (\arrowname[sub-script]{super-script})
\RequirePackage{commath}% provides commands for easier/better input in math
\RequirePackage{esdiff}% for easy derivatives (\diff)
\RequirePackage{enumitem} % For Enumerate
\RequirePackage{pdflscape}
\RequirePackage{varioref}% vref includes the page of not on same

\RequirePackage{fontawesome5}% for calculator symbol

\RequirePackage{siunitx}
\sisetup{per-mode=symbol-or-fraction,binary-units=true,locale=DE,output-decimal-marker={.}}

\RequirePackage{tikz,pgfplots}
\pgfplotsset{compat=1.17}

\RequirePackage{hyperref}
\RequirePackage{multicol} % Tabular top left field
\RequirePackage{tabularx} % Better tabular(x)

\RequirePackage{ifthen}
\RequirePackage{fancyhdr}% header and footer
\RequirePackage{lastpage}% get last page numberint
\RequirePackage{changepage}% indentation
\RequirePackage{xstring}% length of string


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


% Command for creating mandatory and optional variables
\newcommand{\DeclareLectureVariable}{%
    \@ifstar{\ex@DeclareLectureVariable{\ex@mandatory@var}}
            {\ex@DeclareLectureVariable{\ex@optional@var}}%
}%

\newcommand{\ex@DeclareLectureVariable}[2]{%
    \@namedef{ex@#2}{#1{#2}}%
    \@namedef{#2}##1{\@namedef{ex@#2}{##1}\@namedef{ex@#2@defined}{}}%
}

\newcommand{\@iflecturevariable}[3]{\@ifundefined{ex@#1@defined}{#3}{#2}}

% The error and info messages
\newcommand{\ex@mandatory@var}[1]{%
    \ClassError{Exercise}
    {Missing value for mandatory variable
        \expandafter\string\csname#1\endcsname}
    {You have to provide a value with
        \expandafter\string\csname#1\endcsname{...}}%
}
\newcommand{\ex@optional@var}[1]{%
    \ClassInfo{Exercise}
    {Missing value for optional variable
        \expandafter\string\csname#1\endcsname}%
}

%% Do the branching between * and normal version
%\newcommand{\DeclareAuthorVariable}{%
%    \@ifstar{\ting@DeclareAuthorVariable{\ting@mandatory@var}}
%    {\ting@DeclareAuthorVariable{\ting@optional@var}}%
%}
%
%% The main command; the internal version of \foo is \ting@foo
%% The macro \ting@foo is initialized to give an error or an info
%% message when used, so if the user doesn't provide a value for a
%% mandatory variable, we'll catch the issue
%\newcommand{\ting@DeclareAuthorVariable}[2]{%
%    \@namedef{ting@#2}{#1{#2}}%
%    \@namedef{#2}##1{\@namedef{ting@#2}{##1}\@namedef{ting@#2@defined}{}}%
%}
%\newcommand{\@ifauthorvariable}[3]{\@ifundefined{ting@#1@defined}{#3}{#2}}
%% The error and info messages
%\newcommand{\ting@mandatory@var}[1]{%
%    \ClassError{ting}
%    {Missing value for mandatory variable
%        \expandafter\string\csname#1\endcsname}
%    {You have to provide a value with
%        \expandafter\string\csname#1\endcsname{...}}%
%}
%\newcommand{\ting@optional@var}[1]{%
%    \ClassInfo{ting}
%    {Missing value for optional variable
%        \expandafter\string\csname#1\endcsname}%
%}
%
%%%% Define two variables
%
%\DeclareAuthorVariable*{title}
%\DeclareAuthorVariable{subtitle}
%\@ifauthorvariable{subtitle}{\vspace{3ex}\textsc{\ting@subtitle}\par\vspace{3ex}}{\vspace{1ex}---\par\vspace{1ex}}

\DeclareLectureVariable*{lecture}
\DeclareLectureVariable*{lectureShort}
\DeclareLectureVariable*{semester}

\DeclareLectureVariable*{stdName}
\DeclareLectureVariable*{stdID}
\DeclareLectureVariable*{stdGroup}
\DeclareLectureVariable{tutor}

\DeclareLectureVariable*{assignment}

% This environment sets the spaces around the exercises
\newenvironment{exercise}[1]{{%
        \vspace{1.25ex}%
        \large%
        \noindent\textbf{\uebcsexercise\ \ex@assignment.#1} %
        \par\vspace{0ex}%
    }\begin{adjustwidth}{0.5\parindent}{}}{\end{adjustwidth}}%

\newenvironment{exerciseDouble}[2]{{%
        \vspace{1.25ex}%
        \large%
        \noindent\textbf{\uebcsexercise\ #1.#2} %
        \par\vspace{0ex}%
    }\begin{adjustwidth}{0.5\parindent}{}}{\end{adjustwidth}}%

\newenvironment{exerciseSingle}[1]{{%
        \vspace{1.25ex}%
        \large%
        \noindent\textbf{\uebcsexercise\ #1} %
        \par\vspace{0ex}%
    }\begin{adjustwidth}{0.5\parindent}{}}{\end{adjustwidth}}%

% Definition of the assignment header
\def\uebcsuebungheader{{
        \vspace*{-16mm}
        \hspace{-7.5mm}
        \LARGE\textsc{\textbf{\ex@lecture}}\normalsize
        \hfill
        \ex@stdName\; --\; \ex@stdID
        \vskip1.5mm
        \hspace{-7.5mm}
        \parbox{.333\textwidth}{\large \ex@semester\normalsize \hfill}
        \parbox{.333\textwidth}{\hfil \uebcsassignment\ \ex@assignment\hfil}
        \parbox{.333\textwidth}{\hfill \uebcsgroup\ \ex@stdGroup\ex@tutor}
        \vskip1.5mm
        \hrule
        \vskip1mm
}}

\def\uebcsuebungheaderlong{{
        \vspace*{-16mm}
        \hspace{-7.5mm}
        \LARGE\textsc{\textbf{\ex@lecture}}\normalsize
        \vskip1.5mm
        \hfill
        \ex@stdName\; --\; \uebcsmatnr: \ex@stdID
        \vskip1.5mm
        \hspace{-7.5mm}
        \parbox{.333\textwidth}{\large \ex@semester\normalsize \hfill}
        \parbox{.333\textwidth}{\hfil \uebcsassignment\ \ex@assignment\hfil}
        \parbox{.333\textwidth}{\hfill \uebcsgroup\ \ex@stdGroup\ex@tutor}
        \vskip1.5mm
        \hrule
        \vskip1mm
}}


\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\textsc{\ex@lectureShort}}
\fancyhead[C]{\normalfont \uebcsassignment\ \ex@assignment}
\fancyhead[R]{\ex@stdName\ --\ \ex@stdID}
\fancyfoot[C]{\thepage$\slash$\pageref*{LastPage}}

\fancypagestyle{firstPageStyle}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{\thepage$\slash$\pageref*{LastPage}}
}
\thispagestyle{firstPageStyle}

% Add header to the beginning of the document
\AtBeginDocument{
    \StrLen{\ex@lecture}[\uebcslecturelength]%
    \ifthenelse{\uebcslecturelength < 32}{%
        \uebcsuebungheader%
    }{%
        \uebcsuebungheaderlong%
    }%
}%
