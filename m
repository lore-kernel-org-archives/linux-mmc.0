From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 00/13] mmc: omap_hsmmc: dt pbias and regulator voltage switch
Date: Tue, 30 Apr 2013 19:33:40 +0530
Message-ID: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

This patch series adds omap-hsmmc-control driver to handle omap control module
mmc registers for devicetree boot.
These control module registers are needed for mmc pbias i/o, speed mode
configuration of mmc1 and loopback clock configuration of mmc2.

With voltage switch support (pbias i/o) added for dt, enhance regulator
deferred probe handling by adding needs_vmmc and needs_vmmc_aux to indicate
whether regulator is applicable so that omap_hsmmc can handle regulator
deferred probe error properly.
Remove the assumption that vmmc_aux regulator to be present only if vmmc is
available. Platforms can have fixed-always-ON regulator for vmmc and/or vmmc_aux
in such cases vmmc regulator needed not be specified in board file.

Add omap-hsmmc-control data to omap dts files.

Balaji T K (13):
  ARM: OMAP2+: add needs_vmmc to hsmmc_info
  mmc: omap_hsmmc: make vcc and vcc_aux independent
  mmc: omap_hsmmc: use needs_vmmc
  mmc: omap_hsmmc: update needs_vmmc for dt
  mmc: omap_hsmmc: remove use_reg
  mmc: omap_hsmmc: add dt pbias and control mmc support
  mmc: omap_hsmmc: remove dt pbias workaround
  Documentation: dt: mmc: omap hsmmc
  ARM: dts: omap3: Add omap control mmc data
  ARM: dts: omap36xx: Add omap control mmc data
  ARM: dts: omap4: Add omap control mmc data
  ARM: dts: omap5: Add omap control mmc data
  ARM: dts: am3517: add omap_control_mmc

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   34 ++
 arch/arm/boot/dts/am3517-evm.dts                   |   20 +
 arch/arm/boot/dts/am3517_mt_ventoux.dts            |   20 +
 arch/arm/boot/dts/omap3.dtsi                       |   17 +
 arch/arm/boot/dts/omap36xx.dtsi                    |    7 +
 arch/arm/boot/dts/omap4.dtsi                       |    9 +
 arch/arm/boot/dts/omap5.dtsi                       |    8 +
 arch/arm/mach-omap2/board-2430sdp.c                |    1 +
 arch/arm/mach-omap2/board-3430sdp.c                |    3 +
 arch/arm/mach-omap2/board-4430sdp.c                |    3 +
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 +
 arch/arm/mach-omap2/board-devkit8000.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c               |    3 +
 arch/arm/mach-omap2/board-ldp.c                    |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 +
 arch/arm/mach-omap2/board-omap3evm.c               |    3 +
 arch/arm/mach-omap2/board-omap3logic.c             |    1 +
 arch/arm/mach-omap2/board-omap3pandora.c           |    3 +
 arch/arm/mach-omap2/board-omap3stalker.c           |    2 +
 arch/arm/mach-omap2/board-omap3touchbook.c         |    2 +
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +
 arch/arm/mach-omap2/board-overo.c                  |    1 +
 arch/arm/mach-omap2/board-rm680.c                  |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    3 +
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    4 +
 arch/arm/mach-omap2/hsmmc.c                        |    2 +
 arch/arm/mach-omap2/hsmmc.h                        |    2 +
 drivers/mmc/host/Makefile                          |    2 +-
 drivers/mmc/host/omap_hsmmc.c                      |  138 ++++---
 drivers/mmc/host/omap_hsmmc_control.c              |  466 ++++++++++++++++++++
 include/linux/platform_data/mmc-omap.h             |   20 +
 31 files changed, 729 insertions(+), 54 deletions(-)
 create mode 100644 drivers/mmc/host/omap_hsmmc_control.c

-- 
1.7.5.4

