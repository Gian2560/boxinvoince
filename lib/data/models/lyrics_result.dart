class LyricsResult {
  final String language;
  final List<LyricSegment> lyrics;
  final String jobId;

  LyricsResult({
    required this.language,
    required this.lyrics,
    required this.jobId,
  });

  factory LyricsResult.fromJson(Map<String, dynamic> json) {
    var list = json['lyrics'] as List;
    List<LyricSegment> segmentList = list
        .map((i) => LyricSegment.fromJson(i))
        .toList();
    return LyricsResult(
      language: json['language'],
      lyrics: segmentList,
      jobId: json['job_id'],
    );
  }
}

class LyricSegment {
  final double start;
  final double end;
  final String text;

  LyricSegment({required this.start, required this.end, required this.text});

  factory LyricSegment.fromJson(Map<String, dynamic> json) {
    return LyricSegment(
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      text: json['text'] ?? '',
    );
  }
}
