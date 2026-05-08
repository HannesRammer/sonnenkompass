# Sonnenkompass App Dokumentation

Stand: 2026-05-09

## Ziel dieser Doku

Diese Datei erklaert die aktuelle Sonnenkompass-App so, dass man spaeter schnell versteht:

- was die App heute schon kann
- wie die Screens aufgebaut sind
- warum das Layout und die Struktur so gewaehlt wurden
- welche Produktentscheidungen bewusst so getroffen wurden
- wo das Modell noch nicht weit genug ist
- wo als naechstes sinnvoll weitergebaut werden sollte

Sie ist absichtlich keine reine Changelog-Datei, sondern eine Arbeits- und Entscheidungsdoku.

## Produktidee

Der Sonnenkompass ist kein normaler Projektmanager und kein normaler Kalender.

Er ist eine Mischung aus:

- Sonnenkompass
- Stundenplan
- Fokus-System
- Kreis- und Orbitmodell

Er soll fuer einen kreativen Multi-Projekt-Menschen gleichzeitig drei Dinge loesen:

- Fokus begrenzen
- viele Ideen und Projekte trotzdem sichtbar halten
- Alltagsrealitaet wie Arbeit, Energie, Bewegung und Routinen mitdenken

Das Kernprinzip bleibt:

`Parallel im Kopf, seriell im Leben.`

## Was die App aktuell ist

Die App ist aktuell eine lokale Flutter-Web-App mit:

- mehreren echten Screens
- Browser-History und Deep-Link-faehigen Routen
- lokalem persistentem Zustand
- Projekt-, Ideen-, Orbit-, Task- und Review-Logik

Sie ist damit keine reine Designstudie mehr, aber noch keine vollstaendige produktionsreife Arbeitsanwendung.

## Architekturueberblick

### App-Einstieg

- Einstieg ueber [lib/main.dart](D:/projects/Projects/sonnenkompass/lib/main.dart)
- dort wird Path-URL-Strategie fuer Web aktiviert
- danach startet [lib/src/app.dart](D:/projects/Projects/sonnenkompass/lib/src/app.dart)
- die eigentliche App-Struktur lebt in [lib/src/features/sonnenkompass/sonnenkompass_app.dart](D:/projects/Projects/sonnenkompass/lib/src/features/sonnenkompass/sonnenkompass_app.dart)

### Routing

Die App nutzt `go_router`, weil eine Web-App mit echten Bereichen und Browser-Navigation sonst zu schnell inkonsistent wird.

Aktuelle Routen:

- `/dashboard`
- `/today`
- `/rays`
- `/rays/:rayId`
- `/projects/:projectId`
- `/ideas/:ideaId`
- `/review`

Warum das sinnvoll ist:

- Bereiche sind direkt adressierbar
- Browser Back/Forward funktioniert sauberer
- die App ist nicht mehr an eine monolithische Seite gebunden
- Detailseiten fuer Projekte und Ideen sind echt statt eingeblendete Sub-Container

### AppShell

Die uebergeordnete Navigation lebt in [app_shell.dart](D:/projects/Projects/sonnenkompass/lib/src/features/sonnenkompass/ui/app_shell.dart).

Sie nutzt:

- `NavigationRail` auf groesseren Screens
- `NavigationBar` auf kleineren Screens

Warum das sinnvoll ist:

- grosse Bildschirme bekommen eine dauerhafte Bereichsnavigation
- mobile oder schmale Layouts bleiben kompakt
- dieselbe App-Struktur funktioniert fuer Desktop und Mobile

### Zustand / Datenhaltung

Die zentrale State-Schicht lebt in [app_store.dart](D:/projects/Projects/sonnenkompass/lib/src/core/app_store.dart).

Der Store haelt aktuell:

- `projects`
- `ideas`
- `tasks`
- `orbitItems`
- `focusDay`
- `movementPlan`
- `completedRoutineIds`
- `completedRhythmTaskIds`

Persistenz erfolgt lokal ueber `shared_preferences`.

Warum das sinnvoll ist:

- fuer Version 1 ist lokaler Zustand ausreichend
- wir koennen echte Interaktion bauen, ohne sofort ein Backend zu brauchen
- State-Aenderungen sind zentral, statt auf viele Widgets verteilt zu sein

