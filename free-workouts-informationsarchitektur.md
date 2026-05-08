# Free-Workouts
## Informationsarchitektur fuer Version 1

## Ziel

Die erste Version von Free-Workouts soll nicht wie eine grosse Fitnessplattform wirken, sondern wie ein klares, leichtes Produkt mit wenig Reibung.

Die Architektur muss drei Dinge leisten:

1. sofort erklaeren, worum es geht
2. kostenlose Nutzung ermoeglichen
3. ein kleines Premium-Angebot sichtbar machen

## Kernprinzip

Nicht:

- viele Features
- viele Navigationspunkte
- viele Zielgruppen

Sondern:

- eine klare Startseite
- eine einfache Workout-Uebersicht
- einzelne Workout-Seiten
- ein sichtbares Premium-Angebot

## Sitemap Version 1

### 1. Startseite

Zweck:

- Positionierung
- Einstieg
- Vertrauen
- Weiterleitung zu kostenlosen Workouts
- Premium-Angebot

### 2. Workouts-Uebersicht

Zweck:

- kostenlose Workouts sichtbar machen
- klare Filterung ueber Zeit und Energie
- einfache Orientierung

### 3. Workout-Detailseite

Zweck:

- Workout sofort nutzbar machen
- Struktur und Schritte klar anzeigen
- Teilen ermoeglichen

### 4. Premium-Seite oder Premium-Sektion

Zweck:

- Premium-Angebot klar darstellen
- Unterschiede zu kostenlos zeigen
- Kauf-CTA anbieten

### 5. Ueber / Credibility Light

Zweck:

- persoenliche, ruhige Vertrauensebene
- keine Fitness-Guru-Inszenierung

Optional in Version 1 auch direkt als Bereich auf der Startseite, nicht zwingend als eigene Seite.

## Navigation

Version 1 sollte extrem klein bleiben.

Empfohlene Hauptnavigation:

- `Start`
- `Workouts`
- `Premium`

Optional:

- `Warum`

Nicht noetig fuer v1:

- Login
- Dashboard
- Community
- Blog
- Profil

## Startseite

## Bereich 1: Hero

Inhalt:

- klare Headline
- kurze Subheadline
- Haupt-CTA
- Sekundaer-CTA

Ziel:

- in 5 Sekunden erklaeren, was Free-Workouts ist

Empfohlene CTAs:

- `Kostenlose Workouts ansehen`
- `Premium entdecken`

## Bereich 2: Problem

Inhalt:

- zu wenig Zeit
- zu komplizierte Fitness-Angebote
- zu viel mentale Reibung

Ziel:

- den alltagsnahen Schmerz benennen

## Bereich 3: Loesung

Inhalt:

- kurze Workouts
- zuhause machbar
- nach Energie sortiert
- ohne App-Overkill

## Bereich 4: Workout-Vorschau

Inhalt:

- 3 Workout-Karten
- Dauer
- Energie-Level
- kurzer Nutzen

Ziel:

- sofortige Nutzbarkeit zeigen

## Bereich 5: Premium-Angebot

Inhalt:

- was ist drin
- fuer wen ist es
- Preis
- CTA

## Bereich 6: Vertrauen

Inhalt:

- ehrliche, einfache Positionierung
- keine uebertriebene Autoritaets-Show

Beispielton:

- pragmatisch
- ruhig
- hilfreich

## Workouts-Uebersicht

## Zweck

Die Seite soll in Sekunden benutzbar sein.

## Struktur

- Ueberschrift
- kurzer Orientierungssatz
- Filter-Chips
- Workout-Karten

## Erste Filter

- `10 Minuten`
- `20 Minuten`
- `Low Energy`
- `Medium Energy`
- `Ohne Equipment`

Nicht zu viele Filter in v1.

## Workout-Karte

Jede Karte braucht nur:

- Titel
- Dauer
- Energie-Level
- kurzer Teaser
- Badge: kostenlos oder Premium
- CTA

## Workout-Detailseite

## Kerninhalte

- Titel
- Dauer
- Energie-Level
- Ziel
- Equipment
- Schritte
- kurzer Motivationstext
- CTA fuer Premium

## Layout-Idee

### Oben

- Titel
- Metadaten

### Mitte

- Schritt-fuer-Schritt-Liste

### Unten

- weitere passende Workouts
- Premium-CTA

## Premium-Seite

## Ziel

Nicht aggressiv verkaufen, sondern klar erklaeren:

- fuer wen das Paket ist
- was man bekommt
- warum es hilfreich ist

## Struktur

- klare Headline
- 3 Kernvorteile
- Paketinhalt
- Preis
- CTA
- einfache FAQ

## Paketlogik

Version 1:

- 7 Premium-Workouts
- nach Energie und Zeit sortiert
- 9,99 EUR

## Inhaltsmodell

### Workout

Felder:

- `id`
- `slug`
- `title`
- `summary`
- `durationMinutes`
- `energyLevel`
- `difficulty`
- `equipment`
- `steps`
- `isPremium`
- `category`

### PremiumOffer

Felder:

- `id`
- `title`
- `summary`
- `price`
- `currency`
- `includedWorkoutIds`
- `checkoutUrl`

## Nutzerfluss

### Flow A: kostenloser Erstkontakt

1. Nutzer landet auf Startseite
2. klickt auf kostenlose Workouts
3. sieht Workout-Uebersicht
4. oeffnet Workout
5. nutzt Workout
6. sieht Premium-Hinweis

### Flow B: interessierter Premium-Nutzer

1. Nutzer landet auf Startseite
2. liest Problem und Loesung
3. sieht Premium-Angebot
4. geht auf Premium-Seite
5. klickt Kauf-CTA

## Mobile Prioritaet

Die Seite muss zuerst fuer Mobile gut sein.

Warum:

- Fitness- und Alltagsnutzung ist oft mobil
- kurze Sessions werden oft am Handy geoeffnet
- Links lassen sich leichter teilen

## Tonalitaet

Free-Workouts sollte klingen wie:

- ruhig
- klar
- hilfreich
- alltagstauglich

Nicht wie:

- Fitness-Hustle
- Bro-Performance-Marketing
- Guru-Sprache

## Was bewusst fehlt

Version 1 braucht nicht:

- Login
- Nutzerprofile
- gespeicherte Plaene
- soziale Features
- Kalenderintegration
- grosse Uebungsdatenbank

## Erfolgskriterium fuer die Architektur

Wenn ein Nutzer in unter 30 Sekunden versteht:

- was das ist
- wo kostenlose Workouts sind
- warum Premium existiert

dann ist die Informationsarchitektur gut genug fuer Version 1.

