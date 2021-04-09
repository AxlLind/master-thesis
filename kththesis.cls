\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kththesis}[2018/04/26 KTH Thesis formatting]

\newif\ifinswedish
\DeclareOption{english}{}
\DeclareOption{swedish}{\inswedishtrue}

\newif\ifgfivepaper
\DeclareOption{a4paper}{}
\DeclareOption{g5paper}{\gfivepapertrue}

\newif\ifbachelor
\DeclareOption{bachelor}{\bachelortrue}
\DeclareOption{master}{}

%% Send any unknown option to the report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions\relax

\ifgfivepaper
  \LoadClass[10pt]{report}
\else
  \LoadClass[12pt]{report}
\fi

% to do string comparison
\usepackage{xstring}

% to support units and decimal aligned columns in tables
\usepackage{siunitx}

% Make it possible to conditionally depend on the TeX-engine used
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\newif\ifxeorlua
\ifxetex\xeorluatrue\fi
\ifluatex\xeorluatrue\fi

%% Load other packages

\ifxeorlua
  \RequirePackage{polyglossia}
  \ifinswedish
    \setmainlanguage{swedish}
    \setotherlanguage[variant=us]{english}
    \setotherlanguages{french,spanish,norsk,german,danish,dutch,estonian}
  \else
    \setmainlanguage[variant=us]{english}
    \setotherlanguages{swedish,french,spanish,norsk,german,danish,dutch,estonian}
    %\setotherlanguage{swedish}
  \fi
\else
  \RequirePackage[utf8]{inputenc}
  \ifinswedish
    % can replace USenglish with UKenglish if desired
    \RequirePackage[main=swedish,english,french,spanish,norsk,ngerman,danish,dutch,estonian]{babel}
  \else
    % can replace USenglish with UKenglish if desired
    \RequirePackage[swedish,main=english,french,spanish,norsk,ngerman,danish,dutch,estonian]{babel}
  \fi
\fi

\ifgfivepaper
\RequirePackage[paperwidth=169mm,paperheight=239mm,twoside,
  top=30mm,bottom=30mm,inner=36mm,outer=18mm,
  headsep=10mm,headheight=5mm]{geometry} % Set paper and contents dimensions
\else
\RequirePackage[a4paper,twoside,
  top=37mm,bottom=50mm,inner=45mm,outer=35mm,
  headsep=15mm,headheight=6mm,footskip=25mm]{geometry} % Set paper and contents dimensions
\fi
\RequirePackage{fancyhdr} % Take control of headers and footers
%\RequirePackage{emptypage} % Supress page numbers on otherwise empty pages

\RequirePackage{pdfpages} % Used to include the preformatted KTH cover pages

\RequirePackage{titlesec} % Redefine the appearance of headers
% === Patch to circumvent a bug in the titlesec package version 2.10.1
\@ifpackagelater{titlesec}{2016/03/21}{%
 % Package titlesec is on version 2.10.2 or higher, nothing to do %
}{%
 % Check if package titlesec is on version 2.10.1 %
 \@ifpackagelater{titlesec}{2016/03/15}{%
  % Package titlesec on version 2.10.1, patch accordingly %
  \RequirePackage{etoolbox}%
  \patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}%
  \patchcmd{\ttlh@hang}{\noindent}{}{}{}%
 }{%
  % Package titlsecon is on version 2.10.0 or lower, nothing to do %
 }%
}
% === End ot titlesec patch

\ifxeorlua
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures={TeX}} % This enables TeX style ligatures such as ---, '', ``, and so on
  \setmainfont{TeX Gyre Termes}  %% Times like font
  \setsansfont{TeX Gyre Heros}   %% Helvetica like font
  \setmonofont{TeX Gyre Cursor}  %% Courier like font
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage{tgtermes}
  \RequirePackage{tgheros}
  \RequirePackage{tgcursor}
\fi

% Set up the header and footer
\fancyhead{}
\fancyhead[RO]{\sffamily\small\leftmark\thinspace|\thinspace\thepage}
\fancyhead[LE]{\sffamily\small\thepage\thinspace|\thinspace\leftmark}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}

% Add 5% extra linespacing
\linespread{1.05}

% Set the proper format for the headers
\titleformat{\chapter}[display]
  {\normalfont\sffamily\huge\bfseries}
  {\chaptertitlename\ \thechapter}{20pt}{\Huge}
\titleformat{\section}
  {\normalfont\sffamily\Large\bfseries}
  {\thesection}{1em}{}
\titleformat{\subsection}
  {\normalfont\sffamily\large\bfseries}
  {\thesubsection}{1em}{}

\renewenvironment{abstract}{\section*{\abstractname}}

% Define commands for setting the user definable parts of the title page

