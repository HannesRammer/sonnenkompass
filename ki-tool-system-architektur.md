# Sonnenkompass im KI-Tool-System

## Ziel

Der Sonnenkompass soll nicht als einzelner Prompt oder einzelner Assistent gebaut werden, sondern als **zentrale Fokus- und Orchestrierungsschicht** innerhalb eines groesseren KI-Tool-Systems.

Er ist damit nicht "noch eine KI", sondern das Modul, das bestimmt:

- was heute aktiv ist
- was nur gespeichert wird
- welche KI fuer welche Aufgabe zustandig ist
- welche Informationen nur Vorschlaege sind
- welche Informationen in echte Systemaenderungen uebergehen

Kurz:

**Der Sonnenkompass ist dein persoenlicher Scheduler fuer Projekte, Energie, Alltag und KI-Werkzeuge.**

## Grundidee

Dein Gesamtprojekt besteht aus mehreren Ebenen:

1. `Menschliche Ebene`
2. `Sonnenkompass-Kernlogik`
3. `KI-Orchestrierung`
4. `Spezialisierte Tools und Modelle`
5. `Daten- und Medienbasis`

Der Sonnenkompass sitzt in der Mitte. Er ist der Ort, an dem entschieden wird:

- Was ist Tageskern?
- Was ist Orbit?
- Welche Idee wird nur gespeichert?
- Welche KI darf helfen?
- Welche Aktion bleibt nur ein Vorschlag?

## Architekturprinzip

Die Architektur sollte auf drei klar getrennten Rollen basieren:

### 1. Feste App-Logik

Das ist die harte Struktur des Systems.

Beispiele:

- Sonnenstrahlen
- Orbit-Regeln
- Fokusgrenzen
- Statusmodelle
- Datenhaltung
- Kalender- und Tagesobjekte
- Berechtigungen fuer automatische Aenderungen

### 2. KI-Assistenz

Das ist die interpretierende Schicht.

Beispiele:

- Ideen verstehen
- Medien analysieren
- passende Sonnenstrahlen vorschlagen
- Zusammenfassungen erzeugen
- Prioritaet einschaetzen
- aehnliche Ideen zusammenfuehren
- Tagesvorschlaege generieren

### 3. Tool-Ausfuehrung

Das ist die operative Schicht.

Beispiele:

- Idee speichern
- Medien anhaengen
- Idee in Orbit verschieben
- Wochenplan erzeugen
- Kalendereintrag vorschlagen
- Visual prompt erzeugen

Wichtig:

**Die KI denkt und empfiehlt. Die App-Struktur entscheidet und speichert.**

## Die Module deines KI-Tool-Systems

### Modul 1: Sonnenkompass Core

Das ist das wichtigste Modul.

Verantwortung:

- Sonnenkern
- Sonnenstrahlen
- Strahl-Backlogs
- Orbit
- Fokusregeln
- Tages- und Wochenmodell
- Energie-Level
- Arbeitsmodus: Homeoffice oder Buero
- Alltag: Katzen, Haushalt, Bewegung

Dieses Modul ist die Quelle der Wahrheit fuer Fokus.

### Modul 2: Idea Capture Engine

Dieses Modul nimmt neue Inputs entgegen.

Input-Typen:

- Freitext
- Sprachnotiz
- Screenshot
- Bild
- Skizze
- Link
- PDF
- kurzer Gedanke

Verantwortung:

- Input klassifizieren
- Sonnenstrahl vorschlagen
- Titel generieren
- Beschreibung komprimieren
- Tags extrahieren
- Projektbezug erkennen
- Prioritaet vorschlagen
- Status setzen: gespeichert, aktivierbar, unklar, archiviert

Dieses Modul darf **nicht** automatisch den Sonnenkern aendern.

### Modul 3: Orbit Manager

Dieses Modul verwaltet aktive Dinge.

Verantwortung:

- genau 1 Hauptfokus aktiv halten
- maximal 1 bis 2 Nebenbereiche zulassen
- Konflikte erkennen
- verhindern, dass neue Ideen aktive Themen uebersteuern
- bewusste Aktivierung erzwingen

Entscheidungsregel:

- neue Idee -> zuerst Strahl-Backlog
- erst nach bewusster Freigabe -> Orbit

### Modul 4: Focus Planner

Dieses Modul plant Tage und Wochen auf Basis deiner Realitaet.

Verantwortung:

- Tagesvorschlag erzeugen
- Wochenrotation fuer Projekte aufbauen
- Energie-Level beruecksichtigen
- Arbeitsblock-Regeln respektieren
- Urban Sports integrieren
- Homeoffice und Buero unterschiedlich behandeln

Besondere Regeln:

- `09:45-10:45` bleibt blockiert fuer Arbeit
- taegliche Bewegung ist Standard
- Projektarbeit abends nur bei echter Kapazitaet

