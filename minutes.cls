% Generic class for SINTEF documents with LaTeX.
%
% by Federico Zenith, federico.zenith@sintef.no.

\ProvidesClass{minutes}[2023/03/31 A minutes class based on SINTEF]
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{etoolbox}
\RequirePackage[table]{xcolor}

% Whether the language is English;
% defaults to true
\newbool{english}
\booltrue{english}

% Whether to include a field for ISBN where relevant (only public reports)
% defaults to false
\newbool{useISBN}

% Whether to use fontspec for font selection (XeTeX and LuaTeX)
% defaults to false
\newbool{fontspec}

% Whether the document is meant for printing, i.e. using CMYK.
% defaults to false, i.e. RGB display 
\newbool{print}

% Force use of Calibri font, defaults to false
\newbool{calibri}

%%% BEGIN Options section; no \RequirePackage or \LoadClass in here %%%

\newcommand*{\@parentClass}{article}
\DeclareOption{report}{%
  \renewcommand{\@parentClass}{report}
}
\DeclareOption{article}{%
  \renewcommand{\@parentClass}{article}
}
\DeclareOption{english}  {\booltrue{english}}
\DeclareOption{norsk}    {\boolfalse{english}}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{display}  {\boolfalse{print}}
\DeclareOption{print}    {\booltrue{print}\PassOptionsToPackage{cmyk}{xcolor}}
\DeclareOption{calibri}  {\booltrue{calibri}\booltrue{fontspec}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\@parentClass}}
\ProcessOptions\relax

%%% END Options section %%%

\LoadClass[a4paper,11pt]{\@parentClass}

% Set margins
\RequirePackage[top=4.75cm,        bottom=2.5cm,
                left=2.3cm,        right=2.3cm,
                headheight=4.25cm, headsep=5mm,
                footskip=2.5ex]{geometry}

% Use a prettier date format, and adapt according to language.
\RequirePackage[useregional]{datetime2}
% If English is selected, prefer British, but have American ready.
\RequirePackage[\ifbool{english}{main=british,american}{}]{babel}

% Check what compiler is running so we know how to handle fonts later
\RequirePackage{iftex}
\ifXeTeX \booltrue{fontspec}\else\fi
\ifLuaTeX\booltrue{fontspec}\else\fi

% Set fonts.
% Carlito is a free clone of Calibri; "lining" option for "normal" digits.
% STIX 2 is an advanced open font, broadly compatible with Times New Roman. 
% it also has great math rendering.
\ifbool{fontspec}{ % XeLaTeX or LuaLaTeX, advanced font handling
  \RequirePackage{fontspec,unicode-math}
  \defaultfontfeatures{Ligatures=TeX}
  %\setmainfont{STIX Two Text}
  %\setmathfont{STIX Two Math}
  \setsansfont{\ifbool{calibri}{Calibri}{Carlito}}
}{ % Ye goode olde LaTeX and PDFLaTeX
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  %\RequirePackage{stix2}
  \RequirePackage[lining]{carlito}
}
% Use sans font by default
\renewcommand{\familydefault}{\sfdefault}

% Define \and function for multiple authors
\renewcommand{\and}{\\*}

% Define the main logo, whether CMYK (print) or RGB (screen)
\RequirePackage{graphicx}
\graphicspath{{./images/}}
%\newcommand{\@mainlogo}{SINTEF_Logo_Sentrert_\ifbool{print}{CMYK}{RGB}}
\newcommand{\@mainlogo}{HSW_Student-Project.png}


