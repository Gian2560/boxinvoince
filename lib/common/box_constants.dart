enum StatusResponse{
  IN_PROCESS("processing"),
  IN_QUEUE("queued"),
  COMPLETED("completed"),
  FAILED("failed");

  final String desc;
  const StatusResponse(this.desc);
}