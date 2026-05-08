# Prototyp-Priorisierung aus Ideen-Scan

## Ziel

Diese Datei sortiert die gefundenen Ideen nicht nach "wo ist am schnellsten Geld drin", sondern nach:

- wem es konkret hilft
- ob schon Material oder Code vorhanden ist
- ob ein erster Prototyp in 1 bis 7 Tagen testbar ist
- ob die Idee verantwortbar und erklaerbar ist
- ob Menschen sie teilen, testen oder mitbauen koennen

Leitgedanke:

**Gute Ideen sollen raus, weil sie nuetzen. Geld kann spaeter ein Erhaltungsmodell sein, aber nicht der erste Kompass.**

## Bewertungsmodell

Score aus 100 Punkten:

| Kriterium | Gewicht | Frage |
| --- | ---: | --- |
| Nutzen fuer andere | 30 | Loest es ein echtes Problem oder gibt es Menschen Ausdruck, Klarheit, Sicherheit oder Freude? |
| Vorhandene Substanz | 20 | Gibt es schon Code, Musik, Texte, Screenshots, Repo, README oder Struktur? |
| Prototyp-Geschwindigkeit | 20 | Kann in 1 bis 7 Tagen etwas Sichtbares entstehen? |
| Verbreitbarkeit | 15 | Ist es leicht zu erklaeren, zu teilen oder zu testen? |
| Verantwortungs-/Risiko-Fit | 15 | Ist es sicher, transparent und ethisch sauber zu veroeffentlichen? |

## Priorisierte Prototypen

### 1. THE-REAL-WINDOWS-CLEANER

Score: `92/100`

Hilft:
Normalen Windows-Nutzern, die ihr System aufraeumen wollen, ohne kaputte Cleaner, aggressive Werbung oder riskante Ein-Klick-Automatik.

Warum stark:

- konkretes Problem
- bestehende C# / WPF-Codebasis
- gutes Safety-First-README
- hoher Vertrauenshebel, wenn transparent kommuniziert
- kann kostenlos und offen testbar starten

Kleinster Prototyp:

- Landingpage oder GitHub-Release-Seite
- 5 Screenshots
- 1 Download-Build
- klare Warnung: keine automatische Bereinigung, nur gefuehrte Schritte
- Feedback-Issue-Template

Naechster 48h-Schnitt:

1. README in "fuer wen / was macht es / was macht es bewusst nicht" umschreiben.
2. Einen Release-Build erzeugen oder vorhandenen Build sauber verlinken.
3. 3 Testpersonen bitten: "Fuehlt sich das sicher und verstaendlich an?"

### 2. Sonnenkompass / Prototyp-Radar

Score: `90/100`

Hilft:
Kreativen Multi-Projekt-Menschen, die nicht an Ideenmangel leiden, sondern an Ueberladung.

Warum stark:

- es loest dein echtes eigenes Problem
- es passt direkt zum vorhandenen Flutter-Projekt
- es kann anderen Kreativen/Entwicklern helfen
- es sortiert Ideen nach Wirkung statt nur nach Reiz

Kleinster Prototyp:

- Radar-Screen mit Top-Prototypen
- Score je Idee
- Orbit-Regel: 1 Kernprojekt, 2 Nebenprojekte, Rest sichtbar aber pausiert
- "Warum jetzt?" und "naechster Schnitt" pro Karte

Naechster 48h-Schnitt:

1. Diese Datei als Datenquelle nehmen.
2. Radar im Flutter-MVP anzeigen.
3. Danach optional Import aus lokalen Projektordnern bauen.

### 3. Schreis Raus / Kunststaub Release Board

Score: `86/100`

Hilft:
Menschen, die Druck, Gefuehl und Ausdruck rauslassen wollen. Das ist kein reines Musikprodukt, sondern eine Botschaft.

Warum stark:

- lokale Stems und Varianten existieren
- Streaming-Spuren existieren
- klares emotionales Thema
- laesst sich in Shorts, Visuals, Making-of und Remixes aufteilen

Kleinster Prototyp:

- eine Seite mit Trackversionen
- 3 beste Versionen
- Lyrics / Hintergrund
- Visual-Loop
- Link zu Apple/Amazon/Soundverse

Naechster 48h-Schnitt:

1. Versionen in "beste 3", "Archiv", "Stems" sortieren.
2. Eine Release-Seite bauen.
3. Ein kurzes Statement schreiben: "Warum Schreis Raus?"

### 4. Music Autopilot

Score: `83/100`

Hilft:
Musikfans, die Radio, YouTube und lange Musikvideos smarter hoeren wollen.

Gefundene Bausteine:

- `fluxfm_playlists`
- `youtube-library`
- `skip_a_beat`
- `kunststaub.fm`

Warum stark:

