class AudioJobResponse {
  final String jobId;
  final String runpodId;
  final String status;
  final String message;

  AudioJobResponse({
    required this.jobId,
    required this.runpodId,
    required this.status,
    required this.message
  });

  factory AudioJobResponse.fromJson(Map<String, dynamic> json) {
    return AudioJobResponse(
      jobId: json['job_id'],
      runpodId: json['runpod_id'],
      status: json['status'],
      message: json['message']
    );
  }
}