### Modul 5: Visual Studio Layer

Dieses Modul produziert visuelle Artefakte.

Beispiele:

- visuelle Sonnenansicht
- UI-Mockups
- Diagramme
- Moodboards
- visuelle Wochenuebersicht
- Sonnenstrahl-Illustrationen

Dieses Modul ist nicht die Quelle der Wahrheit fuer Logik. Es visualisiert, was der Core vorgibt.

### Modul 6: Memory and Knowledge Layer

Dieses Modul speichert laengerfristigen Kontext.

Beispiele:

- Projektbeschreibungen
- Entscheidungen
- Regeln
- bevorzugte Sportorte
- typische Energie-Muster
- archivierte Ideen
- wiederkehrende Themen

Es dient dazu, dass das System mit dir mitwaechst, ohne chaotisch zu werden.

### Modul 7: Tool Router

Dieses Modul entscheidet, welches Tool oder Modell benutzt wird.

Beispiele:

- Text-KI fuer Strukturierung
- Vision-Modell fuer Skizzenanalyse
- Speech-to-text fuer Sprachnotizen
- Kalender- oder Reminder-Tools fuer Planung
- Visual-KI fuer Moodboards oder UI-Stile

Der Router bekommt seinen Kontext vom Sonnenkompass, nicht umgekehrt.

## KI-Rollen in deinem System

Statt "eine KI fuer alles" solltest du mit Rollen arbeiten.

### 1. Fokus-KI

Aufgabe:

- schuetzt Fokus
- priorisiert nicht aggressiv, sondern realistisch
- prueft: speichern, planen oder aktivieren?

Typische Outputs:

- "Diese Idee passt in Coding / Apps und sollte nur gespeichert werden."
- "Diese Idee ist stark verwandt mit Console."
- "Nicht fuer heute aktivieren."

### 2. Struktur-KI

Aufgabe:

- macht aus chaotischem Input saubere Eintraege
- erzeugt Titel, Kurzbeschreibung, Tags und Beziehungen

Typische Outputs:

- strukturierte Ideenobjekte
- Cluster aehnlicher Gedanken
- Projekt- oder Ray-Zuordnungen

### 3. Visuelle KI

Aufgabe:

- erzeugt visuelle Richtungen, Kompass-Darstellungen, Screen-Ideen, Moodboards

Typische Outputs:

- visuelle Sonne
- UI-Skizzen
- Komponentenideen

### 4. Analyse-KI

Aufgabe:

- erkennt Muster ueber Zeit
- sieht, welche Strahlen ueberfuellt sind
- erkennt Fokusverlust
- gibt Wochen- oder Monatsrueckblicke

Typische Outputs:

- "Du speicherst viele Coding-Ideen, aber aktivierst zu viele gleichzeitig."
- "Bewegung ist stabil, Kreativprojekte sind im Orbit unterrepraesentiert."

### 5. Aktions-KI

Aufgabe:

- schlaegt konkrete Aktionen ueber Tools vor
- ruft nur erlaubte Funktionen auf

Typische Outputs:

- `add_idea_to_ray`
- `attach_media_to_idea`
- `create_focus_plan_for_today`

## Datenfluss

So sollte der typische Datenfluss aussehen:

### Neue Idee

1. Input kommt rein
2. Idea Capture Engine analysiert den Inhalt
3. Struktur-KI erzeugt einen strukturierten Vorschlag
4. Fokus-KI prueft, ob Aktivierung ueberhaupt sinnvoll waere
5. Standardfall: Speicherung im passenden Strahl
6. Optional: User bestaetigt spaetere Aktivierung

### Neuer visueller Entwurf

1. Du gibst Prompt, Skizze oder Screenshot
2. Visual Studio Layer analysiert oder erzeugt Visuals
3. Ergebnis wird mit Projekt oder Idee verknuepft
4. Sonnenkompass-Core bleibt unveraendert, solange du nichts aktivierst

### Tagesplanung

1. Focus Planner liest:
   - offene Orbit-Elemente
   - Energie-Level
   - Arbeitsmodus
   - Bewegungspflicht
   - Haushalt / Alltag
2. Fokus-KI macht einen realistischen Vorschlag
3. Orbit Manager prueft Grenzen
4. Ergebnis wird als `FocusDay` gespeichert

## Zentrale Objekte

Diese Daten sollten zentral gespeichert werden und nicht nur in Prompts leben.

### User

- Profil
- Arbeitsrealitaet
- Energie-Muster
- Routinen
- Sportpraeferenzen

### Ray

- Name
- Beschreibung
- Farbe / visuelle Identitaet
- Typ
- Unterstrahlen
- Sortierung

### Project