Grenze:

- nur lokaler Speicher
- kein Sync
- keine Multi-Device-Strategie
- keine echte Verlaufsdatenbank

### AppScope

Der Zugriff auf den Store wird ueber [app_scope.dart](D:/projects/Projects/sonnenkompass/lib/src/core/app_scope.dart) als InheritedNotifier bereitgestellt.

Warum das aktuell ok ist:

- fuer diese App-Groesse reicht das
- wenig Boilerplate
- keine zusaetzliche State-Management-Schicht noetig

Wann das spaeter kippt:

- wenn Undo/Redo
- komplexere Mehrbenutzer- oder Offline-Sync-Logik
- feinere abhaengige State-Bereiche

## Aktuelle Screens

### 1. Dashboard

Datei:

- [dashboard_page.dart](D:/projects/Projects/sonnenkompass/lib/src/features/sonnenkompass/ui/dashboard_page.dart)

Zweck:

- schneller Ueberblick
- aktueller Kernfokus
- Orbit
- naechste relevante Tagesarbeit
- sichtbares Kreis- und Zeitmodell statt nur Listen

Wichtige Bereiche:

- `Sonnenkompass Modell`
- `Heute im Kern`
- `Orbit`
- `Naechste Schritte`
- `Zeitstrahlen`

Warum das so gebaut ist:

- Dashboard soll Orientierung geben, nicht alles editierbar machen
- der Kernfokus muss sofort sichtbar sein
- Orbit und Tagesarbeit muessen vom ersten Screen aus lesbar sein
- die Produktidee braucht eine Form, die Fixes, Fokus und Tageszeit gleichzeitig zeigen kann

Was daran noch nicht perfekt ist:

- Fixkreis und Zeitstrahlen sind noch aus vorhandenem Tageszustand abgeleitet
- keine echte Fortschrittsvisualisierung
- noch keine Historie oder Aktivitaetszusammenfassung

### 2. Heute

Datei:

- [today_page.dart](D:/projects/Projects/sonnenkompass/lib/src/features/sonnenkompass/ui/today_page.dart)

Zweck:

- tatsaechliche Tagesausfuehrung
- Aufgaben, Routinen und Zeitanker gemeinsam sichtbar machen

Wichtige Bereiche:

- `Muss heute passieren`
- `Optional wenn Luft da ist`
- `Block-Stundenplan`
- `Pflege- und Rhythmuslogik`

Warum das so gebaut ist:

- der Nutzer braucht nicht nur Projektkontext, sondern Tagesrealitaet
- Fokus ohne Zeitanker und Alltagslast waere fuer dieses System zu theoretisch
- Routinen und Rhythmus sind hier bewusst nicht versteckt

Grenze:

- noch kein echter Task-Editor
- noch keine automatische Tagesplanung
- `Heute` ist stark Anzeige plus Toggle, aber noch nicht voller Planer

### 3. Strahlen

Datei:

- [rays_page.dart](D:/projects/Projects/sonnenkompass/lib/src/features/sonnenkompass/ui/rays_page.dart)

Zweck:

- Bereiche des Lebens- und Projektsystems sichtbar halten
- Projekte, Ideen und Aufgaben pro Strahl buendeln

Aktuell sichtbare Inhalte:

- radiale Strahlwahl plus Chip-Auswahl
- Projekte im Strahl
- Aufgaben im Strahl
- Ideen im Strahl
- neue Idee anlegen

Warum das so gebaut ist:

- Strahlen sind langfristige Orientierungsbereiche
- sie sollen nicht mit dem Tageskern verwechselt werden
- trotzdem muessen sie als Einstieg in Projekte und Ideen dienen

Grenze:

- Strahlen sind aktuell noch eher Listencontainer
- das tiefere Kreis-/Fixkreis-/Zeitstrahlen-Modell ist dort schon optisch angedeutet, aber noch nicht als eigene Fachlogik ausmodelliert

### 4. Projekt-Detailseite

Datei:

- [project_detail_page.dart](D:/projects/Projects/sonnenkompass/lib/src/features/sonnenkompass/ui/project_detail_page.dart)

Zweck:

- Projekt nicht nur anzeigen, sondern bearbeitbar machen

Aktuelle Funktionen:

