class LyricsResult {
  final String language;
  final String lyrics;
  final String jobId;

  LyricsResult({
    required this.language,
    required this.lyrics,
    required this.jobId,
  });

  factory LyricsResult.fromJson(Map<String, dynamic> json) {
    return LyricsResult(
      language: json['language'],
      lyrics: json['lyrics'],
      jobId: json['job_id'],
    );
  }
}
