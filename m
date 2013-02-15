From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v4 00/13] mmc: core and driver DT and related development
Date: Fri, 15 Feb 2013 16:13:49 +0100
Message-ID: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

This is v4 of a patch-series, extending mmc subsystem device-tree usage 
and adding more advanced DT capabilities to sh_mmcif and sh_mobile_sdhi / 
tmio_mmc drivers. Changes since v3 are described in respective patches. 
Thanks to all who commented on v3.

Guennadi Liakhovetski (13):
  mmc: sdhi, tmio: only check flags in tmio-mmc driver proper
  mmc: detailed definition of CD and WP MMC line polarities in DT
  mmc: provide a standard MMC device-tree binding parser centrally
  mmc: (cosmetic) remove "extern" from function declarations
  mmc: sh-mmcif: use mmc_of_parse() to parse standard MMC DT bindings
  mmc: tmio-mmc: define device-tree bindings
  mmc: tmio-mmc: parse device-tree bindings
  mmc: sh_mobile_sdhi: remove unused .pdata field
  mmc: sh_mobile_sdhi: use managed resource allocations
  mmc: tmio: remove unused and deprecated symbols
  mmc: tmio: add support for the VccQ regulator
  mmc: add DT bindings for more MMC capability flags
  mmc: tmio: add barriers to IO operations

 Documentation/devicetree/bindings/mmc/mmc.txt      |   27 ++++-
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   20 ++++
 drivers/mmc/core/host.c                            |  121 ++++++++++++++++++++
 drivers/mmc/host/sh_mmcif.c                        |    3 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  |   96 +++++++---------
 drivers/mmc/host/tmio_mmc.h                        |   18 ++--
 drivers/mmc/host/tmio_mmc_pio.c                    |   79 +++++++++++--
 include/linux/mfd/tmio.h                           |   18 ---
 include/linux/mmc/host.h                           |   23 ++--
 include/linux/mmc/sh_mobile_sdhi.h                 |    2 -
 10 files changed, 298 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/tmio_mmc.txt

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de
