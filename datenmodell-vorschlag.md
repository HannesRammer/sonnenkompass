# Datenmodell-Vorschlag

## Ziel

Das Modell soll drei Dinge gleichzeitig koennen:

- Fokuslogik abbilden
- Ideen und Projekte sauber speichern
- spaeter KI-gestuetzte Aktionen ermoeglichen

Wichtig:

- lieber wenige stabile Objekte als zu viele Spezialfaelle
- Statuswerte muessen klar sein
- KI darf strukturieren, aber nicht das Datenmodell vernebeln

## Grundregeln

1. `Ray` ist die oberste fachliche Kategorie.
2. `Project` ist ein groesseres Vorhaben innerhalb eines Rays.
3. `Idea` ist ein einzelner Einfall, Ansatz, Fragment oder Impuls.
4. `Task` ist konkrete umsetzbare Arbeit.
5. `OrbitItem` ist nur eine Aktivierungsschicht, keine eigene Inhaltsquelle.
6. `FocusDay` speichert die bewusste Tagesentscheidung.

## Enums

### RayType

- `core`
- `support`
- `life`

### WorkMode

- `home_office`
- `office`
- `mixed`

### EnergyLevel

- `low`
- `medium`
- `high`

### IdeaStatus

- `captured`
- `clarified`
- `parked`
- `candidate`
- `active`
- `done`
- `archived`
- `discarded`

### ProjectStatus

- `backlog`
- `ready`
- `active`
- `paused`
- `blocked`
- `done`
- `archived`

### TaskStatus

- `todo`
- `next`
- `doing`
- `blocked`
- `done`
- `cancelled`

### PriorityLevel

- `low`
- `medium`
- `high`
- `critical`

### OrbitRole

- `primary_focus`
- `secondary_focus`
- `support_focus`

### MediaType

- `image`
- `screenshot`
- `sketch`
- `audio`
- `pdf`
- `file`
- `link`
- `note`

### MonetizationPotential

- `none`
- `unclear`
- `low`
- `medium`
- `high`

### TimeToFirstVersion

- `one_day`
- `three_days`
- `one_week`
- `two_weeks`
- `longer`

### ProofOfOutputType

- `none`
- `prototype`
- `shipped_feature`
- `landing_page`
- `first_users`
- `first_revenue`
- `paid_pilot`

## User

Die Nutzerkonfiguration. Vermutlich gibt es am Anfang nur einen User, aber das Objekt sollte trotzdem sauber existieren.

### Felder

- `id`
- `displayName`
- `timezone`
- `locale`
- `homeBase`
- `workBase`
- `workStartAnchor`
- `protectedWorkWindowStart`
- `protectedWorkWindowEnd`
- `urbanSportsEnabled`
- `defaultMovementVenue`
- `notes`
- `createdAt`
- `updatedAt`

### Beispielwerte

- `timezone`: `Europe/Berlin`
- `locale`: `de-DE`
- `workStartAnchor`: `08:00`
- `protectedWorkWindowStart`: `09:45`
- `protectedWorkWindowEnd`: `10:45`
- `defaultMovementVenue`: `House of Healing`

## Ray

Die festen Sonnenstrahlen.

### Felder

- `id`
- `slug`
- `name`
- `description`
- `type`
- `color`
- `icon`
- `sortOrder`
- `isActive`
- `defaultEnergyFit`
- `parentRayId` optional
- `createdAt`
- `updatedAt`

### Beispielwerte

- `slug`: `coding-apps`
- `name`: `Coding / Apps`
- `type`: `core`
- `color`: `sun-amber`
- `defaultEnergyFit`: `medium`

## Project

Groessere Vorhaben innerhalb eines Rays.

### Felder

- `id`
- `rayId`
- `slug`
- `name`
- `description`
- `status`
- `priority`
- `energyFit`
- `effortSize`
- `vision`
- `currentGoal`
- `monetizationPotential`
- `timeToFirstVersion`
- `proofOfOutput`
- `nextReviewAt`
- `isEvergreen`
- `createdAt`
- `updatedAt`

### Beispielwerte

- `name`: `Console`
- `status`: `active`
- `priority`: `high`
- `energyFit`: `high`
- `effortSize`: `large`
- `currentGoal`: `Adaptive UI Struktur definieren`
- `monetizationPotential`: `high`
- `timeToFirstVersion`: `one_week`
- `proofOfOutput`: `prototype`

