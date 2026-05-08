# Sonnenkompass Plan

Stand: 2026-05-09

## Erledigt

- neuesten GitHub-Code von `https://github.com/HannesRammer/sonnenkompass` geholt und lokal auf `origin/main` fast-forwarded
- aktuellen Remote-Stand geprueft: `61ab0a8` nach UI-Merge (`dda95c8`) und Web-only-Umstellung
- statische Analyse ausgefuehrt
- offizielle Flutter-Dokumentation zu adaptivem/responsivem UI und Large-Screen-Navigation gegengeprueft
- offizielle Flutter-Dokumentation zu Routing auf Web, URL-Strategie und lokaler Key-Value-Persistenz gegengeprueft
- offensichtlichen Build-/Testbruch im Theme behoben (`GoogleFonts.jetBrainsMono`)
- Web-Metadaten auf Produktkontext angepasst
- Path-URL-Strategie fuer Web aktiviert
- GoRouter-basierte Mehrscreen-Struktur gebaut
- AppShell mit Navigation Rail / Navigation Bar gebaut
- lokales Persistenzmodell mit `shared_preferences` eingebaut
- App-State zentralisiert und aus der alten Einseiten-View herausgeloest
- Orbit-State logisch stabilisiert, damit Fokus-IDs nach UI-Aenderungen nicht in tote Referenzen laufen
- konkrete Tagesaufgaben aus `Task` und `FocusDay` sichtbar gemacht
- Seed-Daten fuer Trading, Bewegung und Alltag ergaenzt, damit keine leeren Strahlen mehr bleiben
- Projekt-Detailseite, Ideen-Detailseite und Review-Seite mit echten Aktionen gebaut
- Ideen-zu-Projekt-Umwandlung implementiert
- gemischte Label-Sprache weitgehend vereinheitlicht
- leere `lib/src/features/free_workouts`-Struktur entfernt
- alte monolithische Home-Page entfernt
- Widget-Tests an die neue Architektur angepasst und erweitert
- fachfremde Alt-Markdown-Dateien entfernt, damit das Repo nur noch Sonnenkompass-relevante Doku enthaelt

## Analyse: was besser ist

- die App ist keine Einseiten-Demo mehr, sondern eine echte Web-App mit Routen und Detailansichten
- Persistenz macht Interaktion jetzt zustandsbehaftet statt rein fluechtig
- Kern, Orbit, Tagesaufgaben, Strahlwechsel, Ideenpflege und Review greifen konsistenter ineinander
- Projekte und Ideen enden nicht mehr nur in Karten, sondern fuehren zu echten Detail- und Bearbeitungsansichten

## Analyse: was fehlt oder zu stark von sauberer Produktlogik abweicht

### Fachlich/produktlich

- `MediaAttachment` und echte Referenz-/Belegobjekte sind modelliert, aber noch nicht in die UI integriert.
- es fehlen externe Links, Quellen oder Artefakte pro Projekt bzw. Idee.
- es gibt noch keine mehrtaegige Verlaufslogik oder echte Historie ueber Reviews hinweg.

### UX-/Inhaltsqualitaet

- Die App ist jetzt deutlich naeher an einer Arbeitsanwendung, aber noch nicht bei Sync-, Backup- und Historienreife.
- Task-Planung ist noch nicht vollstaendig im UI editierbar.

## Naechste sinnvolle Schritte

- echte Link- und Objektstruktur einfuehren: pro Projekt mindestens Referenzlink, Artefakt oder Output-Beweis
- `MediaAttachment` sichtbar machen und sinnvoll an Projekte oder Ideen haengen
- Sync-/Backend-Strategie entscheiden: weiter lokal, JSON-Export, Supabase oder Firebase
- Task-Erstellung und Task-Bearbeitung im UI vervollstaendigen
- Verlaufs-/Historienansicht fuer Reviews und Fokuswechsel bauen

## Offene To-dos

- Browser-Check des laufenden Web-Builds gegen echte Render-/Overflow-Probleme
- inhaltliche Verlinkung und Medienbelege fuer Projekte und Ideen implementieren
- Tests ueber Rendering und Navigation hinaus fuer State-Persistenz und Kernfluss ausbauen
- README spaeter um Architektur- und Datenflussbild ergaenzen
