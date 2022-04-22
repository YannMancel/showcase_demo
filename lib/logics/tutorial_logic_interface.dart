abstract class TutorialLogicInterface {
  Future<void> makeTutorialUnavailable();
  Future<void> clearTutorialCache();
  Future<bool> canDisplayTutorial();
}