## Idea

Das zentrale Capture-Objekt fuer neue Gedanken, Inputs und Impulse.

### Felder

- `id`
- `rayId`
- `projectId` optional
- `title`
- `summary`
- `description`
- `status`
- `priority`
- `confidence`
- `sourceType`
- `sourceText`
- `capturedAt`
- `suggestedNextStep`
- `activationReadiness`
- `monetizationPotential`
- `timeToFirstVersion`
- `proofOfOutput`
- `tags`
- `createdByAi`
- `aiNotes`
- `createdAt`
- `updatedAt`

### Sinnvolle Zusatzfelder

- `duplicateOfIdeaId` optional
- `convertedToProjectId` optional
- `archivedReason` optional

### Beispielwerte

- `title`: `Console - Kontextleiste fuer Windows Explorer`
- `summary`: `Adaptive Shortcuts auf Basis des aktiven Desktop-Kontexts`
- `status`: `captured`
- `priority`: `medium`
- `sourceType`: `voice_note`
- `activationReadiness`: `not_now`
- `monetizationPotential`: `medium`
- `timeToFirstVersion`: `three_days`
- `proofOfOutput`: `prototype`
- `tags`: `["ui", "flutter", "windows", "adaptive"]`

### Empfohlene Werte fuer sourceType

- `manual_text`
- `voice_note`
- `image_upload`
- `screenshot_upload`
- `pdf_upload`
- `quick_capture`
- `ai_import`

### Empfohlene Werte fuer activationReadiness

- `not_now`
- `candidate_this_week`
- `candidate_today`
- `needs_clarification`

## Task

Konkrete umsetzbare Arbeitseinheit. Tasks gehoeren am besten zu einem Project oder direkt zu einem Idea-Follow-up.

### Felder

- `id`
- `rayId`
- `projectId` optional
- `ideaId` optional
- `title`
- `description`
- `status`
- `priority`
- `energyFit`
- `estimatedMinutes`
- `scheduledForDate` optional
- `dueAt` optional
- `isRoutine`
- `createdAt`
- `updatedAt`

### Beispielwerte

- `title`: `Adaptive Sidebar Wireframe skizzieren`
- `status`: `next`
- `energyFit`: `medium`
- `estimatedMinutes`: `45`

## OrbitItem

Das ist nur die Aktivierung eines bestehenden Objekts. Keine Duplizierung von Inhalt.

### Felder

- `id`
- `itemType`
- `itemId`
- `role`
- `focusDate`
- `reason`
- `activatedAt`
- `expiresAt` optional
- `createdAt`

### Empfohlene Werte fuer itemType

- `project`
- `idea`
- `task`
- `ray`

### Beispielwerte

- `itemType`: `project`
- `itemId`: `<console-project-id>`
- `role`: `primary_focus`
- `focusDate`: `2026-04-07`
- `reason`: `Heute aktiver Kern fuer konzentrierte Produktarbeit`

## FocusDay

Das Tagesobjekt, das bewusste Entscheidungen speichert.

### Felder

- `id`
- `date`
- `workMode`
- `energyLevel`
- `primaryOrbitItemId`
- `secondaryOrbitItemIds`
- `movementPlanId` optional
- `mustDoTaskIds`
- `optionalTaskIds`
- `dailyNote`
- `distractionLog`
- `dayReview`
- `createdAt`
- `updatedAt`

### Designregel

- genau 1 `primaryOrbitItemId`
- maximal 2 `secondaryOrbitItemIds`

## MovementPlan

Eigene Struktur fuer taegliche Bewegung, weil Sport bei dir kein Nebenobjekt, sondern Systembestandteil ist.

### Felder

- `id`
- `date`
- `energyLevel`
- `venue`
- `activityType`
- `plannedStart`
- `plannedDurationMinutes`
- `status`
- `bookingSource`
- `notes`
- `createdAt`
- `updatedAt`

### Empfohlene activityType-Werte

- `yin_yoga`
- `meditation`
- `sound_bath`
- `mobility`
- `barre`
- `pilates`
- `gym_light`
- `beach_volleyball`
- `basketball`
- `squash`
- `tennis`
- `walk`
- `bike`
- `massage`

