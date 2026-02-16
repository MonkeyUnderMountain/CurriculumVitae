% CV Class for Personal Use
% forked from https://www.overleaf.com/latex/templates/a-customised-curve-cv/mvmbhkwsnmwv
% !TeX program = xelatex
% !Bib program = biber
% !TEX encoding = UTF-8 Unicode
\NeedsTeXFormat{LaTeX2e}               % Require LaTeX2e
\ProvidesClass{cvformyself}[2026/02/06 v1.00 Personal CV Class] % Provide class metadata




% --------------------------------------------------------------------------
% Class options handling
% --------------------------------------------------------------------------

\LoadClass[a4paper,skipsamekey,12pt,english]{curve}  % Base curve class

\RequirePackage{silence}
\WarningsOff[longtable]
\WarningsOff[array]




% --------------------------------------------------------------------------
% font settings
% --------------------------------------------------------------------------

\RequirePackage{fontspec}
\RequirePackage{unicode-math}

% Set fonts using the native fontspec interface (the "Unicode" way)
% to avoid "TU/... undefined" warnings and enable OpenType features.
\setmainfont{Cochineal}[
  Numbers = {OldStyle,Proportional},
  RawFeature = {+swsh}
]
\setsansfont{Cabin}
\setmonofont{Inconsolatazi4}[Scale=MatchLowercase]

% Chinese support
\providecommand{\refname}{References}
\providecommand{\bibname}{Bibliography}
\RequirePackage[scheme=plain]{ctex}          % ctex package for Chinese typesetting




% --------------------------------------------------------------------------
% Core packages and configurations
% --------------------------------------------------------------------------
\RequirePackage{graphicx}                    % Include graphics
\RequirePackage[hyphens]{url}                % URL handling with hyphenation
% \RequirePackage{babel}                       % Language support
% \raggedright                                 % Ragged right alignment (no justification)

% Icon support
\RequirePackage[fixed]{fontawesome5}         % FontAwesome 5 icons

% Page layout
\RequirePackage[a4paper,nohead,nofoot,hmargin=2.25cm,vmargin=2cm]{geometry}

% Font and text utilities
\RequirePackage{relsize}                     % Relative font sizing
\RequirePackage[dvipsnames,svgnames]{xcolor} % Extended color support
\RequirePackage{tikz}                        % TikZ drawing
\usetikzlibrary{shapes,shadows}              % TikZ libraries for shapes and shadows

% Bibliography system
\RequirePackage[backend=biber,style=numeric,defernumbers=true]{biblatex}                    % biblatex for bibliography
% \RequirePackage{csquotes}                    % Context-sensitive quotations

% Loop utilities
\RequirePackage{pgffor}                      % For loops in LaTeX

% Hyperlinks (should be loaded last)
\RequirePackage[colorlinks=true,allcolors=black,breaklinks=true]{hyperref}




% --------------------------------------------------------------------------
% commands and configurations
% --------------------------------------------------------------------------

%  Color definitions
\definecolor{SwishLineColour}{HTML}{88AC0B}  % Green color for section lines
\definecolor{MarkerColour}{HTML}{B6073F}     % Red/pink color for markers and icons

