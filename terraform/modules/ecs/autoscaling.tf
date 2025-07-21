resource "aws_appautoscaling_target" "ecs_service" {
  max_capacity       = 5               
  min_capacity       = 1
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.app.name}"
  scalable_dimension = "ecs:service:DesiredCount"
}

resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  name               = "ecs-cpu-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace
  resource_id        = aws_appautoscaling_target.ecs_service.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 10.0      # 10% for test  quickly,usually it's 50%
    scale_in_cooldown  = 60        
    scale_out_cooldown = 60       
  }
}

