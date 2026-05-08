# Rammer Sonnenkompass

Aktueller Stand der webbasierten Sonnenkompass-App auf Basis von Flutter Web.

## Ziel

Der Sonnenkompass ist nicht nur ein Kompass. Er ist eine Mischung aus Fokus-System, Stundenplan, Kreislogik und Projektsteuerung fuer einen kreativen Multi-Projekt-Menschen mit:

- 40-Stunden-Job
- flexiblen Arbeitszeiten
- zwei Katzen
- Haushalt
- taeglicher Bewegung
- vielen parallelen Ideen in Coding, Kreativem, Business und Finanzen

Das Kernprinzip lautet:

**Parallel im Kopf, seriell im Leben.**

Ideen duerfen parallel existieren. Umsetzung wird bewusst gebuendelt.

## Kernmodell

- `Kern`: genau 1 Hauptfokus fuer den Tag
- `Fixkreis`: wiederkehrende Pflichten, Routinen und unverhandelbare Tagesanker
- `Orbit`: nur 1 Hauptfokus plus maximal 1 bis 2 aktive Nebenbereiche
- `Strahlen`: 6 bis 8 langfristige Lebens- und Projektbereiche
- `Zeitstrahlen`: reale Tagesfenster wie Vormittag, Nachmittag und Abend
- `Archiv`: pausierte, verworfene oder erledigte Themen bleiben nachvollziehbar

## Realitaetsmodell

- Vormittag ist fuer Arbeit gesetzt
- `09:45-10:45` ist unantastbare Arbeitszeit
- Homeoffice und Buero sind zwei unterschiedliche Modi
- Nachmittage sind flexibler
- Abends ist optionaler Fokus moeglich
- Bewegung soll taeglich stattfinden

## Arbeitsrealitaet

- Wohnort: Galvanistrasse 14, 10587 Berlin-Charlottenburg
- Arbeit: Englische Strasse 23, 10587 Berlin-Charlottenburg
- Kurzer Arbeitsweg: ca. 20 Minuten zu Fuss, ca. 10 Minuten mit dem Fahrrad
- Homeoffice moeglich
- Flexibler Arbeitstag, aber vormittags verbindlicher Aktivitaetskern

## Empfohlene Sonnenstrahlen

1. Coding / Apps
2. Kreativ / Schreiben
3. Business / Produktideen
4. Trading / Finanzen
5. Bewegung / Urban Sports / Gesundheit
6. Haushalt / Katzen / Alltag
7. Lernen / Recherche
8. Sozial / Kommunikation

## Projektlandschaft

### Coding / Apps

- Console
- Crazy Chess / RammerSchach
- Kunststaub.fm
- Free-Workouts.com
- AUIServer

### Kreativ

- Buch: "Stimmt, du hast recht..."
- Lyrics / Texte
- Menschen essen Mansion
- Materie-Alien Branding

### Business / Ideen

- Sticker App
- Plattformideen
- Monetarisierung

### Finanzen

- Trading Analyse
- Trading-Bot-Ideen

## Sport- und Bewegungsmodell

Urban Sports Club Premium ist fester Teil des Systems.

Ziel:

- `30/30` Tage Bewegung
- taeglich genau eine bewusste Bewegungseinheit
- moeglichst geringe Entscheidungsbelastung

Default-Ort:

- House of Healing, Berlin-Charlottenburg

Energie-Level:

- `LOW`: Yin Yoga, Meditation, Sound Bath, Mobility
- `MEDIUM`: Barre, Pilates, leichtes Training
- `HIGH`: Beachvolleyball, Basketball, Squash, Tennis

Monatliche Regel:

- mindestens 1 Regenerations-Session wie Massage buchen und nutzen

## Entscheidungsregeln

1. Ich darf alles gleichzeitig wollen, aber nur eine Sache gleichzeitig aktiv umsetzen.
2. Neue Ideen werden eingefangen, nicht sofort gestartet.
3. Jede neue Idee wird zuerst einem Sonnenstrahl zugeordnet.
4. Nur bewusst ausgewaehlte Themen kommen in den Orbit.
5. Der Sonnenkern wird nicht spontan durch neue Ideen ersetzt.
6. Bewegung ist taeglicher Standard, nicht optionale Belohnung.
7. Homeoffice erlaubt Mini-Orga, aber keinen spontanen Projektwechsel.
8. Projekte finden nur statt, wenn Arbeit und Energie es realistisch erlauben.
9. Der Kalender orientiert sich an Energie und Realitaet, nicht an Perfektion.
10. Fokus wird geschuetzt, nicht durch Starrheit, sondern durch klare Aktivierung.