- Projektstatus ansehen und aendern
- Projekt in den Kern setzen
- Projekt in den Orbit setzen oder daraus entfernen
- verknuepfte Aufgaben sehen
- Task-Status aendern
- verknuepfte Ideen sehen

Warum das so gebaut ist:

- Projekte brauchen eine echte Zielseite
- Kern/Orbit darf nicht nur im Dashboard passieren
- Aufgaben sind die konkrete Arbeitsoberflaeche pro Projekt

Grenze:

- keine Bearbeitung von Titel/Beschreibung/Ziel direkt im UI
- keine externen Links, Medien oder Artefakte
- keine Unterprojekte oder Projekt-Historie

### 5. Ideen-Detailseite

Datei:

- [idea_detail_page.dart](D:/projects/Projects/sonnenkompass/lib/src/features/sonnenkompass/ui/idea_detail_page.dart)

Zweck:

- Ideen nicht als tote Listenobjekte behandeln

Aktuelle Funktionen:

- Idee lesen
- Status anpassen
- naechsten Schritt sehen
- Idee in Projekt umwandeln

Warum das so gebaut ist:

- Ideen muessen entweder reifen, ruhen oder zu Projekten werden
- genau dieser Uebergang ist fachlich zentral fuer den Sonnenkompass

Grenze:

- keine Dublettenpruefung
- keine feinere Ideenklassifikation
- keine Anhange, Quellen oder Notizsammlung

### 6. Review

Datei:

- [review_page.dart](D:/projects/Projects/sonnenkompass/lib/src/features/sonnenkompass/ui/review_page.dart)

Zweck:

- Tagesende nicht verlieren
- Fokus, Ablenkung und Ergebnis festhalten

Aktuelle Funktionen:

- Tagesnotiz speichern
- Ablenkungen speichern
- Tagesreview speichern
- App auf Seed-Stand zuruecksetzen

Warum das so gebaut ist:

- ein Fokus-System ohne Rueckblick verliert Lernfaehigkeit
- Tagesreview ist hier kein Extra, sondern Teil des Kernflusses

Grenze:

- nur ein einzelner gespeicherter Tageszustand
- keine Review-Historie
- noch keine Auswertung ueber mehrere Tage

## Layout- und Designentscheidungen

### Warum dunkles Theme

Das aktuelle Theme setzt auf:

- schwarzen Grund
- warme Bernstein-/Gold-Akzente
- editoriale Typografie

Warum:

- soll nicht wie generische Business-Software wirken
- passt besser zur Sonnen-/Orbit-Metapher
- schafft klare Hierarchie zwischen Hauptfokus und Hintergrund

### Warum Kreislayout plus Panel-Struktur

Die App nutzt jetzt nicht nur Panels, sondern im Dashboard und bei den Strahlen auch kreisfoermige Layouts.

Warum:

- die Grundidee ist radialer als eine normale Business-App
- Kern, Orbit, Strahlen und Zeitfenster lassen sich als Schichten besser denken
- das Produkt fuehlt sich dadurch staerker wie ein eigenes System an statt wie ein Standard-Kanban

Grenze:

- Kreislayouts sind heikler fuer kleine Screens
- sie muessen in echter Browser-Ansicht noch genauer auf Balance und Dichte geprueft werden

### Warum Panel-Struktur

Viele Screens sind in Panels organisiert.

Warum:

- grosse Themenblöcke bleiben trennbar
- komplexere Inhalte werden visuell gebuendelt
- auf Desktop funktioniert das als klare Arbeitsflaeche gut

Nachteil:

- kann auf Dauer etwas zu kartenlastig werden
- spaeter evtl. differenziertere Layouttypen noetig

### Warum Detailseiten statt alles auf einer Seite

Die alte monolithische Home-Page wurde bewusst entfernt.

Warum das keinen Sinn mehr gemacht hat:

- zu viele Inhalte gleichzeitig
- keine echte Adressierbarkeit
- keine saubere Browser-Navigation
- Detailobjekte wie Projekt oder Idee hatten keine natuerliche Zielseite

Warum die neue Struktur besser ist:

- klarere Verantwortung pro Screen
- bessere Deep Links
- bessere Erweiterbarkeit

## Datenmodell: was heute schon gut ist

