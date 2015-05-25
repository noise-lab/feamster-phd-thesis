\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mitthesis}[1999/10/20]

\usepackage{url}
%\usepackage{palatino}           % Less abusive fonts
%\usepackage{palatcm}
\usepackage{fancyheadings}
\usepackage{setspace}

\def\mystretch{1.5}		% Double spacing hack
\DeclareOption{doublespace}{}	% This is default
				% So we do not read this style twice
\DeclareOption{singlespace}{		% If he explicitly wants single spacing
    \typeout{Single spaced}
    \def\mystretch{1.05}}	% Less abusive leading

%% `vi' and `upcase' document style options.  Krishna Sethuraman (1990)
\newcount\vithesis
\DeclareOption{vi}{\typeout{Course VI/VIII thesis style.}\advance\vithesis by1}
\vithesis=0

\DeclareOption{upcase}{\typeout{Uppercase cover page.}
	\gdef\choosecase#1{\uppercase\expandafter{#1}}}
\def\choosecase#1{#1}

%  Thesis looks much like report
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass{report}


% If the user wants single spacing, set baselinestretch=1.
\def\baselinestretch{\mystretch}	% Double spacing hack


%%%%%%%  Set up margins and formatting params %%%

% Margins.
%  Note we want 1in top margin assuming no header line, so push header
%	into 1in margin.
%  Draft mode brings the header back down.

\setlength{\oddsidemargin}{0.5in}	% 1.25in left margin 
\setlength{\evensidemargin}{0in}	% 1in left margin (even pages)
\setlength{\topmargin}{0.0in}		% 1in top margin
\setlength{\textwidth}{6.0in}		% 6.0in text - 1.25in rt margin
\setlength{\textheight}{9in}		% Body ht for 1in margins
\addtolength{\topmargin}{-\headheight}	% No header, so compensate
\addtolength{\topmargin}{-\headsep}	% for header height and separation

% The next two macros compensate page style for headers and footers
% We only need them in page styles that USE headers and footers.
    % If we have a header, it must be 1in from top of page.
\def\pulldownheader{			% Shift header down 1in from top
    \addtolength{\topmargin}{\headheight}	
    \addtolength{\topmargin}{\headsep}	
    \addtolength{\textheight}{-\headheight}
    \addtolength{\textheight}{-\headsep}
}
    % If we have a footer, put it 1in up from bottom
\def\pullupfooter{				% Shift footer up
    \addtolength{\textheight}{-\footskip}
%    \addtolength{\textheight}{-\footheight}  %footheight doesn't
%    						exist in 2e
}

%%%%%%%  End of margins and formatting params %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Header and Footer Formatting

\pagestyle{fancyplain}
\chead{}{}
\lhead[\fancyplain{}{\sfb\thepage}]{\fancyplain{}{\sfeight SECTION \rightmark}}
\rhead[\fancyplain{}{\sfeight\leftmark}]{\fancyplain{}{\sfb\thepage}}
\cfoot[\fancyplain{}{}]{\fancyplain{}{}}
\rfoot[\fancyplain{}{}]{\fancyplain{\sfb\thepage}{}}
\lfoot[\fancyplain{\thepage}{}]{\fancyplain{}{}}


% Format for draft of thesis.  Define our own PageStyle -
% Just like headings, but has foot lines with the date and warning

\if@twoside         % If two-sided printing.
\def\ps@drafthead{
    \let\@mkboth\markboth
    \def\@oddfoot{\rm \today \hfil \sc **DRAFT**}
    \def\@evenfoot{\sc **DRAFT** \hfil \rm \today }
    \def\@evenhead{\rm \thepage\hfil \sl \leftmark}
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}
    \def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}{}}
    \def\sectionmark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\z@
	\thesection. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
    \pullupfooter				% Bring footer up
}
\else               % If one-sided printing.
\def\ps@drafthead{
    \let\@mkboth\markboth
    \def\@oddfoot{\rm \today \hfil \sc **DRAFT**}
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}
    \def\chaptermark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
    \pullupfooter				% Bring footer up
}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some NICE fonts

\newfont{\BIG}{cminch}                             %--- One-inch font
\newfont{\sfbHuge}{cmssbx10 scaled\magstep5}       %-- 25pt sans serif bold
\newfont{\sfbLarger}{cmssbx10 scaled\magstep3}   %-- 12+pt sans serif boldd
\newfont{\sfblarger}{cmssbx10 scaled\magstep2}   %-- 12+pt sans serif bold
\newfont{\sfblarge}{cmssbx10 scaled\magstep1}      %-- 12pt sans serif bold
\newfont{\sfbeleven}{cmssbx10 scaled\magstephalf}  %-- 11pt sans serif bold
\newfont{\sfb}{cmssbx10}                           %-- 10pt sans serif bold
\newfont{\sfeight}{cmss8}                          %-- 8pt sans serif





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Redefine '/chapter' to always start on an odd page.
% Should make no difference in singleside mode.
%