% Standard style for labels, small and bold
\newcommand{\@labeltext}[1]{\textbf{\scriptsize #1}}
\newcommand{\@LabelText}[1]{\MakeUppercase{\@labeltext{#1}}}
% Macro to set a helpful default for any command.
% \@DefaultVar{foo} will create a user \foo command that can set
% an internal variable \@foo, which is defaulted to a helpful tip,
% "Set with \foo{}".
\newcommand{\@DefaultVar}[1]{%
\expandafter\def\csname @#1\endcsname{Set with \texttt{\textbackslash #1\{\}}}%
\expandafter\def\csname #1\endcsname{%
    \expandafter\def\csname @#1\endcsname%
}%
}

%
% --- Variables
%

\newcommand*{\@absentlabel}{Absent}

\newcommand*{\@abstractlabel}{Abstract}
\@DefaultVar{abstract}

\newcommand*{\@academiclabel}
            {Academic objectives}
\@DefaultVar{academic}

\newcommand*{\@accumulatedlabel}
            {Accumulated}

\newcommand*{\@addresslabel} {Address}
\@DefaultVar{address}

\newcommand*{\@agreedlabel}{As agreed}

\newcommand*{\@attachmentlabel}{Attachments}
\@DefaultVar{attachments}
\newcommand*{\@attachmentpages}
            {[+ set with \texttt{\textbackslash attachmentpages\{\}]}}
\newcommand*{\attachmentpages}{\renewcommand*{\@attachmentpages}}
\newcommand*{\@attachmentrequest}
            {If not, explain in an attachment}

\newcommand*{\@attentionlabel}{For your attention}

\newcommand*{\@approvedlabel}{Approved by}
\@DefaultVar{approved}

% No star for \@asplannedlabel, it is on two lines
\newcommand{\@asplannedlabel}
           {As Planned\\Yes~/~No}

\newcommand*{\@attnlabel}{For the Attention of}
\@DefaultVar{attn}

\newcommand*{\@authorlabel}{Written by}

\newcommand*{\@checkedlabel}{Checked by}
\@DefaultVar{checked}

\newcommand*{\@clientlabel}{Client(s)}
\@DefaultVar{client}

\newcommand*{\@clientreflabel}
            {Client's Reference}
\@DefaultVar{clientref}

\newcommand*{\@clientvat}{Set with \texttt{\textbackslash clientvat\{\}}}
\newcommand*{\clientvat}{\renewcommand*{\@clientvat}}

\newcommand*{\@commentslabel}{Comments are invited}

\newcommand*{\@completelabel}{Completion year}
\newcommand*{\@complete}{\texttt{\textbackslash complete\{\}}}
\newcommand*{\complete}{\renewcommand*{\@complete}}

\newcommand*{\@currency}{kNOK}
\newcommand*{\currency}[1]{\renewcommand{\@currency}{#1}}

\newcommand*{\@datelabel}{Date}

\newcommand*{\@datereceivedlabel}
            {Test Object Received}
\@DefaultVar{datereceived}

\@DefaultVar{department}

\newcommand*{\@directlabel}{Direct line}
\newcommand*{\@direct}{}
\newcommand*{\direct}[1]{\renewcommand{\@direct}{#1}}

\newcommand*{\@distributionlabel}{Distribution}

\newcommand*{\@duelabel}{Due Date}

\newcommand*{\@elapsedlabel}
            {Number of Hours Elapsed}

\newcommand*{\@email}{}
\newcommand*{\email}[1]{\renewcommand{\@email}{#1}}

\newcommand*{\@enclosurelabel}{Enclosure}

\newcommand*{\@expenditurelabel}{Expenditure}
\newcommand*{\@expshortlabel}{Expenditure}

\newcommand*{\@faxlabel}{Telefax}
\newcommand*{\@fax}{}
\newcommand*{\fax}[1]{\renewcommand{\@fax}{#1}}

\newcommand*{\@faxnumberlabel}{Fax Number}
\@DefaultVar{faxnumber}

\newcommand*{\@firstexplabel}
            {Planned Expenditure\newline
                           for 1\textsuperscript{st} Year}
\newcommand*{\@firstexp}{\texttt{\textbackslash firstexp\{\}}}
\newcommand*{\firstexp}{\renewcommand*{\@firstexp}}

\newcommand*{\@fromlabel}{From}

\newcommand*{\@historylabel}{Document History}

\newcommand*{\@informationlabel}
            {For your information}

\newcommand*{\@initiatorlabel}{Initiated by}
\@DefaultVar{initiator}

\@DefaultVar{institute}

\newcommand*{\@ISBN}{Set with \texttt{\textbackslash isbn\{\}}}
\newcommand*{\isbn}{\renewcommand*{\@ISBN}}

\newcommand*{\@keywordlabel}{Keywords}
% No star for \@keywords, it can expand to multiple lines
\@DefaultVar{keywords}

\newcommand*{\@lastexp}{\texttt{\textbackslash lastexp\{\}}}
\newcommand*{\lastexp}{\renewcommand*{\@lastexp}}

\newcommand*{\@lasthrs}{\texttt{\textbackslash lasthrs\{\}}}
\newcommand*{\lasthrs}{\renewcommand*{\@lasthrs}}

\newcommand*{\@lastperiodlabel}{Last period}

\newcommand*{\@locationlabel}{Location}
\@DefaultVar{location}

\newcommand*{\@managerlabel}{Project Manager}
\@DefaultVar{manager}

\newcommand*{\name}{\def\fromname}
\name{Set with \texttt{\textbackslash name\{\}}}

\newcommand*{\@objectivelabel}{Objective}

\newcommand*{\@offernumberlabel}{Offer Number}
\newcommand*{\@offernumber}{Set with \texttt{\textbackslash offer\{\}}}
\newcommand*{\offer}{\renewcommand*{\@offernumber}}
\newcommand*{\proposal}{\renewcommand*{\@offernumber}}

\newcommand*{\@onbudget}{\texttt{\textbackslash onbudget\{\}}}
\newcommand*{\onbudget}{\renewcommand*{\@onbudget}}

\newcommand*{\@onschedule}{\texttt{\textbackslash onschedule\{\}}}
\newcommand*{\onschedule}{\renewcommand*{\@onschedule}}

\@DefaultVar{orderreference}

\@DefaultVar{orderdated}

\@DefaultVar{orderby}

\newcommand*{\@ourreflabel}{Our reference}
\@DefaultVar{ourref}

\newcommand*{\@pageslabel}
            {Number of Pages and Attachments}

\newcommand*{\@participantlabel}{Participant}
\newcommand*{\@participantslabel}{Participants}


\newcommand*{\@planexplabel}
            {Planned expenditure}
\newcommand*{\@planexp}{\texttt{\textbackslash planexp\{\}}}
\newcommand*{\planexp}{\renewcommand*{\@planexp}}

\newcommand*{\@planlabel}{Planned}

\newcommand*{\@preparedlabel}{Prepared by}
\newcommand*{\@prepared}{Set with \texttt{\textbackslash prepared\{\}}}
\newcommand*{\prepared}{\renewcommand*{\@prepared}}

\newcommand*{\@presentlabel}{Present}

\newcommand*{\@projectlabel}{Project Number}
\@DefaultVar{project}

\newcommand*{\@projectmemolabel}
            {Project Memo Number}
\@DefaultVar{projectmemo}

\@DefaultVar{projectname}

\newcommand*{\@recipientlabel}{To}
\@DefaultVar{recipient}

\newcommand*{\@referencelabel}{Reference}

\newcommand*{\@reportlabel}{Project Report}

\newcommand*{\@reportnumberlabel}{Report Number}
\@DefaultVar{reportnumber}

\newcommand*{\@responsiblelabel}{Responsible}

\newcommand*{\@schedulelabel}{Schedule}

\newcommand*{\signature}{\def\fromsig}
\signature{}
\newcommand*{\@signaturelabel}{Signature}

\newcommand*{\@startlabel}{Starting year}
\newcommand*{\@start}{\texttt{\textbackslash start\{\}}}
\newcommand*{\start}{\renewcommand*{\@start}}

\newcommand*{\@statuslabel}{Status}
\newcommand*{\@statusdatelabel}
            {Status as of Date}

\@DefaultVar{statusdate}

\@DefaultVar{subtitle}

\newcommand*{\@tasklistlabel}{Tasks}
\newcommand*{\@tasknumberlabel}{\#}
\newcommand*{\@tasklabel}{Task}

\newcommand*{\@testdatelabel}{Test Date}
\newcommand*{\@testdate}{\texttt{\textbackslash testdate\{\}}}
\newcommand*{\testdate}{\renewcommand*{\@testdate}}

\newcommand*{\@testlocationlabel}{Test Location}
\newcommand*{\@testlocation}{\texttt{\textbackslash testlocation\{\}}}
\newcommand*{\testlocation}{\renewcommand*{\@testlocation}}

\newcommand*{\@testobjectlabel}{Test Object}
\@DefaultVar{testobject}

\newcommand*{\@testprogramlabel}{Test Program}
\@DefaultVar{testprogram}

\newcommand*{\@timelabel}{Time (period/year)}

\@DefaultVar{titlefigure}

\newcommand*{\@totalexplabel}{Total Planned\newline Expenditure}

\newcommand*{\@totalexp}{\texttt{\textbackslash totalexp\{\}}}
\newcommand*{\totalexp}{\renewcommand*{\@totalexp}}

\newcommand*{\@totalhrs}{\texttt{\textbackslash totalhrs\{\}}}
\newcommand*{\totalhrs}{\renewcommand*{\@totalhrs}}

\newcommand*{\@totallabel}{Total}

\newcommand*{\@unitlabel}{SINTEF Unit}

\newcommand*{\@validitylabel}{Valid until}
\@DefaultVar{validity}

\newcommand*{\@VATlabel}{Enterprise Number}
\@DefaultVar{vat}

\newcommand*{\@versionlabel}{Version}
\newcommand*{\@versiondescriptionlabel}
            {Version Description}
\@DefaultVar{version}

\newcommand*{\@wageslabel}{Of which wages}
\newcommand*{\@wages}{\texttt{\textbackslash wages\{\}}}
\newcommand*{\wages}{\renewcommand*{\@wages}}

\@DefaultVar{wheremeeting}

\@DefaultVar{whenmeeting}

\newcommand*{\@yourreflabel}{Your reference}
\@DefaultVar{yourref}


% If some user has loaded hyperref,
% check for it and user the starred (non-linking) version of \pageref
% for page count (useless/ugly link)
\newcommand*\PlainPageRef[1]{%
  \@ifundefined{@pagerefstar}{\pageref{#1}}{\pageref*{#1}}%
}


%
% --- Colors
%

% This separating line is used across several documents,
% for example in footers and title pages.
% Main colour
\definecolor{sintefblue}{RGB/cmyk}{0,60,101/1,.57,0,.4}

% "Blueish grey"
\definecolor{sintefgrey}{RGB/cmyk}{226,232,240/0,0,0,.1}
\colorlet{sintefgray}{sintefgrey}

% Greens
\definecolorset{RGB/cmyk}{sintef}{}{lightgreen, 205,250,225/.23, 0,.20, 0;%
                                    green,       20,185,120/.73, 0,.67, 0;%
                                    darkgreen,    0, 70, 40/.93,.43,.92,.52}

% Additional colours
\definecolorset{RGB/cmyk}{sintef}{}{yellow, 200,155,20/20, 36,98, 8;%
                                    red,    190, 60,55/19, 86,77, 8;%
                                    lilla,  120,  0,80/48,100,27,31}

% Deprecated colours for backward compatibility
\definecolorset{HTML}{sintef}{}{cyan,      22A7E5;%
                                magenta,   EC008C;%
                                lightgrey, f1f5f9;%
                                darkgrey,  64748b}
\colorlet{sinteflightgray}{sinteflightgrey}
\colorlet{sintefdarkgrey}{sintefdarkgrey}


\newcommand{\@separator}{%
  % To make sure we have spacing on both sides, make an invisible rule, 2X tall
  \rule{0ex}{2ex}%
   % Place the dashed rule 1X high
  \textcolor{sintefgray}{\rule[1ex]{\textwidth}{0.25pt}}%
}

%
% --- Structure
%

\usepackage{hyperref}

\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  filecolor=magenta,    
  urlcolor=blue,
}

% Setting up header and footer
\RequirePackage{fancyhdr,lastpage}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\fancyhf{}% clear all header and footer fields
\lhead{\renewcommand{\baselinestretch}{0}%
       \raisebox{4.85mm}{\includegraphics[height=3.62cm]{\@mainlogo}}%
       }

% Header for first page
\fancypagestyle{firstpage}{
  \rhead{\begin{minipage}[b]{0.25\textwidth}%
    \end{minipage}%
  }
}


% Footer
\cfoot{%
  \color{sintefdarkgrey}
  \@separator\newline
  \hspace*{\tabcolsep}
  \begin{minipage}[c]{0.5\textwidth}
    \small{\textbf{\@title}}\newline
    \@whenmeeting
  \end{minipage}%
  \hfill
  \thepage\ of \PlainPageRef{LastPage}
  \hspace*{\tabcolsep}\newline
  \@separator
}


\RequirePackage{xparse}
\newcommand{\@participantstable}{}
\NewDocumentCommand \participant { O{present} m }{
    \g@addto@macro \@participantstable {
        \multicolumn{2}{l}{#2}
          & \ifstrequal{#1}{present}    {$\bullet$}{}
          & \ifstrequal{#1}{absent}     {$\bullet$}{}
          & \ifstrequal{#1}{information}{$\bullet$}{}\\
    }
}


\newcommand{\ul}[1]{
    \begin{itemize}%
        \setlength{\itemsep}{-2pt}%
        #1
    \end{itemize}
}

\newcommand{\ol}[1]{
    \begin{enumerate}%
        \setlength{\itemsep}{-2pt}%
        #1
    \end{enumerate}
}

\RequirePackage{tabularx,ltxtable}
\newcommand{\@tasktable}{}
\newcommand{\tasklist}{%
  \section*{\@tasklistlabel}
  \vspace{-\baselineskip} 
  \begin{longtable}{rp{0.55\textwidth}p{0.2\textwidth}l}
    \multicolumn{4}{@{}c@{}}{\@separator}\\*
    \@LabelText \@tasknumberlabel & \@LabelText \@tasklabel &
    \@LabelText \@responsiblelabel & \@LabelText \@duelabel\\*
    \multicolumn{4}{@{}c@{}}{\@separator}
    \@tasktable\\*
  \end{longtable}
}
\newcounter{sinteftask}
\newcommand{\task}[3]{%
    \g@addto@macro \@tasktable {%
      \\
      \refstepcounter{sinteftask}\thesinteftask & #1 & #2 & #3 \\*
      \multicolumn{4}{@{}c@{}}{\@separator}%
    }%
}


% Recipient address and information colophon
\RequirePackage{colortbl,tabularx,setspace,rotating}
\newcommand{\frontmatter}{%
  \thispagestyle{firstpage}
  \noindent%
  \begin{minipage}{0.7\textwidth}
    \setlength{\parskip}{2ex}%

    \huge\textbf \@title
    
    % ~ ensures \\ does not crash when \@wheremeeting is empty
    \Large \@wheremeeting~\\\@whenmeeting
  \end{minipage}

  \vspace{4ex}%
  \noindent\@separator%
  \rowcolors{4}{}{sinteflightgray}%
  \begin{longtable}{p{0.4\textwidth}p{0.4\textwidth}ccc}
    \rowcolor{white}
      \parbox{\linewidth}{{\@LabelText \@initiatorlabel}\\\@initiator}
      & \parbox{\linewidth}{{\@LabelText \@authorlabel}\\\@author}
      & \raisebox{-1.5cm}{\begin{sideways}%
          \parbox{2cm}{\centering\@LabelText\@presentlabel}%
        \end{sideways}}
      & \raisebox{-1.5cm}{\begin{sideways}%
          \parbox{2cm}{\centering\@LabelText\@absentlabel}%
        \end{sideways}}
      & \raisebox{-1.5cm}{\begin{sideways}%
          \parbox{2cm}{\centering\@LabelText\@informationlabel}%
        \end{sideways}}\\
    \rowcolor{white} \multicolumn{5}{@{}c@{}}{\@separator}\\
    \rowcolor{white} \@LabelText \@participantslabel\\
    \endfirsthead
    \rowcolor{white} &
    & \raisebox{-1.5cm}{\begin{sideways}%
        \parbox{2cm}{\raggedright\@LabelText\@presentlabel}%
      \end{sideways}}
    & \raisebox{-1.5cm}{\begin{sideways}%
        \parbox{2cm}{\raggedright\@LabelText\@absentlabel}%
      \end{sideways}}
    & \raisebox{-1.5cm}{\begin{sideways}%
        \parbox{2cm}{\raggedright\@LabelText\@informationlabel}%\\
      \end{sideways}}\\
    \rowcolor{white} \multicolumn{5}{@{}c@{}}{\@separator}\\
    \rowcolor{white} \@LabelText \@participantslabel\\
    \endhead
    \@participantstable
  \end{longtable}
  \rowcolors{1}{}{} % Back to normal
  \noindent\@separator

  \noindent
}
