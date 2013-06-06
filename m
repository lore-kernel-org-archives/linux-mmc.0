From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 00/10] mmc: omap_hsmmc: dt pbias and regulator voltage switch
Date: Fri, 7 Jun 2013 00:44:09 +0530
Message-ID: <1370546059-24181-1-git-send-email-balajitk@ti.com>
References: <20130523184045.GD13507@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130523184045.GD13507@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

This patch series adds support for configuring pbias register needed for
switching (ON/OFF, voltage scaling 3V, 1.8V) vmmc regulator suppling
OMAP mmc/sd1 i/o pads for device tree boot.
The control module registers are needed for mmc pbias i/o, speed mode
configuration of mmc1 and loopback clock configuration of mmc2.

With voltage switch support (pbias i/o) added for dt, enhance regulator
deferred probe handling by adding needs_vmmc and needs_vmmc_aux to indicate
whether regulator is applicable so that omap_hsmmc can handle regulator
deferred probe error properly.

Remove the assumption that vmmc_aux regulator to be present only if vmmc is
available. Platforms can have fixed-always-ON regulator for vmmc and/or vmmc_aux
in such cases vmmc regulator needed not be specified in board file.

Balaji T K (10):
  ARM: OMAP2+: add needs_vmmc to hsmmc_info
  mmc: omap_hsmmc: make vcc and vcc_aux independent
  mmc: omap_hsmmc: use needs_vmmc
  mmc: omap_hsmmc: update needs_vmmc for dt
  mmc: omap_hsmmc: remove use_reg
  mmc: omap_hsmmc: add support for pbias configuration in dt
  mmc: omap_hsmmc: remove dt pbias workaround
  ARM: dts: omap3: split omap3_pmx_core
  ARM: dts: omap3: add pbias and mmc_init pinctrl states
  ARM: dts: omap4: add pbias and mmc_init pinctrl states

 arch/arm/boot/dts/omap3-beagle-xm.dts        |   42 ++++++
 arch/arm/boot/dts/omap3-beagle.dts           |   70 +++++++++-
 arch/arm/boot/dts/omap3.dtsi                 |   21 +++-
 arch/arm/boot/dts/omap4-panda-common.dtsi    |   34 +++++
 arch/arm/boot/dts/omap4-sdp.dts              |   34 +++++
 arch/arm/boot/dts/omap4.dtsi                 |   11 ++
 arch/arm/mach-omap2/board-2430sdp.c          |    1 +
 arch/arm/mach-omap2/board-3430sdp.c          |    3 +
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +
 arch/arm/mach-omap2/board-devkit8000.c       |    1 +
 arch/arm/mach-omap2/board-igep0020.c         |    3 +
 arch/arm/mach-omap2/board-ldp.c              |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +
 arch/arm/mach-omap2/board-omap3evm.c         |    3 +
 arch/arm/mach-omap2/board-omap3logic.c       |    1 +
 arch/arm/mach-omap2/board-omap3pandora.c     |    3 +
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 +
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +
 arch/arm/mach-omap2/board-overo.c            |    1 +
 arch/arm/mach-omap2/board-rm680.c            |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 +
 arch/arm/mach-omap2/hsmmc.c                  |    2 +
 arch/arm/mach-omap2/hsmmc.h                  |    2 +
 drivers/mmc/host/omap_hsmmc.c                |  188 +++++++++++++++++---------
 include/linux/platform_data/mmc-omap.h       |    2 +
 26 files changed, 367 insertions(+), 72 deletions(-)

-- 
1.7.5.4