### Empfohlene status-Werte

- `planned`
- `booked`
- `done`
- `skipped`

## MediaAttachment

Haengt an `Idea`, `Project` oder spaeter eventuell `Task`.

### Felder

- `id`
- `ownerType`
- `ownerId`
- `type`
- `uri`
- `fileName`
- `mimeType`
- `sizeBytes`
- `previewText`
- `transcript`
- `analysisSummary`
- `createdAt`

### ownerType-Werte

- `idea`
- `project`
- `task`

## DailyRoutineBlock

Fuer wiederkehrende Lebensrealitaet wie Katzen, Haushalt, Essen oder feste Arbeit.

### Felder

- `id`
- `userId`
- `name`
- `category`
- `defaultStartTime` optional
- `defaultDurationMinutes`
- `flexibility`
- `isDaily`
- `isActive`
- `notes`

### category-Werte

- `work`
- `cats`
- `household`
- `meal`
- `movement`
- `recovery`

### flexibility-Werte

- `fixed`
- `semi_flexible`
- `flexible`

## ReviewLog

Optional, aber spaeter sehr wertvoll fuer KI-Analyse und Selbstreflexion.

### Felder

- `id`
- `date`
- `focusDayId`
- `workedWell`
- `distractions`
- `energyReflection`
- `tomorrowCandidate`
- `createdAt`

## Minimalbeziehungen

- `User 1:n Ray`
- `Ray 1:n Project`
- `Ray 1:n Idea`
- `Project 1:n Idea`
- `Project 1:n Task`
- `Idea 0:n Task`
- `FocusDay 1:n OrbitItem`
- `FocusDay 0:1 MovementPlan`
- `Idea 0:n MediaAttachment`
- `Project 0:n MediaAttachment`

## Felder, die ich bewusst nicht sofort einbauen wuerde

Diese Dinge klingen schlau, machen das MVP aber schnell schwer:

- automatische Scoring-Systeme mit 15 Unterwerten
- emotionale Zustandsmatrizen
- zu komplexe Gewichtung fuer Priorisierung
- verschachtelte Kanban-Hierarchien
- frei aenderbare Ray-Taxonomien ohne Begrenzung

## Mein pragmatischer Vorschlag fuer Version 1

Wenn du klein anfangen willst, reichen zuerst diese Tabellen oder Collections:

1. `rays`
2. `projects`
3. `ideas`
4. `orbit_items`
5. `focus_days`
6. `movement_plans`
7. `media_attachments`

`tasks` und `review_logs` kannst du direkt mitdenken, aber notfalls spaeter einfuehren.

## Mein fachlicher Rat

Wenn du mich fragst, was fuer dich wirklich entscheidend ist, dann sind die wichtigsten Felder:

- bei `Idea`: `rayId`, `title`, `summary`, `status`, `activationReadiness`, `monetizationPotential`, `timeToFirstVersion`
- bei `Project`: `rayId`, `name`, `status`, `currentGoal`, `energyFit`, `monetizationPotential`, `proofOfOutput`
- bei `FocusDay`: `date`, `energyLevel`, `workMode`, `primaryOrbitItemId`
- bei `MovementPlan`: `date`, `activityType`, `status`, `venue`

Genau diese Felder bilden deinen echten Alltag ab, statt nur abstrakte Produktivitaet zu simulieren.

## Output-Logik fuer dich

Dein eigentlicher Engpass ist nicht Ideenmangel, sondern zu wenig Verdichtung zu sichtbarem Output. Deshalb sollten `Idea` und `Project` nicht nur nach Interesse, sondern auch nach Lieferfaehigkeit bewertet werden.

Die drei wichtigsten Output-Felder sind:

1. `monetizationPotential`
   - Kann daraus realistisch Geld, ein Auftrag oder ein bezahlbarer Test entstehen?
2. `timeToFirstVersion`
   - Wie schnell kann daraus eine erste zeigbare Version werden?
3. `proofOfOutput`
   - Was ist der naechste echte Beweis, dass das Ding nicht nur im Kopf existiert?

Das zwingt dein System zu besseren Fragen:

- Was ist in 3 Tagen vorzeigbar?
- Was kann erste Nutzer oder erstes Geld erzeugen?
- Was ist gerade nur spannend und was ist wirklich lieferbar?
