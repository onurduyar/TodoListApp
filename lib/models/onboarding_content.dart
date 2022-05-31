class OnboardingContent {
  final String imagePath;
  final String content;

  OnboardingContent({required this.imagePath, required this.content});
}

List<OnboardingContent> onboardingContentList = [
  OnboardingContent(
      imagePath: 'assets/images/onboarding_content1.jpg',
      content: 'Save time and be productive by creating daily tasks.'),
  OnboardingContent(
      imagePath: 'assets/images/onboarding_content2.jpg',
      content: 'Get that satisfying feeling when marking them done.'),
  OnboardingContent(
      imagePath: 'assets/images/onboarding_content3.jpg',
      content: 'Reach your goals faster with Todo-List App.'),
];
