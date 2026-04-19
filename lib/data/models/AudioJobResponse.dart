class AudioJobResponse {
  final String jobId;
  final String runpodId;
  final String status;

  AudioJobResponse({
    required this.jobId,
    required this.runpodId,
    required this.status,
  });

  factory AudioJobResponse.fromJson(Map<String, dynamic> json) {
    return AudioJobResponse(
      jobId: json['job_id'],
      runpodId: json['runpod_id'],
      status: json['status'],
    );
  }
}