## Aktueller Prototyp-Stand

- Plattform: Flutter Web
- Aktueller Remote-Stand analysiert: `origin/main` auf Commit `61ab0a8` vom 8. Mai 2026
- Routing: echte Web-Routen mit Browser-History fuer `Dashboard`, `Heute`, `Strahlen`, `Projekt`, `Idee` und `Review`
- Persistenz: lokaler App-State via `shared_preferences`
- Datenquelle: initiale Seed-Daten in [lib/domain/seed/seed_data.dart](D:\projects\Projects\sonnenkompass\lib\domain\seed\seed_data.dart), danach persistenter lokaler App-Zustand
- Kernfluss: Fokus setzen, Orbit pflegen, Aufgaben bearbeiten, Ideen anlegen oder in Projekte umwandeln, Review speichern
- Dashboard und Strahlenansicht visualisieren das Modell jetzt kreisfoermiger statt nur als lineare Listen

## Bereits korrigiert

- kaputter Font-Aufruf im Theme repariert, damit Tests und Build wieder laufen
- Web-Metadaten (`title`, `description`, Manifest-Farben) an das Produkt angepasst
- Path-URL-Strategie fuer Web aktiviert
- echte Mehrscreen-Struktur mit Navigation Rail / Navigation Bar und Deep-Link-faehigen Routen aufgebaut
- lokale Persistenz fuer Projekte, Ideen, Tasks, Orbit, Bewegungsplan, Routinen und Review eingebaut
- konkrete Tagesaufgaben aus dem Domain-Modell angeschlossen statt leeren `mustDo`-/`optional`-Zustaenden
- Seed-Daten fuer Trading, Bewegung und Alltag ergaenzt, damit diese Strahlen keine inhaltlichen Sackgassen mehr sind
- Projekt-Detailseiten, Ideen-Detailseiten und Review-Seite mit echten Aktionen angeschlossen
- Ideen koennen in Projekte ueberfuehrt werden, statt als tote Objekte im Backlog zu bleiben
- Label-Sprache weitgehend auf konsistentes Deutsch umgestellt
- leere `free_workouts`-Feature-Struktur und die alte Einseiten-Prototyp-View entfernt

## Noch offene Produktluecken

- keine Sync- oder Multi-Device-Strategie, nur lokaler Browser-/App-Speicher
- keine echten externen Referenzlinks oder Medienbelege trotz vorhandenem `MediaAttachment`-Modell
- noch keine Verlaufs- oder Historienansicht ueber mehrere Tage hinweg
- Task-Planung ist funktional, aber noch kein vollwertiger Planer mit Erstellen/Bearbeiten neuer Tasks im UI
- noch keine Authentifizierung oder Export-/Backup-Funktion
- Fixkreis, Kern, Orbit, Strahlen und Zeitstrahlen sind im Dashboard bereits visuell angedeutet, aber noch nicht als vollstaendige explizite Datenobjekte getrennt modelliert

## Dateien in diesem Repo

- [README.md](D:\projects\Projects\sonnenkompass\README.md): kompakte Produktspezifikation
- [sonnenkompass-plan.md](D:\projects\Projects\sonnenkompass\sonnenkompass-plan.md): laufender Plan, Analyse und naechste Schritte fuer dieses Repo
- [sonnenkompass-app-dokumentation.md](D:\projects\Projects\sonnenkompass\sonnenkompass-app-dokumentation.md): ausfuehrliche Doku zu Screens, Layouts, Funktionen, Architektur und offenen Baustellen
- [sonnenkompass-zeitmodell.md](D:\projects\Projects\sonnenkompass\sonnenkompass-zeitmodell.md): konzeptionelle Beschreibung von Fixankern, Pflicht-Rhythmus und Fokusfenstern
- [datenmodell-vorschlag.md](D:\projects\Projects\sonnenkompass\datenmodell-vorschlag.md): fruehes fachliches Datenmodell fuer Rays, Projekte, Ideen, Tasks und FocusDay
