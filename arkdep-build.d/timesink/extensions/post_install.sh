#!/usr/bin/env bash

set -oue pipefail

sed -i "s/curl -sf /curl -sfL /g" /usr/bin/arkdep
