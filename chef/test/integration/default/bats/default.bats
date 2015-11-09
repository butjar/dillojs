#!/usr/bin/env bats

@test "nginx service is running" {
  run service nginx status
  [ "$status" -eq 0 ]
}

@test "nginx service is enabled" {
  output="$(ls /etc/rc3.d/ | grep -- '^S..nginx$')"
  status="$?"
  [ "$status" -eq 0 ]
}

@test "nginx service is running" {
  run service nginx status
  [ "$status" -eq 0 ]
}

@test "mongodb service is enabled" {
  output="$grep '^\s*start on' /etc/init/mongodb.conf"
  status="$?"
  [ "$status" -eq 0 ]
}
