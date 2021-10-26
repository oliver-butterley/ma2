\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thisbook}

%%%%%%% Base class and page setup
\LoadClass{scrbook}   
\KOMAoptions{paper=a5,fontsize=12pt,headings=openright,DIV=16,chapterprefix=on,titlepage=firstiscover}  
\recalctypearea

%%%%%% Section headings 
\setkomafont{disposition}{\normalfont\scshape}
\addtokomafont{chapterentry}{\normalfont\itshape\large}
\addtokomafont{chapterentrypagenumber}{\normalfont\normalsize}
\renewcommand{\raggedchapter}{\centering}
\renewcommand{\raggedsection}{\centering}

%%%%%% Title page
\date{}
% \publishers{\sourcelink}
\publishers{\href{https://\sourcelink}{\sourcelink}}
% \newcommand{\sourcelink}{}
\addtokomafont{publishers}{\large\ttfamily}
\addtokomafont{author}{\itshape\normalsize}
\renewcommand{\coverpageleftmargin}{5pt}
\renewcommand{\coverpagerightmargin}{5pt}

%%%%%% Table of contents 
\setcounter{tocdepth}{\sectiontocdepth}
\newcommand\gobble[1]{}
\DeclareTOCStyleEntries[entrynumberformat=\gobble,numwidth=0pt]{default}{chapter,section}

%%%%%%% General packages
\RequirePackage[UKenglish]{babel} % UK specific
\RequirePackage{amsmath,amssymb,amsthm} % Maths stuff
\RequirePackage[hyperfootnotes,colorlinks=true,citecolor=black,urlcolor=darkgray,linkcolor=black]{hyperref} % Clickable links
\RequirePackage[type={CC},modifier={by-sa},version={4.0}]{doclicense} % CC info
\RequirePackage[skins,breakable,theorems]{tcolorbox} % Attractive boxes
\RequirePackage{caption, subcaption} % Allow sub figures

%%%%%%% Style
\RequirePackage{ebgaramond} % Classic font
\RequirePackage[tracking=true,babel=true]{microtype}  % Better typography
\RequirePackage{lettrine}   % Add drop caps to chapter openings

%%%%%%% Math notation and theorems
\RequirePackage{thismath}

%%%%%%% Include graphics
\RequirePackage{graphicx}
\graphicspath{{graphics/}{graphics/build/}}
\setkeys{Gin}{width=0.75\textwidth} % Default width

%%%%%% Insert git sha
\RequirePackage{xstring,catchfile}
% Set user input
\newcommand{\gitfolder}{.git}             % Relative path to .git folder from .tex file
\newcommand{\reponame}{oliver-butterley/ma2}    % Name of account and repo. Will be included in URL
\CatchFileDef{\headfull}{\gitfolder/HEAD}{}              % Get path to head file for checked out branch
\StrGobbleRight{\headfull}{1}[\head]                      % Remove end of line character
\StrBehind[2]{\head}{/}[\branch]                          % Parse out the path only
\CatchFileDef{\commit}{\gitfolder/refs/heads/\branch}{}  % Get the chapters of the branch head
\StrGobbleRight{\commit}{1}[\commithash]                  % Remove end of line character
% Build the URL to this commit based on the information we now have
\newcommand{\fullcommiturl}{\href{https://github.com/\reponame/commit/\commithash}{\texttt{\commithash}}}
\newcommand{\commiturl}{\href{https://github.com/\reponame/commit/\commithash}{\texttt{\StrLeft{\commithash}{7}}}}

