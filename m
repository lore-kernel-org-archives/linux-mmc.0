From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2 00/11] mmc: core and driver DT and related development
Date: Wed, 23 Jan 2013 16:32:27 +0100
Message-ID: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

This is v2 of a patch series [1], fixing several issues, surfacing with 
SDIO cards on sh-/r-mobile (SDHI) systems. Individual changes noted in 
respective patches.

[1] http://www.mail-archive.com/linux-mmc@vger.kernel.org/index.html#18385

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
 drivers/mmc/core/host.c                            |   82 +++++++++++++++++++
 drivers/mmc/host/sh_mmcif.c                        |    3 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  |   64 ++++-----------
 drivers/mmc/host/tmio_mmc_pio.c                    |   86 +++++++++++++++++---
 include/linux/mfd/tmio.h                           |   18 ----
 include/linux/mmc/host.h                           |   23 +++---
 include/linux/mmc/sh_mobile_sdhi.h                 |    2 -
 9 files changed, 212 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/tmio_mmc.txt

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