% this command creates a field in the header (icon + content)
\newcommand{\makefield}[2]{\makebox[1.5em]{\color{MarkerColour!80!black}#1} #2\hspace{2em}}




% --------------------------------------------------------------------------
% Layout structure settings
% --------------------------------------------------------------------------

% \headerscale specifies the proportion of the remaining space that the left textual header should occupy.
\headerscale{1}




% ---------------------------------------------------------------------------
% Rubric settings
% --------------------------------------------------------------------------

\rubricfont{\Large\bfseries\sffamily}

\setlength{\rubricspace}{2pt}               % Spacing between rubric title and content
% \setlength{\rubricafterspace}{-3pt}         % Spacing after an entire rubric section
% \setlength{\subrubricspace}{3pt}            % Spacing between subrubric title and content
% \setlength{\subrubricbeforespace}{4pt}      % Spacing above a subrubric title

\def\@@rubrichead#1{%
  \begin{tikzpicture}[baseline]%\
  \shade[left color=SwishLineColour!60!white, right color=white] rectangle (\@almosttextwidth,2.5pt);
  \node[font={\@rubricfont},inner sep=0pt,text ragged,anchor=south west,text depth=.5ex,text height=1.5ex] at (1pt,2pt) {#1};
  \end{tikzpicture}%
  \vspace\rubricspace%
}


\subrubricfont{\large\bfseries\sffamily}
\subrubricalignment{l}


\newcommand{\prefixmarker}[1]{\def\@prefixmarker{#1}}
\def\@prefixmarker{\relscale{.9}\faBookmark}

\prefix{%
  \hspace*{-1ex}
  \color{MarkerColour!80!black}\@prefixmarker%
  \hspace*{1ex}%
}

% to use for the rubric heading outside the makerubric command, in particular, publications
\newcommand{\makerubrichead}[1]{\vskip\baselineskip\@@rubrichead{#1}}




% --------------------------------------------------------------------------
% Bibliography settings
% --------------------------------------------------------------------------

% Define a circled number for bibliography labels
\newcommand*\circled[1]{\tikz[baseline=(char.base)]{
   \node[shape=circle,text=white,fill=MarkerColour!80!black,font=\sffamily\scriptsize\bfseries,inner sep=1pt,text height=1.35ex,minimum width=1.5em,text centered] (char) {#1};}}
   
% define bibliography item counter and formatting
\newcounter{bibitem}
\AtBeginBibliography{\setcounter{bibitem}{1}}
\iffieldformatundef{labelnumberwidth}{%
  % if author-year style
    \AtEveryBibitem{\makebox[2.5em][l]{\circled{\thebibitem}\stepcounter{bibitem}}}%
}{%
  % if numeric style
    \DeclareFieldFormat{labelnumberwidth}{\makebox[2.5em][l]{\circled{\thebibitem}}}%
    \setlength{\biblabelsep}{0pt}%
    \AtEveryBibitem{\stepcounter{bibitem}}%
}

% Remove URL if DOI is present
\AtEveryBibitem{\iffieldundef{doi}{}{\clearfield{url}}}

% Bibliography item spacing and hanging indent
\setlength{\bibitemsep}{1.5ex}
\setlength{\bibhang}{2.5em}

% Prepend link icon to DOI and URL fields using xpatch
\RequirePackage{xpatch}
\xpretofieldformat{doi}
    {\textcolor{MarkerColour!80!black}{\scriptsize\faLink}}
    {}{}
\xpretofieldformat{url}
    {\textcolor{MarkerColour!80!black}{\scriptsize\faLink}}
    {}{}



\defbibheading{subbibliography}{\vskip 4pt{\@subrubricfont\hspace{2pt}#1}\par}
% \defbibheading{subbibliography}{\vskip\subrubricbeforespace{\@subrubricfont\hspace{3pt}#1}\par}

\defbibfilter{booksandchapters}{%
( type=book or type=incollection )
}


% automatically bold the author's name in the bibliography
% Usage: \mynames{FamilyName1/GivenName1,FamilyName2/GivenName2,...}
\newcommand{\mynames}[1]{\def\my@namelist{#1}}
\newtoggle{boldname}
\renewcommand*{\mkbibnamefamily}[1]{%
    \global\togglefalse{boldname}%
    \foreach \my@fname / \my@gname in \my@namelist {%
        \ifboolexpr{ test {\ifdefstrequal{\namepartfamily}{\my@fname}}
                    and
                    test {\ifdefstrequal{\namepartgiven}{\my@gname}}}
        {\global\toggletrue{boldname}}{}%
    }%
    \iftoggle{boldname}{\textbf{#1}}{#1}%
}

\renewcommand*{\mkbibnamegiven}[1]{%
    \global\togglefalse{boldname}%
    \foreach \my@fname / \my@gname in \my@namelist{%
        \ifboolexpr{ test {\ifdefstrequal{\namepartfamily}{\my@fname}}
                    and
                    test {\ifdefstrequal{\namepartgiven}{\my@gname}}}
        {\global\toggletrue{boldname}\breakforeach}{}%
    }%
    \iftoggle{boldname}{\textbf{#1}}{#1}%
}