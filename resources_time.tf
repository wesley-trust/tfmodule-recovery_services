/* # Delay destroy by 30 seconds, to allow for service replication
resource "time_sleep" "wait_30_seconds" {

  destroy_duration = "30s"
}
 */