\newcounter{example}

\def\chapter{\cleardoublepage	% Starts new page.
   \setcounter{example}{0}      % Reset example counter
   \thispagestyle{plain}	% Page style of chapter page is 'plain'
   \global\@topnum\z@		% Prevents figures from going at top of page.
   \@afterindentfalse		% Suppresses indent in first paragraph.  Change
   \secdef\@chapter\@schapter}	% to \@afterindenttrue to have indent.


\newcommand{\qack}[1]{
  \cleardoublepage  % Starts new page.
   \thispagestyle{plain}        % Page style of chapter page is 'plain'
   \global\@topnum\z@           % Prevents figures from going at top of page.
   \@afterindentfalse           % Suppresses indent in first paragraph.  Change
{\setbox0\hbox{\vtop{%
\begin{flushleft}%
    \def\baselinestretch{1}\slshape #1
\end{flushleft}%
\null}}\ht0=0pt\dp0=0pt\box0}}



\def\@makechapterhead#1{%
  \vspace*{100\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \flushright\huge\sffamily {\textsc \@chapapp\space \thechapter}
    \fi 
    \par
    \interlinepenalty\@M
    \sfbHuge #1\par\nobreak
    \vskip 40\p@
  }}


\def\@makeschapterhead#1{%
  \vspace*{100\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \flushright\huge\sffamily %{\textsc \@chapapp\space \thechapter}
    \fi 
    \par
    \interlinepenalty\@M
    \sfbHuge #1\par\nobreak
    \vskip 40\p@
  }}



% Add a quote to the upper left of a chapter heading
%
\newcommand{\qchapter}[1]{
  \cleardoublepage	% Starts new page.
   \setcounter{example}{0}
%   \pagestyle{fancy}
   \thispagestyle{plain}	% Page style of chapter page is 'plain'
   \global\@topnum\z@		% Prevents figures from going at top of page.
   \@afterindentfalse		% Suppresses indent in first paragraph.  Change
{\setbox0\hbox{\vtop{%
\begin{flushleft}%
    \def\baselinestretch{1}\slshape #1
\end{flushleft}% 
\null}}\ht0=0pt\dp0=0pt\box0}%
   \secdef\@chapter\@schapter}	% to \@afterindenttrue to have indent.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section Headings

\global\def\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {1.8ex}%
                                   {\noindent \Large $\blacksquare$
                                   \hspace{0.1in} \normalfont\Large\sfblarger}}

\global\def\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-2.75ex\@plus -1ex \@minus -.2ex}%
                                     {1.2ex}%
                                     {\noindent $\blacksquare$
                                      \hspace{0.1in} \normalfont\large\sfblarge}}
\global\def\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-2.75ex\@plus -1ex \@minus -.2ex}%
                                     {1.2ex}%
                                     {\normalfont\large\sfb}}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If using the report style, use - instead of . in the figure number.
