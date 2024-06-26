#import "template.typ": Template, todo
#import "@preview/glossarium:0.3.0": gls
#let translations = json("translations.json").at("de")

#show: Template.with(
  bib: arguments("sources.bib", style: "frontiers"), 
  appendix: (
    [
      #heading("Wichtiger Anhang",supplement: [#translations.appendix])
      #lorem(100)
    ],
    [
      #heading("Weiterer Wichtiger Anhang",supplement: [#translations.appendix]) <ref>
      #lorem(100)
    ]
  ),
  confidental_clause: true,
  glossary_entries: (
    ( key: "oidc", short: "OIDC", long: "Open ID Connect" ),
  )
)

= Einleitung
#lorem(15)

Wenn ich @oidc zum ersten mal erwähne wird es ausgeschrieben. \
Beim zweiten Mal wird @oidc nur abgekürzt. 

#pagebreak()

= Grundlagen
#lorem(100)
== Unterpunkt
#lorem(100)
#figure(
  image("img/provadis.png", width: 80%),
  caption: [A curious figure.],
) <glacier>
#pagebreak()

== Unterpunkt
#todo()
@Effectiv92:online

asdasdas
#lorem(100)
=== Unter-Unterpunkt
#todo(body: "Hier ist noch was zu tun!")
=== Unter-Unterpunkt
#pagebreak()

== Unterpunkt
#lorem(100)

=== Unter-Unterpunkt
#lorem(100)

= Zusammenfassung

