enum RayType { core, support, life }

enum WorkMode { homeOffice, office, mixed }

enum EnergyLevel { low, medium, high }

enum IdeaStatus {
  captured,
  clarified,
  parked,
  candidate,
  active,
  done,
  archived,
  discarded,
}

enum ProjectStatus { backlog, ready, active, paused, blocked, done, archived }

enum TaskStatus { todo, next, doing, blocked, done, cancelled }

enum PriorityLevel { low, medium, high, critical }

enum OrbitRole { primaryFocus, secondaryFocus, supportFocus }

enum OrbitItemType { project, idea, task, ray }

enum MediaType { image, screenshot, sketch, audio, pdf, file, link, note }

enum MovementActivityType {
  yinYoga,
  meditation,
  soundBath,
  mobility,
  barre,
  pilates,
  gymLight,
  beachVolleyball,
  basketball,
  squash,
  tennis,
  walk,
  bike,
  massage,
}

enum MovementStatus { planned, booked, done, skipped }

enum RoutineCategory { work, cats, household, meal, movement, recovery }

enum Flexibility { fixed, semiFlexible, flexible }

enum ActivationReadiness {
  notNow,
  candidateThisWeek,
  candidateToday,
  needsClarification,
}

enum IdeaSourceType {
  manualText,
  voiceNote,
  imageUpload,
  screenshotUpload,
  pdfUpload,
  quickCapture,
  aiImport,
}

enum MonetizationPotential { none, unclear, low, medium, high }

enum TimeToFirstVersion { oneDay, threeDays, oneWeek, twoWeeks, longer }

enum ProofOfOutputType {
  none,
  prototype,
  shippedFeature,
  landingPage,
  firstUsers,
  firstRevenue,
  paidPilot,
}