\let\@subtitle\@empty
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\let\@alttitle\@empty
\newcommand{\alttitle}[1]{\def\@alttitle{#1}}
\let\@altsubtitle\@empty
\newcommand{\altsubtitle}[1]{\def\@altsubtitle{#1}}
\let\@hostcompany\@empty
\newcommand{\hostcompany}[1]{\def\@hostcompany{#1}}
\let\@hostorganization\@empty
\newcommand{\hostorganization}[1]{\def\@hostorganization{#1}}

\let\@school\@empty
\newcommand{\school}[1]{\def\@school{#1}}

% First author's information
\let\@authorsLastname\@empty
\newcommand{\authorsLastname}[1]{\def\@authorsLastname{#1}}
\let\@authorsFirstname\@empty
\newcommand{\authorsFirstname}[1]{\def\@authorsFirstname{#1}}
\let\@email\@empty
\newcommand{\email}[1]{\def\@email{#1}}
\let\@kthid\@empty
\newcommand{\kthid}[1]{\def\@kthid{#1}}
\let\@orcid\@empty
\newcommand{\orcid}[1]{\def\@orcid{#1}}
\let\@authorsSchool\@empty
\newcommand{\authorsSchool}[1]{\def\@authorsSchool{#1}}
\let\@authorsDepartment\@empty
\newcommand{\authorsDepartment}[1]{\def\@authorsDepartment{#1}}

% Second author's information
\let\@secondAuthorsLastname\@empty
\newcommand{\secondAuthorsLastname}[1]{\def\@secondAuthorsLastname{#1}}
\let\@secondAuthorsFirstname\@empty
\newcommand{\secondAuthorsFirstname}[1]{\def\@secondAuthorsFirstname{#1}}
\let\@secondemail\@empty
\newcommand{\secondemail}[1]{\def\@secondemail{#1}}
\let\@secondkthid\@empty
\newcommand{\secondkthid}[1]{\def\@secondkthid{#1}}
\let\@secondorcid\@empty
\newcommand{\secondorcid}[1]{\def\@secondorcid{#1}}
\let\@secondAuthorsSchool\@empty
\newcommand{\secondAuthorsSchool}[1]{\def\@secondAuthorsSchool{#1}}
\let\@secondAuthorsDepartment\@empty
\newcommand{\secondAuthorsDepartment}[1]{\def\@secondAuthorsDepartment{#1}}



\let\@supervisorAsLastname\@empty
\newcommand{\supervisorAsLastname}[1]{\def\@supervisorAsLastname{#1}}
\let\@supervisorAsFirstname\@empty
\newcommand{\supervisorAsFirstname}[1]{\def\@supervisorAsFirstname{#1}}
\let\@supervisorAsEmail\@empty
\newcommand{\supervisorAsEmail}[1]{\def\@supervisorAsEmail{#1}}
\let\@supervisorAsKTHID\@empty
\newcommand{\supervisorAsKTHID}[1]{\def\@supervisorAsKTHID{#1}}
\let\@supervisorAsOrganization\@empty
\newcommand{\supervisorAsOrganization}[1]{\def\@supervisorAsOrganization{#1}}
\let\@supervisorAsSchool\@empty
\newcommand{\supervisorAsSchool}[1]{\def\@supervisorAsSchool{#1}}
\let\@supervisorAsDepartment\@empty
\newcommand{\supervisorAsDepartment}[1]{\def\@supervisorAsDepartment{#1}}

\let\@supervisorBsLastname\@empty
\newcommand{\supervisorBsLastname}[1]{\def\@supervisorBsLastname{#1}}
\let\@supervisorBsFirstname\@empty
\newcommand{\supervisorBsFirstname}[1]{\def\@supervisorBsFirstname{#1}}
\let\@supervisorBsEmail\@empty
\newcommand{\supervisorBsEmail}[1]{\def\@supervisorBsEmail{#1}}
\let\@supervisorBsKTHID\@empty
\newcommand{\supervisorBsKTHID}[1]{\def\@supervisorBsKTHID{#1}}
\let\@supervisorBsOrganization\@empty
\newcommand{\supervisorBsOrganization}[1]{\def\@supervisorBsOrganization{#1}}
\let\@supervisorBsSchool\@empty
\newcommand{\supervisorBsSchool}[1]{\def\@supervisorBsSchool{#1}}
\let\@supervisorBsDepartment\@empty
\newcommand{\supervisorBsDepartment}[1]{\def\@supervisorBsDepartment{#1}}

\let\@examinersLastname\@empty
\newcommand{\examinersLastname}[1]{\def\@examinersLastname{#1}}
\let\@examinersFirstname\@empty
\newcommand{\examinersFirstname}[1]{\def\@examinersFirstname{#1}}
\let\@examinersEmail\@empty
\newcommand{\examinersEmail}[1]{\def\@examinersEmail{#1}}
\let\@examinersKTHID\@empty
\newcommand{\examinersKTHID}[1]{\def\@examinersKTHID{#1}}
\let\@examinersOrganization\@empty
\newcommand{\examinersOrganization}[1]{\def\@examinersOrganization{#1}}
\let\@examinersSchool\@empty
\newcommand{\examinersSchool}[1]{\def\@examinersSchool{#1}}
\let\@examinersDepartment\@empty
\newcommand{\examinersDepartment}[1]{\def\@examinersDepartment{#1}}


\let\@programme\@empty
\newcommand{\programme}[1]{\def\@programme{#1}}

\newcommand{\schoolAcronym}[1]{%
  \ifinswedish
  \IfEqCase{#1}{%
    {ABE}{Skolan för Arkitektur och samhällsbyggnad}%
    {ITM}{Skolan för Industriell teknik och management}%
    {SCI}{Skolan för Teknikvetenskap}%
    {CBH}{Skolan för Kemi, bioteknologi och hälsa}%
    {EECS}{Skolan för Elektroteknik och datavetenskap}%
  }[\typeout{school's code not found}]
  \else
  \IfEqCase{#1}{%
    {ABE}{School of Architecture and the Built Environment}%
    {ITM}{School of Industrial Engineering and Management}%
    {SCI}{School of Engineering Sciences}%
    {CBH}{School of Engineering Sciences in Chemistry, Biotechnology and Health}%
    {EECS}{School of Electrical Engineering and Computer Science}%
  }[\typeout{school's code not found}]
  \fi
}
\newcommand{\programcode}[1]{%
  \ifinswedish
  \IfEqCase{#1}{%
    {ARKIT}{\programme{Arkitektutbildning}}%
    {CBIOT}{\programme{Civilingenjörsutbildning i bioteknik}}%
    {CDATE}{\programme{Civilingenjörsutbildning i datateknik}}%
    {CDEPR}{\programme{Civilingenjörsutbildning i design och produktframtagning}}%
    {CELTE}{\programme{Civilingenjörsutbildning i elektroteknik}}%
    {CENMI}{\programme{Civilingenjörsutbildning i energi och miljö}}%
    {CFATE}{\programme{Civilingenjörsutbildning i farkostteknik}}%
    {CINEK}{\programme{Civilingenjörsutbildning i industriell ekonomi}}%
    {CINTE}{\programme{Civilingenjörsutbildning i informationsteknik}}%
    {CITEH}{\programme{Civilingenjörsutbildning i industriell teknik och hållbarhet}}%
    {CLGYM}{\programme{Civilingenjör och lärare}}%
    {CMAST}{\programme{Civilingenjörsutbildning i maskinteknik}}%
    {CMATD}{\programme{Civilingenjörsutbildning i materialdesign}}%
    {CMEDT}{\programme{Civilingenjörsutbildning i medicinsk teknik}}%
    {CMETE}{\programme{Civilingenjörsutbildning i medieteknik}}%
    {COPEN}{\programme{Civilingenjörsutbildning öppen ingång}}%
    {CSAMH}{\programme{Civilingenjörsutbildning i samhällsbyggnad}}%
    {CTFYS}{\programme{Civilingenjörsutbildning i teknisk fysik}}%
    {CTKEM}{\programme{Civilingenjörsutbildning i teknisk kemi}}%
    {CTMAT}{\programme{Civilingenjörsutbildning i teknisk matematik}}%
    {KPUFU}{\programme{Kompletterande pedagogisk utbildning för ämneslärarexamen i matematik, naturvetenskap och teknik för forskarutbildade}}%
    {KPULU}{\programme{Kompletterande pedagogisk utbildning}}%
    {KUAUT}{\programme{Kompletterande utbildning för arkitekter med avslutad utländsk utbildning}}%
    {KUIUT}{\programme{Kompletterande utbildning för ingenjörer med avslutad utländsk utbildning}}%
    {LÄRGR}{\programme{Ämneslärarutbildning med inriktning mot teknik, årskurs 7-9}}%
    {TAEEM}{\programme{Masterprogram, flyg- och rymdteknik}}%
    {TAETM}{\programme{Masterprogram, aeroelasticitet i turbomaskiner}}%
    {TARKM}{\programme{Masterprogram, arkitektur}}%
    {TBASA}{\programme{Tekniskt basår, KTH Flemingsberg}}%
    {TBASD}{\programme{Tekniskt basår, KTH Campus}}%
    {TBASE}{\programme{Tekniskt basår, KTH Södertälje}}%
    {TBTMD}{\programme{Tekniskt basår, termin 2, KTH Campus}}%
    {TBTMH}{\programme{Tekniskt basår, termin 2, KTH Flemingsberg}}%
    {TBTMS}{\programme{Tekniskt basår, termin 2, KTH Södertälje}}%
    {TBYPH}{\programme{Högskoleutbildning i byggproduktion}}%
    {TCAEM}{\programme{Masterprogram, husbyggnads- och anläggningsteknik}}%
    {TCOMK}{\programme{Kandidatprogram, informations- och kommunikationsteknik}}%
    {TCOMM}{\programme{Masterprogram, kommunikationssystem}}%
    {TCSCM}{\programme{Masterprogram, datalogi}}%
    {TDEBM}{\programme{Magisterprogram, design och byggande i staden}}%
    {TDSEM}{\programme{Masterprogram, decentraliserade smarta energisystem}}%
    {TDTNM}{\programme{Masterprogram, datorsimuleringar inom teknik och naturvetenskap}}%
    {TEBSM}{\programme{Masterprogram, inbyggda system}}%
    {TEEEM}{\programme{Masterprogram, teknik och ledning för energi- och miljösystem}}%
    {TEEGM}{\programme{Masterprogram, miljöteknik}}%
    {TEFRM}{\programme{Masterprogram, elektromagnetism, fusion och rymdteknik}}%
    {TEILM}{\programme{Magisterprogram, entreprenörskap och innovationsledning}}%
    {TEINM}{\programme{Masterprogram, innovations- och tillväxtekonomi}}%
    {TELPM}{\programme{Masterprogram, elkraftteknik}}%
    {TFAFK}{\programme{Kandidatprogram, Fastighetsutveckling med fastighetsförmedling}}%
    {TFAHM}{\programme{Magisterprogram, fastigheter}}%
    {TFOBM}{\programme{Masterprogram, fastigheter och byggande}}%
    {TFOFK}{\programme{Kandidatprogram, fastighet och finans}}%
    {TFORM}{\programme{Masterprogram, fordonsteknik}}%
    {THSSM}{\programme{Masterprogram, hållbar samhällsplanering och stadsutformning}}%
    {TIBYH}{\programme{Högskoleingenjörsutbildning i byggteknik och design}}%
    {TIDAA}{\programme{Högskoleingenjörsutbildning i datateknik, Flemingsberg}}%
    {TIDAB}{\programme{Högskoleingenjörsutbildning i datateknik, Kista}}%
    {TIDTM}{\programme{Masterprogram, idrottsteknologi}}%
    {TIEDB}{\programme{Högskoleingenjörsutbildning i elektronik och datorteknik}}%
    {TIEEM}{\programme{Masterprogram, innovativ uthållig energiteknik}}%
    {TIELA}{\programme{Högskoleingenjörsutbildning i elektroteknik, Flemingsberg}}%
    {TIEMM}{\programme{Masterprogram, industriell ekonomi}}%
    {TIETM}{\programme{Masterprogram, innovativ energiteknik}}%
    {TIHLM}{\programme{Masterprogram, innovativ teknik för en hälsosam livsmiljö}}%
    {TIIPS}{\programme{Högskoleingenjörsutbildning i industriell teknik och produktionsunderhåll}}%
    {TIKED}{\programme{Högskoleingenjörsutbildning i kemiteknik}}%
    {TIMAS}{\programme{Högskoleingenjörsutbildning i maskinteknik, Södertälje}}%
    {TIMBM}{\programme{Masterprogram, Industriell och miljöinriktad bioteknologi}}%
    {TIMEL}{\programme{Högskoleingenjörsutbildning i medicinsk teknik}}%
    {TIMTM}{\programme{Masterprogram, interaktiv medieteknik}}%
    {TINEM}{\programme{Masterprogram, industriell ekonomi}}%
    {TINNM}{\programme{Masterprogram, information och nätverksteknologi}}%
    {TIPDM}{\programme{Masterprogram, integrerad produktdesign}}%
    {TIPUM}{\programme{Masterprogram, industriell produktutveckling}}%
    {TITEH}{\programme{Högskoleingenjörsutbildning i teknik och ekonomi}}%
    {TITHM}{\programme{Masterprogram, hållbar produktionsutveckling}}%
    {TIVNM}{\programme{Masterprogram, ICT Innovation}}%
    {TJVTM}{\programme{Masterprogram, järnvägsteknik}}%
    {TKEMM}{\programme{Masterprogram, kemiteknik för energi och miljö}}%
    {TLODM}{\programme{Magisterprogram, ljusdesign}}%
    {TMAIM}{\programme{Masterprogram, maskininlärning}}%
    {TMAKM}{\programme{Masterprogram, matematik}}%
    {TMBIM}{\programme{Masterprogram, medicinsk bioteknologi}}%
    {TMEGM}{\programme{Masterprogram, marinteknik}}%
    {TMESM}{\programme{Masterprogram, miljövänliga energisystem}}%
    {TMHIM}{\programme{Masterprogram, miljöteknik och hållbar infrastruktur}}%
    {TMLEM}{\programme{Masterprogram, medicinsk teknik}}%
    {TMMMM}{\programme{Masterprogram, makromolekylära material}}%
    {TMMTM}{\programme{Masterprogram, media management}}%
    {TMRSM}{\programme{Masterprogram, marina system}}%
    {TMTLM}{\programme{Masterprogram, molekylära tekniker inom livsvetenskaperna}}%
    {TMVTM}{\programme{Masterprogram, molekylär vetenskap och teknik}}%
    {TNEEM}{\programme{Masterprogram, kärnenergiteknik}}%
    {TNTEM}{\programme{Masterprogram, nanoteknik}}%
    {TPRMM}{\programme{Masterprogram, industriell produktion}}%
    {TSCRM}{\programme{Masterprogram, systemteknik och robotik}}%
    {TSEDM}{\programme{Masterprogram, programvaruteknik för distribuerade system}}%
    {TSUEM}{\programme{Masterprogram, hållbar energiteknik}}%
    {TSUTM}{\programme{Masterprogram, teknik och hållbar utveckling}}%
    {TTAHM}{\programme{Masterprogram, teknik, arbete och hälsa}}%
    {TTEMM}{\programme{Masterprogram, teknisk mekanik}}%
    {TTFYM}{\programme{Masterprogram, teknisk fysik}}%
    {TTGTM}{\programme{Masterprogram, transport och geoinformatik}}%
    {TTMAM}{\programme{Masterprogram, tillämpad matematik och beräkningsmatematik}}%
    {TTMIM}{\programme{Masterprogram, transport, mobilitet och innovation}}%
    {TTMVM}{\programme{Masterprogram, teknisk materialvetenskap}}%
    {TURSM}{\programme{Magisterprogram, urbana studier}}%
  }[\typeout{program's code not found}]
  \else
  \IfEqCase{#1}{%
    {ARKIT}{\programme{Degree Programme in Architecture}}%
    {CBIOT}{\programme{Degree Programme in Biotechnology}}%
    {CDATE}{\programme{Degree Programme in Computer Science and Engineering}}%
    {CDEPR}{\programme{Degree Programme in Design and Product Realisation}}%
    {CELTE}{\programme{Degree Programme in Electrical Engineering}}%
    {CENMI}{\programme{Degree Programme in Energy and Environment}}%
    {CFATE}{\programme{Degree Programme in Vehicle Engineering}}%
    {CINEK}{\programme{Degree Programme in Industrial Engineering and Management}}%
    {CINTE}{\programme{Degree Programme in Information and Communication Technology}}%
    {CITEH}{\programme{Degree Programme in Industrial Technology and Sustainability}}%
    {CLGYM}{\programme{Master of Science in Engineering and in Education}}%
    {CMAST}{\programme{Degree Programme in Mechanical Engineering}}%
    {CMATD}{\programme{Degree Programme in Materials Design and Engineering}}%
    {CMEDT}{\programme{Degree Programme in Medical Engineering}}%
    {CMETE}{\programme{Degree Programme in Media Technology}}%
    {COPEN}{\programme{Degree Programme Open Entrance}}%
    {CSAMH}{\programme{Degree Programme in Civil Engineering and Urban Management}}%
    {CTFYS}{\programme{Degree Programme in Engineering Physics}}%
    {CTKEM}{\programme{Degree Programme in Engineering Chemistry}}%
    {CTMAT}{\programme{Degree Programme in Engineering Mathematics}}%
    {KPUFU}{\programme{Bridging Teacher Education Programme in Mathematics, Science and Technology for Graduates with a Third Cycle Degree}}%
    {KPULU}{\programme{Bridging Teacher Education Programme}}%
    {KUAUT}{\programme{Bridging programme for architects with foreign qualifications}}%
    {KUIUT}{\programme{Bridging programme for engineers with foreign qualifications}}%
    {LÄRGR}{\programme{Subject Teacher Education in Technology, Secondary Education}}%
    {TAEEM}{\programme{Master's Programme, Aerospace Engineering, 120 credits}}%
    {TAETM}{\programme{Master's Programme, Turbomachinery Aeromechanic University Training, 120 credits}}%
    {TARKM}{\programme{Master's Programme, Architecture, 120 credits}}%
    {TBASA}{\programme{Technical Preparatory Year}}%
    {TBASD}{\programme{Technical Preparatory Year}}%
    {TBASE}{\programme{Technical Preparatory Year}}%
    {TBTMD}{\programme{Technical Preparatory Semester}}%
    {TBTMH}{\programme{Technical Preparatory Semester}}%
    {TBTMS}{\programme{Technical Preparatory Semester}}%
    {TBYPH}{\programme{Degree Progr. in Construction Management}}%
    {TCAEM}{\programme{Master's Programme, Civil and Architectural Engineering, 120 credits}}%
    {TCOMK}{\programme{Bachelor's Programme in Information and Communication Technology}}%
    {TCOMM}{\programme{Master's Programme, Communication Systems, 120 credits}}%
    {TCSCM}{\programme{Master's Programme, Computer Science, 120 credits}}%
    {TDEBM}{\programme{Master's Programme, Urban Development and Design, 60 credits}}%
    {TDSEM}{\programme{Master's Programme, Decentralized Smart Energy Systems, 120 credits}}%
    {TDTNM}{\programme{Master's Programme, Computer Simulations for Science and Engineering, 120 credits}}%
    {TEBSM}{\programme{Master's Programme, Embedded Systems, 120 credits}}%
    {TEEEM}{\programme{Master's Programme, Management and Engineering of Environment and Energy, 120 credits}}%
    {TEEGM}{\programme{Master's Programme, Environmental Engineering, 120 credits}}%
    {TEFRM}{\programme{Master's Programme, Electromagnetics, Fusion and Space Engineering, 120 credits}}%
    {TEILM}{\programme{Master's Programme, Entrepreneurship and Innovation Management, 60 credits}}%
    {TEINM}{\programme{Master's Programme, Economics of Innovation and Growth, 120 credits}}%
    {TELPM}{\programme{Master's Programme, Electric Power Engineering, 120 credits}}%
    {TFAFK}{\programme{Bachelor's Programme in Property Development and Agency}}%
    {TFAHM}{\programme{Master's Programme, Real Estate}}%
    {TFOBM}{\programme{Master's Programme, Real Estate and Construction Management, 120 credits}}%
    {TFOFK}{\programme{Bachelor's Programme in Real Estate and Finance}}%
    {TFORM}{\programme{Master's Programme, Vehicle Engineering, 120 credits}}%
    {THSSM}{\programme{Master's Programme, Sustainable Urban Planning and Design, 120 credits}}%
    {TIBYH}{\programme{Degree Programme in Constructional Engineering and Design}}%
    {TIDAA}{\programme{Degree Programme in Computer Engineering}}%
    {TIDAB}{\programme{Degree Programme in Computer Engineering}}%
    {TIDTM}{\programme{Master's Programme, Sports Technology}}%
    {TIEDB}{\programme{Degree Programme in Electronics and Computer Engineering}}%
    {TIEEM}{\programme{Master's Programme, Innovative Sustainable Energy Engineering, 120 credits}}%
    {TIELA}{\programme{Degree Programme in Electrical Engineering}}%
    {TIEMM}{\programme{Master's Programme, Industrial Engineering and Management, 120 credits}}%
    {TIETM}{\programme{Master's Programme, Energy Innovation, 120 credits}}%
    {TIHLM}{\programme{Master's Programme, Innovative Technology for Healthy Living}}%
    {TIIPS}{\programme{Degree Programme in Industrial Technology and Production Maintenance}}%
    {TIKED}{\programme{Degree Programme in Chemical Engineering}}%
    {TIMAS}{\programme{Degree Programme in Mechanical Engineering}}%
    {TIMBM}{\programme{Master's Programme, Industrial and Environmental Biotechnology, 120 credits}}%
    {TIMEL}{\programme{Degree Programme in Medical Technology}}%
    {TIMTM}{\programme{Master's Programme, Interactive Media Technology, 120 credits}}%
    {TINEM}{\programme{Master's Programme, Industrial Management, 120 credits}}%
    {TINNM}{\programme{Master's Programme, Information and Network Engineering, 120 credits}}%
    {TIPDM}{\programme{Master's Programme, Integrated Product Design, 120 credits}}%
    {TIPUM}{\programme{Master's Programme, Engineering Design, 120 credits}}%
    {TITEH}{\programme{Degree Programme in Engineering and Economics}}%
    {TITHM}{\programme{Master's Programme, Sustainable Production Development, 120 credits}}%
    {TIVNM}{\programme{Master's Programme, ICT Innovation, 120 credits}}%
    {TJVTM}{\programme{Master's Programme, Railway Engineering, 120 credits}}%
    {TKEMM}{\programme{Master's Programme, Chemical Engineering for Energy and Environment, 120 credits}}%
    {TLODM}{\programme{Master's Programme,  Architectural Lighting Design, 60 credits}}%
    {TMAIM}{\programme{Master's Programme, Machine Learning, 120 credits}}%
    {TMAKM}{\programme{Master's Programme, Mathematics, 120 credits}}%
    {TMBIM}{\programme{Master's Programme, Medical Biotechnology, 120 credits}}%
    {TMEGM}{\programme{Master's Programme, Maritime Engineering, 120 credits}}%
    {TMESM}{\programme{Master's Programme, Environomical Pathways for Sustainable Energy Systems, 120 credits}}%
    {TMHIM}{\programme{Master's Programme, Environmental Engineering and Sustainable Infrastructure, 120 credits}}%
    {TMLEM}{\programme{Master's Programme, Medical Engineering, 120 credits}}%
    {TMMMM}{\programme{Master's Programme, Macromolecular Materials, 120 credits}}%
    {TMMTM}{\programme{Master's Programme, Media Management, 120 credits}}%
    {TMRSM}{\programme{Master's Programme, Naval Architecture, 120 credits}}%
    {TMTLM}{\programme{Master's Programme, Molecular Techniques in Life Science, 120 credits}}%
    {TMVTM}{\programme{Master's Programme, Molecular Science and Engineering, 120 credits}}%
    {TNEEM}{\programme{Master's Programme, Nuclear Energy Engineering, 120 credits}}%
    {TNTEM}{\programme{Master's Programme, Nanotechnology, 120 credits}}%
    {TPRMM}{\programme{Master's Programme, Production Engineering and Management, 120 credits}}%
    {TSCRM}{\programme{Master's Programme, Systems, Control and Robotics, 120 credits}}%
    {TSEDM}{\programme{Master's Programme, Software Engineering of Distributed Systems, 120 credits}}%
    {TSUEM}{\programme{Master's Programme, Sustainable Energy Engineering, 120 credits}}%
    {TSUTM}{\programme{Master's Programme, Sustainable Technology, 120 credits}}%
    {TTAHM}{\programme{Master's Programme, Technology, Work and Health, 120 credits}}%
    {TTEMM}{\programme{Master's Programme, Engineering Mechanics, 120 credits}}%
    {TTFYM}{\programme{Master's Programme, Engineering Physics, 120 credits}}%
    {TTGTM}{\programme{Master's Programme, Transport and Geoinformation Technology, 120 credits}}%
    {TTMAM}{\programme{Master's Programme, Applied and Computational Mathematics, 120 credits}}%
    {TTMIM}{\programme{Master's Programme, Transport, Mobility and Innovation}}%
    {TTMVM}{\programme{Master's Programme, Engineering Materials Science, 120 credits}}%
    {TURSM}{\programme{Master's Programme, Urbanism Studies, 60 credits}}%
  }[\typeout{program's code not found}]
  \fi
}

\newcommand{\MONTH}{%
  \ifinswedish
  \ifcase\the\month
  \or januari% 1
  \or februari% 2
  \or mars% 3
  \or april% 4
  \or maj% 5
  \or juni% 6
  \or juli% 7
  \or augusti% 8
  \or september% 9
  \or oktober% 10
  \or november% 11
  \or december% 12
  \fi
  \else
  \ifcase\the\month
  \or January% 1
  \or February% 2
  \or March% 3
  \or April% 4
  \or May% 5
  \or June% 6
  \or July% 7
  \or August% 8
  \or September% 9
  \or October% 10
  \or November% 11
  \or December% 12
  \fi
\fi
}

% covers are separately made and applied
%\let\@kthcover\@empty
%\newcommand{\kthcover}[1]{\def\@kthcover{#1}}

% Command to print out the standardized title page
\renewcommand{\titlepage}{
\ifgfivepaper
  \newgeometry{top=65mm,bottom=30mm,left=62mm,right=18mm}
\else
  \newgeometry{top=65mm,bottom=30mm,left=50mm,right=35mm}
\fi

\thispagestyle{empty}

\ifinswedish\selectlanguage{swedish}\fi

\begin{huge}
  \begin{flushleft}
    \noindent\sffamily\bfseries \@title \par
  \end{flushleft}
\end{huge}

\ifx\@subtitle\@empty\relax
\else
\begin{Large}
  \vspace{1ex}
  \begin{flushleft}
    \noindent\sffamily\bfseries \@subtitle \par
  \end{flushleft}
\end{Large}
\fi


\vspace{10mm}
\begin{large}
  \begin{flushleft}
    \sffamily
    \expandafter\MakeUppercase\expandafter\@authorsFirstname\space\expandafter\MakeUppercase\expandafter\@authorsLastname \par
    \ifx\@secondAuthorsLastname\@empty\relax
    \else\vspace{1ex}\expandafter\MakeUppercase\expandafter\@secondAuthorsFirstname\space\expandafter\MakeUppercase\expandafter\@secondAuthorsLastname \par
    \fi
  \end{flushleft}
\end{large}

\vfill

\begin{flushleft}
  \sffamily
  \ifinswedish
    \@programme\\
    \ifx\@date\@empty\relax\else Datum: \@date\vspace{5mm} \fi
    \ifx\@supervisorBsLastname\@empty
    Handledare: \@supervisorAsFirstname\space\@supervisorAsLastname
        \else
    Handledare: \@supervisorAsFirstname\space\@supervisorAsLastname,  \@supervisorBsFirstname\space\@supervisorBsLastname
    \\ \fi
    Examinator: \@examiner\\
    \quad\@examinersSchool\\
    \ifx\@hostcompany\@empty\relax\else Uppdragsgivare: \@hostcompany \\ \fi
    \ifx\@hostorganization\@empty\relax\else Uppdragsgivare: \@hostorganization \\ \fi
    \ifx\@alttitle\empty\relax\else Engelsk titel: %
    \begin{otherlanguage}{english}\sffamily\@alttitle\end{otherlanguage} \fi
    \ifx\@altsubtitle\@empty\relax
    \else
    English subtitle \begin{otherlanguage}{english}\sffamily\@altsubtitle\end{otherlanguage} \\
    \fi
  \else
    \@programme\\
    \ifx\@date\@empty\relax\else Date: \@date\\ \vspace{5mm} \fi
    
    \ifx\@supervisorBsLastname\@empty
    Supervisor: \@supervisorAsFirstname\space\@supervisorAsLastname
        \else
    Supervisors: \@supervisorAsFirstname\space\@supervisorAsLastname,  \@supervisorBsFirstname\space\@supervisorBsLastname
    \\ \fi

    Examiner: \@examinersFirstname\space\@examinersLastname\\
    \quad\@examinersSchool\\
    \ifx\@hostcompany\@empty\relax\else Host company: \@hostcompany \\ \fi
    \ifx\@hostorganization\@empty\relax\else Host organization: \@hostorganization \\ \fi
    \ifx\@alttitle\empty\relax\else Swedish title: %
        \begin{otherlanguage}{swedish}\sffamily\@alttitle\end{otherlanguage}  \\ \fi
    \ifx\@altsubtitle\@empty\relax \else Swedish subtitle: %
        \begin{otherlanguage}{swedish}\sffamily\@altsubtitle\end{otherlanguage} \\ \fi
  \fi
\end{flushleft}
\restoregeometry
\clearpage
}

% Command to print out the standardized document information page
\newcommand{\bookinfopage}{
\ifgfivepaper
  \newgeometry{top=140mm,bottom=30mm,left=12.25mm,right=35mm}
\else
  \newgeometry{top=250mm,bottom=30mm,left=50mm,right=35mm}
\fi
\thispagestyle{empty}
\begin{flushleft}
  \sffamily
  \copyright\enspace\the\year\quad\@authorsFirstname\space\@authorsLastname 
  \ifx\@secondAuthorsLastname\@empty\relax
  \else
    \ifinswedish
      \enspace och\enspace\@secondAuthorsFirstname\space\@secondAuthorsLastname \\
    \else
      \enspace and\enspace\@secondAuthorsFirstname\space\@secondAuthorsLastname \\
    \fi
  \fi
\end{flushleft}
\restoregeometry
\clearpage
}

\newcommand{\acknowlegmentssignature}{
  \begin{flushleft}
    Stockholm, \MONTH\enspace\the\year\\
    \@authorsFirstname\space\@authorsLastname
  \end{flushleft}
\cleardoublepage
}

\newcommand{\frontmatter}{
  \pagenumbering{roman}
  \setcounter{page}{1}
}

\newcommand{\mainmatter}{
  \cleardoublepage
  \pagenumbering{arabic}
}

\newcommand{\divainfo}[1]{
\label{pg:lastPageofMainmatter}
\clearpage
\section*{For DIVA}
\thispagestyle{empty}
    \sffamily\tiny
    \begin{flushleft}
    \{\\
        "Author1": \{ \\
        \ifx\@authorsLastname\@empty\relax
            \else
            \hspace{1cm}"Last name": "\@authorsLastname",\\
        \fi
        \ifx\@authorsFirstname\@empty\relax
            \else
            \hspace{1cm}"First name": "\@authorsFirstname",\\
        \fi
        \ifx\@kthid\@empty\relax
            \else
            \hspace{1cm}"Local User Id": "\@kthid",\\
        \fi
        \ifx\@email\@empty\relax
            \else
            \hspace{1cm}"E-mail": "\@email",\\
        \fi
        \ifx\@orcid\@empty\relax
            \else
            \hspace{1cm}"ORCiD": "\@orcid",\\
        \fi
        \ifx\@authorsSchool\@empty\relax
            \else
            \hspace{1cm}"organisation": \{"L1": "\@authorsSchool",\\
            \ifx\@authorsDepartment\@empty\relax
            \else
            \hspace{3cm}"L2": "\@authorsDepartment"
            \fi
			 \hspace{2.5cm}\}\\
		\fi
       \hspace{0.9cm}\},\\
    \ifx\@secondAuthorsLastname\@empty\relax
    \else
        "Author2": \{\\
                \ifx\@secondAuthorsLastname\@empty\relax
            \else
            \hspace{1cm}"Last name": "\@secondAuthorsLastname",\\
        \fi
        \ifx\@secondAuthorsFirstname\@empty\relax
            \else
            \hspace{1cm}"First name": "\@secondAuthorsFirstname",\\
        \fi
        \ifx\@secondkthid\@empty\relax
            \else
            \hspace{1cm}"Local User Id": "\@secondkthid",\\
        \fi
        \ifx\@secondemail\@empty\relax
            \else
            \hspace{1cm}"E-mail": "\@secondemail",\\
        \fi
        \ifx\@secondorcid\@empty\relax
            \else
            \hspace{1cm}"ORCiD": "\@secondorcid",\\
        \fi
        \ifx\@secondAuthorsSchool\@empty\relax
            \else
            \hspace{1cm}"organisation": \{"L1": "\@secondAuthorsSchool",\\
            \ifx\@secondAuthorsDepartment\@empty\relax
            \else
            \hspace{3cm}"L2": "\@secondAuthorsDepartment"
            \fi
			 \hspace{2.5cm}\}\\
		\fi
       \hspace{0.9cm}\},\\
    \fi
       "Degree": \{"Educational program": "\@programme"\},\\
       "Title": \{\\
            \hspace{1cm}"Main title": "\@title",\\
            \ifx\@subtitle\@empty\relax
            \else
            \hspace{1cm}"Subtitle": "\@subtitle",\\
            \fi
        \ifinswedish
            \hspace{1cm}"Language": "swe"
        \else
            \hspace{1cm}"Language": "eng"
        \fi
       \},\\
    "Alternative title": \{\\
	\hspace{1cm}"Main title": "\@alttitle",\\
        \ifx\@altsubtitle\@empty\relax
            \else
            \hspace{1cm}"Subtitle": "\@altsubtitle",\\
        \fi
        \ifinswedish
            \hspace{1cm}"Language": "eng"\\
        \else
            \hspace{1cm}"Language": "swe"\\
        \fi
    \},\\
    \ifx\@supervisorAsLastname\@empty\relax
        \else
    "Supervisor1": \{\\
            \hspace{1.5cm}"Last name": "\@supervisorAsLastname",\\
        \ifx\@supervisorAsFirstname\@empty\relax
            \else
            \hspace{1.5cm}"First name": "\@supervisorAsFirstname",\\
        \fi
        \ifx\@supervisorAsKTHID\@empty\relax
            \else
            \hspace{1.5cm}"Local User Id": "\@supervisorAsKTHID",\\
        \fi
        \ifx\@supervisorAsEmail\@empty\relax
            \else
            \hspace{1.5cm}"E-mail": "\@supervisorAsEmail",\\
        \fi
        \ifx\@supervisorAsOrganization\@empty
            \ifx\@supervisorAsSchool\@empty\relax
                \else
                \hspace{1.5cm}"organisation": \{"L1": "\@supervisorAsSchool",\\
                \ifx\@supervisorAsDepartment\@empty\relax
                \else
                \hspace{3cm}"L2": "\@supervisorAsDepartment"
                \fi
		    	\}\\
		    \fi
            \else
            \hspace{1.5cm}"Other organisation": "\@supervisorAsOrganization"\}\\
        \fi
       \hspace{1.2cm}\},\\
    \fi
    \ifx\@supervisorBsLastname\@empty\relax
        \else
    "Supervisor2": \{\\
            \hspace{1.5cm}"Last name": "\@supervisorBsLastname",\\
        \ifx\@supervisorBsFirstname\@empty\relax
            \else
            \hspace{1.5cm}"First name": "\@supervisorBsFirstname",\\
        \fi
        \ifx\@supervisorBsKTHID\@empty\relax
            \else
            \hspace{1.5cm}"Local User Id": "\@supervisorBsKTHID",\\
        \fi
        \ifx\@supervisorBsEmail\@empty\relax
            \else
            \hspace{1.5cm}"E-mail": "\@supervisorBsEmail",\\
        \fi
        \ifx\@supervisorBsOrganization\@empty
            \ifx\@supervisorBsSchool\@empty\relax
                \else
                \hspace{1.5cm}"organisation": \{"L1": "\@supervisorBsSchool",\\
                \ifx\@supervisorBsDepartment\@empty\relax
                \else
                \hspace{3cm}"L2": "\@supervisorBsDepartment"
                \fi
		    	\}\\
		    \fi
            \else
            \hspace{1.5cm}"Other organisation": "\@supervisorBsOrganization"\}\\
        \fi
       \hspace{1.2cm}\},\\
    \fi
    \ifx\@examinersLastname\@empty\relax
        \else
    "Examiner1": \{\\
            \hspace{1.5cm}"Last name": "\@examinersLastname",\\
        \ifx\@examinersFirstname\@empty\relax
            \else
            \hspace{1.5cm}"First name": "\@examinersFirstname",\\
        \fi
        \ifx\@examinersKTHID\@empty\relax
            \else
            \hspace{1.5cm}"Local User Id": "\@examinersKTHID",\\
        \fi
        \ifx\@examinersEmail\@empty\relax
            \else
            \hspace{1.5cm}"E-mail": "\@examinersEmail",\\
        \fi
        \ifx\@examinersOrganization\@empty
            \ifx\@examinersSchool\@empty\relax
                \else
                \hspace{1.5cm}"organisation": \{"L1": "\@examinersSchool",\\
                \ifx\@examinersDepartment\@empty\relax
                \else
                \hspace{3cm}"L2": "\@examinersDepartment"
                \fi
		    	\}\\
		    \fi
            \else
            \hspace{1.5cm}"Other organisation": "\@examinersOrganization"\}\\
        \fi

       \hspace{1.2cm}\},\\
    \fi
    \ifx\@hostcompany\@empty\relax\else
    "Cooperation": \{ "Partner\_name": "\@hostcompany"\},\\
    \fi
    % \ifx\@hostorganization\@empty\relax\else Host organization: \@hostorganization\\\fi
    "Other information": \{\\
      "Year": "\the\year",
      "Number of pages": \char`\"\pageref{#1},\pageref{pg:lastPageofMainmatter}\char`\"
    \}\\
   \}
    \end{flushleft}
\clearpage
}

\endinput