- mehrere alte Projekte zeigen denselben Bedarf
- klare Browser-Extension-Form
- leichter testbar
- passt zu deiner Musikidentitaet

Kleinster Prototyp:

- Browser-Extension mit nur einem Use Case:
  - laufende Songs mehrerer Channels sehen
  - Song speichern
  - disliked Song automatisch vermeiden oder markieren

Naechster 48h-Schnitt:

1. Nicht drei Tools weiterbauen.
2. Einen gemeinsamen Namen und einen einzigen Flow definieren.
3. FluxFM-Use-Case als MVP nehmen.

### 5. CLEAR / Nein, was hast du gesagt?

Score: `79/100`

Hilft:
Menschen in Chats, die fairer, klarer und weniger impulsiv antworten wollen.

Warum stark:

- `alphacore` hat bereits Monorepo-Struktur
- klarer Nutzen
- gesellschaftlich sinnvoll
- privacy-first kann ein echter Unterschied sein

Risiko:

- sehr sensibel, weil Kommunikation und Beziehungen privat sind
- darf nicht nach Therapie, Ueberwachung oder Manipulation wirken

Kleinster Prototyp:

- Web-Demo mit Beispieldialogen
- Before-send-Fragen
- lokale Redaction
- kein echtes Chat-Logging

Naechster 48h-Schnitt:

1. Nicht Messenger bauen.
2. Nur "Antwort klarer formulieren" als Demo.
3. Privacy-Versprechen auf eine Seite schreiben.

### 6. RammerChess

Score: `78/100`

Hilft:
Denkspiel-Fans, Familien, Schachspieler und Menschen, die neue Regeln ausprobieren wollen.

Warum stark:

- laeuft bereits als eigenes Projekt
- starkes Branding
- Mischung aus Schach, Labyrinth und Rubik's Cube ist merkbar
- gut fuer Portfolio, Community und Devlog

Kleinster Prototyp:

- spielbare Web-Demo
- ein Regelset
- ein Tutorial-Screen
- 60-Sekunden-Trailer oder GIF

Naechster 48h-Schnitt:

1. Eine einzige Spielvariante waehlen.
2. Regeln auf eine Seite reduzieren.
3. Testlink an 5 Denkspiel-/Schachinteressierte geben.

### 7. Free-Workouts / Low-Energy Movement

Score: `72/100`

Hilft:
Menschen mit wenig Zeit oder Energie, die trotzdem in Bewegung kommen wollen.

Warum weiterhin sinnvoll:

- sehr klar testbar
- vorhandener MVP-Plan
- passt zum Sonnenkompass-Lebensmodell

Warum nicht Platz 1:

- Markt ist voll
- Wirkung entsteht nur, wenn Positionierung enger wird

Kleinster Prototyp:

- 3 kostenlose Workouts
- 7 Low-Energy- oder 10-Minuten-Plaene
- teilbare Seite
- kein Account

### 8. KcalGPT

Score: `68/100`

Hilft:
Menschen, die grob erfassen wollen, was sie essen.

Warum nur mittlere Prioritaet:

- viele Konkurrenzprodukte
- Gesundheitskontext braucht klare Grenzen
- AI-Schaetzungen koennen falsch sein

Kleinster verantwortbarer Prototyp:

- Schaetzung mit Unsicherheitsanzeige
- Export / Verlauf
- klarer Hinweis: keine medizinische Beratung

## Nicht jetzt aktivieren

Diese Funde bleiben bewusst im Archiv:

- Trading-Bots
- Kucoin-/Pinescript-/Cashflow-Ideen
- Gambling- oder Lottery-nahe Ideen
- "earn me some cash"-artige Projekte

Grund:
Sie koennen riskant werden, lenken stark ab und passen nicht zu deinem aktuellen Satz: **"Ich will es verbreiten, weil ich glaube, dass es gut ist."**

## Empfohlener Orbit fuer die naechsten 14 Tage

### Build Orbit

`Sonnenkompass / Prototyp-Radar`

Warum:
Das Projekt hilft dir sofort, alle anderen Ideen kontrollierbar zu machen.

### Output Orbit

`THE-REAL-WINDOWS-CLEANER`

Warum:
Es ist am naechsten an einem nuetzlichen, veroeffentlichbaren Tool fuer andere.

### Creative Orbit

`Schreis Raus / Kunststaub Release Board`

Warum:
Es gibt dir Ausdruck, Identitaet und sichtbares Material, ohne dass es erst "fertig perfekt" sein muss.

## Entscheidung fuer heute

Wenn heute nur ein Schnitt passieren darf:

**Baue den Prototyp-Radar im Sonnenkompass und nutze ihn, um THE-REAL-WINDOWS-CLEANER als erstes oeffentlich hilfreiches Tool vorzubereiten.**

Das schafft Ordnung und Output zugleich.