Die App arbeitet bereits mit einem brauchbaren Kernmodell:

- `Ray`
- `Project`
- `Idea`
- `Task`
- `OrbitItem`
- `FocusDay`
- `MovementPlan`
- `DailyRoutineBlock`
- `RhythmTask`
- `FixedSlot`

Das ist gut, weil:

- Fokuslogik und Alltagsrealitaet bereits zusammenkommen
- Ideen und Projekte getrennt sind
- Orbit eine Aktivierungsschicht bleibt

## Datenmodell: was noch nicht stark genug ist

### 1. Fixkreis / Kreismodell

Das aktuelle Modell denkt vor allem in:

- Rays
- Orbit
- FocusDay

Dein spaeteres staerkeres Modell braucht aber wahrscheinlich explizit:

- `Fixkreis`
- `Kern`
- `Orbit`
- `Strahlen`
- `Zeitstrahlen`
- optional `Archivring`

Aktuell ist das fachlich in der UI bereits sichtbar, aber noch nicht sauber als getrennte Fachschicht modelliert.

### 2. Zeitstrahlen

Es gibt zwar:

- fixe Slots
- Routinen
- Rhythmus
- Tagesaufgaben

Aber noch keine eigene Modellschicht fuer:

- Vormittagsstrahl
- Nachmittagsstrahl
- Abendstrahl

oder allgemein fuer zeitliche Aktivierungsachsen pro Tag.

### 3. Medien und Referenzen

`MediaAttachment` existiert als Modell, ist aber im Produkt noch unbenutzt.

Das fuehrt aktuell dazu:

- Projekte und Ideen haben noch keine echten Belege
- keine Links zu Quellen
- keine Artefakte
- keine Screenshots oder Audios als Bestandteil der Arbeitsobjekte

## Was aktuell keinen Sinn macht oder noch schwach ist

### Keine Historie

Es gibt noch keine echte Tagebuch- oder Review-Historie.

Das ist fuer eine Arbeitsanwendung zu schwach, weil:

- Muster ueber Zeit nicht sichtbar werden
- Fokuswechsel nicht nachvollziehbar bleiben
- Review nur als Momentaufnahme existiert

### Lokale Persistenz reicht nur fuer V1

`shared_preferences` ist fuer Version 1 gut genug.

Langfristig nicht stark genug fuer:

- groessere Objektmengen
- echte Exportfaehigkeit
- Sync
- mehrere Geraete
- robuste Weiterentwicklung

### Task-Bearbeitung noch nicht vollstaendig

Task-Status ist aenderbar, aber:

- neue Tasks koennen noch nicht sauber im UI erstellt werden
- bestehende Tasks sind nicht voll editierbar
- keine Priorisierung im UI
- keine echte Umplanung

### Strahlen sind noch zu flach

Die Strahlenansicht funktioniert, aber:

- sie ist noch eher Listenstruktur als echtes Navigations- und Denkmodell
- das tiefere Sonnen-/Kreis-/Zeitmodell ist dort noch nicht visuell praesent

## Wo als naechstes sinnvoll weiterarbeiten

### Prioritaet 1

- Fixkreis / Kern / Orbit / Strahlen / Zeitstrahlen als explizites Modell definieren
- daraus ableiten, welche Dinge keine normalen Strahlen sind

### Prioritaet 2

- Task-Erstellung, Task-Bearbeitung und Task-Planung im UI fertig machen

### Prioritaet 3

- Verlauf und Review-Historie ueber mehrere Tage

### Prioritaet 4

- Medien, Referenzlinks und Artefakte integrieren

### Prioritaet 5

- spaetere Sync-/Backend-Strategie entscheiden

## Fazit

Die App ist aktuell:

- deutlich ueber Demo-Niveau
- logisch schon brauchbar
- strukturell erweiterbar

Aber sie ist noch nicht am Endmodell des Sonnenkompasses.

Der groesste naechste Entwicklungsschritt ist nicht mehr nur Technik, sondern das fachliche Modell:

- Was ist wirklich Strahl?
- Was ist Fixkreis?
- Was ist Kern?
- Was ist Orbit?
- Was ist Zeitstrahl?

Sobald das sauber entschieden ist, kann die App-Struktur noch deutlich praeziser und staerker werden.
