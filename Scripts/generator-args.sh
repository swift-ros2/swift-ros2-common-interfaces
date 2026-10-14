#!/usr/bin/env bash
# Prints the swift-ros2-gen package arguments for this repository, one per line, reading the
# IDL that Scripts/fetch-idl.sh put in .idl/. Read by Scripts/regenerate.sh and by
# swift-ros2-rosidl's interface-oracles.yml.
#   generator-args.sh             every generated distribution (Scripts/regenerate.sh)
#   generator-args.sh <distro>    only <distro>, labelled @<distro> (the oracle matrix);
#                                 rolling reads the Lyrical IDL, as generated types give
#                                 Rolling the modern (Lyrical) hash
set -euo pipefail
COMMON="std_msgs std_srvs geometry_msgs sensor_msgs nav_msgs diagnostic_msgs shape_msgs stereo_msgs trajectory_msgs visualization_msgs"
DISTROS=${1:-"humble jazzy kilted lyrical"}
for distro in $DISTROS; do
  src=$distro
  [ "$distro" = rolling ] && src=lyrical
  for pkg in $COMMON; do
    printf -- '--input\n%s=.idl/common_interfaces-%s/%s@%s\n' "$pkg" "$src" "$pkg" "$distro"
  done
  printf -- '--input\ntf2_msgs=.idl/geometry2-%s/tf2_msgs@%s\n' "$src" "$distro"
  # Types that live in swift-ros2-rosidl: referenced and hashed, not emitted here. No emitted
  # type references action_msgs (generated action wrappers use only
  # unique_identifier_msgs/UUID and builtin_interfaces/Time), so it is not passed.
  printf -- '--dependency\nbuiltin_interfaces=.idl/rcl_interfaces-%s/builtin_interfaces@%s\n' "$src" "$distro"
  printf -- '--dependency\nunique_identifier_msgs=.idl/unique_identifier_msgs-%s@%s\n' "$src" "$distro"
done
