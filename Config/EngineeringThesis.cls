%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% EngineeringThesis.cls
%
% LaTeX class for engineering theses
% AGH University of Krakow
%
% ------------------------------------------------------------------------------
%
% Based on aghphd.cls, originally developed by Prof. Marcin Szpyrka.
%
% Modified and adapted for engineering thesis requirements by:
%
%   Szymon Folmer <folmer@agh.edu.pl>
%
% ------------------------------------------------------------------------------
%
% AGH University of Krakow, Poland
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\message{*** [EngineeringThesis.cls] ---  SFo  v0.0 <15.07.2026>  ***}       

\NeedsTeXFormat{LaTeX2e} % 
\ProvidesClass{Config/EngineeringThesis} 

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}} 
\ProcessOptions
\LoadClass[12pt, a4paper, twoside]{book} 

\RequirePackage{times}
%\RequirePackage[T1]{fontenc}
\RequirePackage{fontspec}
\RequirePackage{graphicx}
%\RequirePackage[left=30mm, top=20mm, right=20mm, bottom=20mm]{geometry}
\RequirePackage{color}
\RequirePackage{fancyhdr}
\RequirePackage{url}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{anysize}
\RequirePackage[all,defaultlines=2]{nowidow}
%\RequirePackage[tracking=true]{microtype}

\def\universitynameen#1   {\gdef\@universitynameen{#1}}
\def\facultynameen#1      {\gdef\@facultynameen{#1}}
\def\fieldofstudyen#1     {\gdef\@fieldofstudyen{#1}}
\def\titleen#1   {\gdef\@titleen{#1}}
\def\authoren#1    {\gdef\@authoren{#1}}
\def\supervisoren#1   {\gdef\@supervisoren{#1}}
\def\secondsupervisoren#1   {\gdef\@secondsupervisoren{#1}}
\def\acknowledgementsen#1   {\gdef\@acknowledgementsen{#1}}

\def\universitynamepl#1   {\gdef\@universitynamepl{#1}}
\def\facultynamepl#1      {\gdef\@facultynamepl{#1}}
\def\fieldofstudypl#1     {\gdef\@fieldofstudypl{#1}}
\def\titlepl#1   {\gdef\@titlepl{#1}}
\def\authorpl#1    {\gdef\@authorpl{#1}}
\def\supervisorpl#1   {\gdef\@supervisorpl{#1}}
\def\secondsupervisorpl#1   {\gdef\@secondsupervisorpl{#1}}
\def\acknowledgementspl#1   {\gdef\@acknowledgementspl{#1}}

% class option conditionals


\linespread{1.25}

%------------------------------------------------------------------------------

%                              Title page definition 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%######################################  PL  ###################################

\newcommand{\thesistitlepagepl}{
\null\newpage
\titlepage

\vspace*{24mm}
\begin{center}
  
  \includesvg[width=3cm]{Pictures/1_TitlePage/AGHlogo.svg}
 
  \vspace*{3mm}

  % University name:
  {\fontspec{TeX Gyre Heros}[Letters=SmallCaps, LetterSpace=5] \fontsize{10.5pt}{12.5pt}\selectfont\bfseries \@universitynamepl}
  
  \vspace*{1.5mm}
  % Faculty name: 
  {\fontspec{Inter}\fontsize{7.8pt}{9.5pt}\selectfont\MakeUppercase{\bfseries\@facultynamepl}}

  \vspace*{17mm}

  % Thesis type: 
  {\fontspec{Inter}\fontsize{15.5pt}{19pt}\selectfont Projekt dyplomowy}

  \vspace*{10mm}

  % Thesis title: 
  {\fontspec{Inter}\fontsize{16pt}{13pt}\selectfont \itshape \@titlepl}\\
  \vspace*{3mm}
  {\fontspec{Inter}\fontsize{16pt}{13pt}\selectfont \itshape \@titleen}

  \vspace*{37mm}

  \end{center}

  % Author:
  \noindent
  {\fontspec{Inter}\fontsize{10pt}{12pt}\selectfont Autor: \@authorpl}\\
  {\fontspec{Inter}\fontsize{10pt}{12pt}\selectfont Kierunek studiów: \@fieldofstudypl}\\
  {\fontspec{Inter}\fontsize{10pt}{12pt}\selectfont Opiekun pracy: \@supervisorpl}\\
  \vspace*{22mm}


% Date:
\begin{center}
{\fontspec{Inter}\fontsize{9pt}{10.5pt}\selectfont Krak\'{o}w, \@date}
\end{center}
%\cleardoublepage
}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%######################################  EN  ###################################

\newcommand{\thesistitlepageen}{
\null\newpage
\titlepage

\vspace*{24mm}
\begin{center}
  
  \includesvg[width=3cm]{Pictures/1_TitlePage/AGHlogo.svg}
 
  \vspace*{3mm}

  % University name:
  {\fontspec{TeX Gyre Heros}[Letters=SmallCaps, LetterSpace=5] \fontsize{10.5pt}{12.5pt}\selectfont\bfseries \@universitynameen}
  
  \vspace*{1.5mm}
  % Faculty name: 
  {\fontspec{Inter}\fontsize{7.8pt}{9.5pt}\selectfont\MakeUppercase{\bfseries\@facultynameen}}

  \vspace*{17mm}

  % Thesis type: 
  {\fontspec{Inter}\fontsize{15.5pt}{19pt}\selectfont Diploma project}

  \vspace*{10mm}

  % Thesis title: 
  {\fontspec{Inter}\fontsize{16pt}{13pt}\selectfont \itshape \@titleen}\\
  \vspace*{3mm}
  {\fontspec{Inter}\fontsize{16pt}{13pt}\selectfont \itshape \@titlepl}

  \vspace*{37mm}

  \end{center}

  % Author:
  \noindent
  {\fontspec{Inter}\fontsize{10pt}{12pt}\selectfont Author: \@authoren}\\
  {\fontspec{Inter}\fontsize{10pt}{12pt}\selectfont Field of Study: \@fieldofstudyen}\\
  {\fontspec{Inter}\fontsize{10pt}{12pt}\selectfont Thesis supervisor: \@supervisoren}\\
  \vspace*{22mm}


% Date:
\begin{center}
{\fontspec{Inter}\fontsize{9pt}{10.5pt}\selectfont Krak\'{o}w, \@date}
\end{center}
\cleardoublepage
}

%                              Footnote definition 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%###############################################################################

\def\thesisfoot{
  \fancyfoot[L]{\small \@shortauthoren\quad\textit{\@shorttitleen}}
}

\ProcessOptions

\marginsize{25mm}{20mm}{15mm}{15mm}
\setlength{\headheight}{14pt} 
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot{}
\fancyhead{}


\frenchspacing
\sloppy 
\flushbottom