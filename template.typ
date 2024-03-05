#let Template(
  language: "de",
  title: "Platzhaltertitel für eine Bachelorarbeit: Eine Vorläufige Betrachtung",
  authors: (
    (
      name: "Max Julian Mustermann", 
      email: "max.mustermann@stud-provadis-hochschule.de", 
      postal: "Hauptstraße 10, D-10341 Hauptstadt",
      matrikel: "XXXX"
    ),
  ),
  logo: image("img/t-systems.png", width: 120pt),
  abstract: lorem(100),
  document-type: "Bachelorarbeit",
  reason: [
    zur Erlangung des akademischen Grades \
    ’Bachelor of Science’  B.Sc.\ 
    im Studiengang Informatik \ \
    vorgelegt dem Fachbereich \
    Informatik und Wirtschaftsinformatik \ der \
    Provadis School of International Management and Technology \
    von
  ],
  first_appraiser: "Prof. Müller",
  second_appraiser: "Dr. Kunze",
  supervisor: "Dr. Peter",
  bib: none,
  appendix: (),
  location: "Berlin",
  deadline: "15.03.2024",
  declaration_of_independence: true, // 🇺🇸🇺🇸🇺🇸🇺🇸🦅🦅🦅
  body
  ) = {
  let translations = json("translations.json").at(language)

  set document(author: authors.map(a => a.name), title: title)
  set text(font: "Times New Roman", lang: language, weight: 500, size: 12pt,)
  set heading(numbering: "1.1")

  grid(
    columns: (1fr,1fr),
    align(left ,image("img/provadis.png", width: 120pt)),
    align(right,logo),
  )

  v(2em)

  align(center, text(1.25em, weight: 600, document-type)) 

  v(2em)

  align(center,
    text(1.5em, title)
  )

  v(1em)

  set par(justify: true, leading: 1em)
  align(center, 
    text(1.25em, reason),
  ) 
  
  v(2em)
  set block(spacing: 1em)
  align(
    center,
    grid(
      ..authors.map(author => align(center)[
        *#author.name* 

        #author.matrikel 

        #author.email 

        #author.postal 

        #{if author.keys().contains("affiliation") {
          author.affiliation
        }}
      ]),
    )
  )

  v(2.4fr)
  grid(
    columns: (auto, auto),
    rows: (auto, auto),
    row-gutter: 15pt,
    column-gutter: 15pt,
    [#translations.erstgutachter:],
    [#first_appraiser],
    [#translations.zweitgutachter:],
    [#second_appraiser],
    [#translations.betreuung:],
    [#supervisor],
    [#translations.endeDerBearbeitungsfrist:],
    [#deadline]
  )
 
  v(.5fr)
  // Workaroung um Monate in der ausgewählte Sprache (deutsch,english) anzuzeigen, bis Typst es out-of-the-box unterstüzt
  text(
    [
      Frankfurt am Main, #translations.meta.monatZeitPrefix #translations.monate.at(datetime.today().display("[month repr:long]")) #datetime.today().display("[year]")
    ]
  )
  v(.5fr)
  pagebreak()
    
  set block(spacing: .65em)
  set text(font: "Times New Roman", lang: language, weight: 500, size: 12pt,)

  show outline.entry.where(
    level: 1
  ): it => {
    v(12pt, weak: true)
    strong(it)
  }

  outline(
    depth: 3,
    indent: true,
    target: heading.where(supplement: [translations.kapitel])
  )

  if appendix.len() > 0 {
    outline(
      title: translations.appendix,
      depth: 3,
      indent: true,
      target: heading.where(supplement: [translations.appendix]),
    )
  }

  locate(loc => {
      if counter(figure).final(loc).at(0) > 0 {
        outline(
          title: translations.abbildungsverzeichnis,
          depth: 3,
          indent: true,
          target: figure,
        )
      }
  })

  pagebreak()

  // Main body
  set par(justify: true, leading: 1.1em)
  set page(numbering: "1", number-align: center)
  set block(spacing: 1.2em)
  counter(page).update(1)
  set heading(supplement: [translations.kapitel])
  show heading: it => block(it,below: 1.1em)
  
  body

  if bib != none {
    set page(numbering: "I")
    counter(page).update(1)
    bibliography(bib)
  }

  // Appendix
  if appendix.len() > 0 {
    set page(numbering: "I")
    counter(heading).update(0)
    set heading(numbering: none)
    heading(translations.appendix, outlined: false)
    set heading(numbering: "A")

    appendix.join()

  }

  // 🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🦅🦅🦅🦅🗽🗽🗽🔫🔫🔫
  if declaration_of_independence {
    set heading(numbering: none)
    set page(numbering: none)
    heading("Eigenständigkeitserklärung", outlined: false)
    text(lang: "de", "Ich versichere hiermit, dass ich die vorliegende Arbeit selbständig verfasst und keine anderen als die angegebenen Quellen benutzt habe. Alle Stellen, die wörtlich oder sinngemäß anderen Quellen entnommen wurden, sind als solche kenntlich gemacht. Die Zeichnungen, Abbildungen und Tabellen in dieser Arbeit sind von mir selbst erstellt oder wurden mit einem entsprechenden Quellennachweis versehen. Diese Arbeit wurde weder in gleicher noch in ähnlicher Form von mir an dieser oder an anderen Hochschulen eingereicht.")

    v(8%)
    line(length: 50%)
    [#strong(authors.map(author => author.name).join(", "))
    #linebreak()
    #location, den #datetime.today().display("[day].[month].[year]")]
  }
}