\@ifundefined{thechapter}{}{\def\thefigure{\thechapter-\arabic{figure}}}
\@ifundefined{thechapter}{}{\def\thetable{\thechapter-\arabic{table}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I don't like having my figure captions be in the same font as
% the text.

\def\capfont{\rmfamily}
\long\def\@makecaption#1#2{
   \vskip \baselineskip
%   \setbox\@tempboxa\hbox{\textbf{\small #1: #2}}
   \setbox\@tempboxa\hbox{\capfont\textbf{\footnotesize #1: #2}}
   \ifdim \wd\@tempboxa >\hsize % IF longer than one line:
%       \textbf{\small #1: #2}\par  %   THEN set as ordinary paragraph.
       {\capfont\textbf{\footnotesize #1: #2}}\par  % THEN set as ordinary paragraph.
     \else                      %   ELSE  center.
       \hbox to\hsize{\hfil\box\@tempboxa\hfil}\par
   \fi}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Customizing the Table of Contents, LOC, LOF

\renewcommand\listfigurename{List of Figures}
\renewcommand\listtablename{List of Tables}
\def\bibname{References}
\setcounter{tocdepth}{1}

\renewcommand\tableofcontents{%
  \cleardoublepage
  \chapter*{\contentsname}
%    \addcontentsline{toc}{chapter}{\contentsname}
    \@starttoc{toc}%
}


\renewcommand\listoffigures{%
    \chapter*{\listfigurename}
%%       \@mkboth{\MakeUppercase\listfigurename}%
%%               {\MakeUppercase\listfigurename}}%
    \@starttoc{lof}%
    \addcontentsline{toc}{chapter}{\listfigurename}
}


\renewcommand\listoftables{%
    \chapter*{\listtablename}
    \@starttoc{lot}%
    \addcontentsline{toc}{chapter}{\listtablename}
    }



\def\thebibliography#1{%
%\ifnum\addauflag=0\addauthorsection\global\addauflag=1\fi
    \chapter*{%
       {\bibname}
        \@mkboth{{\bibname}}{{\bibname}}%
    }%
    \addcontentsline{toc}{chapter}{\bibname}
    \list{\@biblabel{\@arabic\c@enumiv}}%
         {\settowidth\labelwidth{\@biblabel{#1}}%
           \leftmargin\labelwidth
           \advance\leftmargin\labelsep
           \@openbib@code
           \usecounter{enumiv}%
           \let\p@enumiv\@empty
           \renewcommand\theenumiv{\@arabic\c@enumiv}}%

      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m
}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hyperref stuff

\usepackage[breaklinks=true,pagebackref,filecolor=black,citecolor=black,urlcolor=black,linkcolor=black,colorlinks,pdfpagelabels,pdfpagelayout=SinglePage]{hyperref}
%\usepackage{breakurl}
%\renewcommand{\url}{\burl}

\renewcommand*{\backref}[1]{}
\renewcommand*{\backrefalt}[4]{
  \ifcase #1 %
    (Not cited.) %
  \or
    {\small\sffamily (Cited on page~#2.)}%
  \else
    {\small\sffamily (Cited on pages~#2.)}%
  \fi
}
\renewcommand*{\backrefsep}{, }
\renewcommand*{\backreftwosep}{ and~}
\renewcommand*{\backreflastsep}{ and~}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Big Letter at the beginning of chapters

\def\cs#1#2{\begingroup\def\par{\endgraf\endgroup\lineskiplimit=0pt}
    \setbox2=\hbox{#2}\newdimen\tmpht \tmpht \ht2
    \advance\tmpht by \baselineskip\font\hhuge=cmr10 at \tmpht
    \setbox1=\hbox{{\hhuge #1}}
    \count7=\tmpht \count8=\ht1\divide\count8 by 1000 \divide\count7 by\count8
    \tmpht=.001\tmpht\multiply\tmpht by \count7\font\hhuge=cmr10 at \tmpht
    \setbox1=\hbox{{\hhuge #1}} \noindent \hangindent1.05\wd1
    \hangafter=-2 {\hskip-\hangindent \lower1\ht1\hbox{\raise1.0\ht2\copy1}%
    \kern-0\wd1}\copy2\lineskiplimit=-1000pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title Page Formatting

%% `upcase' documentclass option: \choosecase is defined either as a dummy or
%% a macro to change the (expanded) argument to uppercase.
\def\maketitle{
\pagestyle{empty}
\begin{titlepage}
\vskip 4in
\begin{flushright}
\sfbHuge\@title
\\ \vspace*{0.5in}
\LARGE\sffamily\@author
\end{flushright}
\end{titlepage}
\begin{titlepage}
\cleardoublepage
\setcounter{page}{1}
\large
{\def\baselinestretch{1.2}\sfbHuge \choosecase{\@title} \par}
by\par
{\Large  \choosecase{\sffamily \@author}}
\par
{\small\@prevdegrees}
\par\vskip 2\baselineskip
\choosecase{Submitted to the} \\ \choosecase{\@department} \\
\choosecase{in partial fulfillment of the requirements for the}
\choosecase{\@degreeword} 
\choosecase{of}
\par
\choosecase{\@degree}
\par
at the
\par\MIT\par
\@degreemonth\ \@degreeyear
\par
\@copyrightnotice
\par
\vskip 3\baselineskip
\signature{Author}{\@department \\ \@thesisdate}
\par
\vfill
\unvbox\@titlesupervisor
\par
\vfill
\signature{Accepted by}{\@chairmanname \\ \@chairmantitle}
\vfill
\end{titlepage}
\pagestyle{fancyplain}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abstract Page Formatting


% this environment should probably be called abstract,
% but we want people to also be able to get at the more
% basic abstract environment
\def\abstractpage{\cleardoublepage
\thispagestyle{empty}
\begin{center}{\large{\sfblarger \abstitle} \\
by \\
\sffamily\@author \\[\baselineskip]}
\par
\def\baselinestretch{1}\@normalsize
Submitted to the \@department \\
on \@thesisdate, in partial fulfillment of the \\
requirements for the \@degreeword\ of \\
\@degree
\end{center}
\par
\vskip 1ex
\begin{abstract}}

%% Changed from \unvbox to \unvcopy for use with multiple copies of abstract
%% page.
%% Krishna Sethuraman (1990)
\def\endabstractpage{\end{abstract}\vskip 2ex\noindent
 \unvcopy\@abstractsupervisor \newpage}

\def\abstract{\noindent\textbf{{\sfblarge Abstract}}\small\def\baselinestretch{1}\@normalsize\par\noindent\hspace{-0.02in}}
\def\endabstract{\par}






%%%%%%%%%  End of Style parameters %%%%

\def\prevdegrees#1{\gdef\@prevdegrees{#1}}
\def\@prevdegrees{}

\def\department#1{\gdef\@department{#1}}

% If you are getting two degrees, use \and between the names.
\def\degree#1{\setbox0\hbox{#1}	 %for side effect of setting \@degreeword
  \gdef\@degree{#1}}

% \and is used inside the \degree argument to separate two degrees
\def\and{\gdef\@degreeword{degrees} \par and \par}
\def\@degreeword{degree}

\def\copyrightnotice#1{\copyrightnoticetext{\copyright\ #1.  All rights
reserved.\par\permission}}

% Occacionally you will need to exactly specify the text of the 
% copyright notice.  The \copyrightnoticetext command is then useful.
\long\def\copyrightnoticetext#1{\gdef\@copyrightnotice{#1}}
\def\@copyrightnotice{\copyright\ \Mit\ 2005.  All rights reserved.}

%% `vi' documentclass option: Specifying this option automatically
%% copyrights the thesis to the author and gives MIT permission to copy and
%% distribute the document.  If you want, you can still specify
%% \copyrightnotice{stuff} to copyright to someone else, or
%% \copyrightnoticetext{stuff} to specify the exact text of the copyright
%% notice.
\ifodd\vithesis \copyrightnoticetext{\copyright\ \@author,
\uppercase\expandafter{\romannumeral\@degreeyear}.  All rights reserved.\par\permission}
%% or just
%%\@degreeyear}}
\typeout{Copyright given to author,
	permission to copy/distribute given to MIT.}
\else \typeout{Thesis document copyright MIT unless otherwise (manually) specified}
\fi

\def\thesisdate#1{\gdef\@thesisdate{#1}}

% typically just a month and year
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% Usage: \supervisor{name}{title}
%        \chairman{name}{title}

% since there can be more than one supervisor,
% we build the appropriate boxes for the titlepage and
% the abstractpage as the user makes multiple calls
% to \supervisor
\newbox\@titlesupervisor 	\newbox\@abstractsupervisor

\def\supervisor#1#2{\setbox\@titlesupervisor\vbox
  {\unvbox\@titlesupervisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Certified by}{#1 \\ #2 \\ Thesis Supervisor}}
  \setbox\@abstractsupervisor\vbox{\unvbox\@abstractsupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent 
\begin{tabular}{p{1.4in}l}
{\sffamily Thesis Supervisor:} & #1 \\ 
{\sffamily Title:} & #2
\end{tabular}
}
}

% department chairman, not thesis committee chairman
\def\chairman#1#2{\gdef\@chairmanname{#1}\gdef\@chairmantitle{#2}}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% This counter is used to save the page number for the second copy of
%% the abstract.
\newcounter{savepage}

% You can use the titlepage environment to do it all yourself if you
% don't want to use \maketitle.  If the titlepage environment, the
% paragraph skip is infinitely stretchable, so if you leave a blank line
% between lines that you want space between, the space will stretch so
% that the title page fills up the entire page.
\def\titlepage{\cleardoublepage\centering
  \thispagestyle{empty}
  \parindent 0pt \parskip 10pt plus 1fil minus 1fil
  \def\baselinestretch{1}\@normalsize\vbox to \vsize\bgroup\vbox to 9in\bgroup}
% The \kern0pt pushes any depth into the height.  Thanks to Richard Stone.
\def\endtitlepage{\par\kern 0pt\egroup\vss\egroup\newpage}

\def\MIT{\Mit}
\def\Mit{Massachusetts Institute of Technology}

\def\permission{\par\noindent{\centering
   The author hereby grants to MIT permission to reproduce and
   distribute publicly paper and electronic copies of this thesis
   document in whole or in part.}\par}

\def\signature#1#2{\par\noindent\sffamily #1\dotfill\null\\*
  {\raggedleft \rmfamily #2\par}}