- Name
- zugehoeriger Strahl
- Status
- Reifegrad
- aktive Phase

### Idea

- Titel
- Beschreibung
- Ray
- Project optional
- Status
- Prioritaet
- Tags
- Medien
- Herkunft
- Erstellungsdatum

### OrbitItem

- Referenz auf Project, Idea oder Task
- Rolle: Hauptkern oder Nebenbereich
- Aktivierungsdatum
- Ablauf- oder Review-Zeitpunkt

### FocusDay

- Datum
- Hauptfokus
- Nebenbereiche
- Energie-Level
- Arbeitsmodus
- Bewegungsplan
- Tagesnotiz

### MediaAttachment

- Typ
- Quelle
- Vorschau
- Transkript oder Analyse
- Verknuepfung zu Idea oder Project

## Welche Tools oder KIs wofuer geeignet sind

Das ist absichtlich abstrahiert, damit dein KI-Tool-Projekt offen bleibt.

### Text- und Reasoning-Modelle

Geeignet fuer:

- Ideen strukturieren
- Fokuspruefung
- Wochenplanung
- Regelinterpretation
- Zusammenfassungen

### Vision-Modelle

Geeignet fuer:

- Skizzenanalyse
- Screenshot-Verstaendnis
- Moodboard-Auswertung
- UI-Richtung erkennen

### Audio-Modelle

Geeignet fuer:

- Sprachnotizen transkribieren
- kurze Voice-Ideen verdichten
- Stimmung oder Dringlichkeit abschaetzen

### Visual-Generation-Tools

Geeignet fuer:

- visuelle Version des Sonnenkompasses
- Poster
- App-Mockups
- Illustrationen

### Kalender- oder Reminder-Tools

Geeignet fuer:

- Sport-Slots
- Regenerations-Termine
- Fokusbloecke
- Wochenstruktur

## Was der Sonnenkompass entscheiden darf

Der Sonnenkompass-Core darf:

- Strukturen verwalten
- Fokusgrenzen durchsetzen
- Orbit begrenzen
- Ideen speichern
- Status verwalten
- Tagesplaene speichern

Die KI darf:

- zuordnen
- vorschlagen
- zusammenfassen
- priorisieren helfen
- Aktivierung empfehlen oder davon abraten

Die KI darf nicht autonom:

- den Hauptfokus wechseln
- wichtige Ideen loeschen
- Projektstatus hart umstellen
- Regeln stillschweigend aendern
- den Orbit ohne bestaetigte Logik ueberladen

## Orchestrierungsregel fuer dein KI-Tool-Projekt

Die wichtigste Regel fuer das Gesamtprojekt lautet:

**Nicht jede KI darf direkt auf dein System schreiben.**

Stattdessen drei Stufen:

1. `Analyse`
2. `Vorschlag`
3. `Bestaetigte Aktion`

Das schuetzt dich vor genau dem Problem, das du eigentlich vermeiden willst: mehr Intelligenz, aber auch mehr Chaos.

## Empfohlene MVP-Reihenfolge

### Phase 1: Sonnenkompass Core

Baue zuerst:

- Rays
- Projects
- Ideas
- Orbit
- FocusDay
- Regeln

Noch ohne viele KIs.

### Phase 2: Idea Capture

Dann:

- Texteingabe
- schnelle Idee-Erfassung
- Ray-Vorschlag
- Titel/Beschreibungs-Vorschlag

### Phase 3: Multimodalitaet

Dann:

- Bild
- Screenshot
- Skizze
- Voice Note

### Phase 4: Planner und Analyse

Dann:

- Tagesplanung
- Wochenrotation
- Energie-Erkennung
- Monatsanalyse

### Phase 5: Visuelle Systeme

Dann:

- UI-Sonne
- Kompass-Dashboard
- visuelle Projektgalaxie

## Konkreter Nutzen fuer dein KI-Tool-Projekt

Der Sonnenkompass wird in deinem groesseren System zu diesen Dingen:

- Fokus-Governor
- Aktivierungsfilter
- Projekt-Scheduler
- Kontextquelle fuer alle anderen KIs
- Schutzschicht gegen Verzettelung

Damit ist er nicht nur eine App-Idee, sondern ein Kernbaustein deiner gesamten KI-Architektur.

## Naechster sinnvoller Schritt

Die Architektur ist jetzt auf Systemebene klar.

Der naechste technische Schritt sollte einer von diesen beiden sein:

1. `Datenmodell definieren`
   - konkrete Entities
   - Felder
   - Statuswerte
   - Beziehungen

2. `MVP-Screens definieren`
   - Startscreen
   - Sonnenansicht
   - Strahl-Detail
   - Idee-Erfassung
   - Orbit
   - Tagesplan

Empfehlung:

**Erst Datenmodell, dann Screens.**

