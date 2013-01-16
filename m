From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 00/11] mmc: core and driver DT and related development
Date: Wed, 16 Jan 2013 17:54:35 +0100
Message-ID: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This patch series addresses the following topics:

1. DT: add a generic DT binding parsing function. It retrieves MMC DT 
properties, currently documented in 
Documentation/devicetree/bindings/mmc/mmc.txt, sets respective host flags, 
initialises GPIO slot functions, verifies presence of the compulsory 
bus-width property.

2. DT: deprecate cd-inverted and wp-inverted DT properties, GPIO standard 
"flags" cell should be used.

3. DT-related sh_mobile_sdhi / tmio_mmc and sh_mmcif driver extensions.

Guennadi Liakhovetski (11):
  mmc: sdhi, tmio: only check flags in tmio-mmc driver proper
  mmc: deprecate redundant cd-inverted and wp-inverted DT properties
  mmc: provide a standard MMC device-tree binding parser centrally
  mmc: (cosmetic) remove "extern" from function declarations
  mmc: sh-mmcif: use mmc_of_parse() to parse standard MMC DT bindings
  mmc: tmio-mmc: define device-tree bindings
  mmc: tmio-mmc: parse device-tree bindings
  mmc: sh_mobile_sdhi: remove unused .pdata field
  mmc: sh_mobile_sdhi: use managed resource allocations
  mmc: tmio: remove unused and deprecated symbols
  mmc: tmio: add support for the VccQ regulator

 Documentation/devicetree/bindings/mmc/mmc.txt      |    8 ++
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   19 +++++
 drivers/mmc/core/host.c                            |   82 ++++++++++++++++++++
 drivers/mmc/host/sh_mmcif.c                        |    3 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  |   64 ++++------------
 drivers/mmc/host/tmio_mmc_pio.c                    |   67 ++++++++++++++--
 include/linux/mfd/tmio.h                           |   18 ----
 include/linux/mmc/host.h                           |   23 +++---
 include/linux/mmc/sh_mobile_sdhi.h                 |    2 -
 9 files changed, 196 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/tmio_mmc.txt

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
