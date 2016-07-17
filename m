From: Scott Wood <oss@buserror.net>
Subject: [PATCH v11 0/5] soc: fsl: Add initial guts driver
Date: Sat, 16 Jul 2016 21:50:17 -0500
Message-ID: <1468723822-30457-1-git-send-email-oss@buserror.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Scott Wood <oss@buserror.net>
List-Id: linux-mmc@vger.kernel.org

This patchset adds the beginnings of a driver to consolidate accesses to
the Freescale/NXP "global utilities" block.  Initially only access to SVR
(the system version register) is provided.  This register is needed by
various drivers, mainly for errata detection.  Access to SVR via
mfspr(SPRN_SVR) is now discouraged, especially in drivers that are
not PPC-specific.

I plan to send this via the PPC tree for this merge window, to provide a
base for using/extending the guts driver in various drivers in the next
cycle.

Scott Wood (1):
  powerpc/fsl-pci: Use fsl_guts_get_svr()

Yangbo Lu (2):
  dt: bindings: move guts devicetree doc out of powerpc directory
  soc: fsl: add GUTS driver for QorIQ platforms

yangbo lu (2):
  dt: bindings: update Freescale DCFG compatible
  powerpc/fsl: move mpc85xx.h to include/linux/fsl

 Documentation/devicetree/bindings/arm/fsl.txt      |   6 +-
 .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
 arch/powerpc/platforms/85xx/common.c               |   2 -
 arch/powerpc/sysdev/fsl_pci.c                      |   8 +-
 drivers/clk/clk-qoriq.c                            |   3 +-
 drivers/i2c/busses/i2c-mpc.c                       |   2 +-
 drivers/iommu/fsl_pamu.c                           |   3 +-
 drivers/net/ethernet/freescale/gianfar.c           |   2 +-
 drivers/soc/Kconfig                                |   2 +-
 drivers/soc/fsl/Kconfig                            |   8 ++
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/guts.c                             | 113 ++++++++++++++++++
 include/linux/fsl/guts.h                           | 126 +++++++++++++--------
 .../asm/mpc85xx.h => include/linux/fsl/svr.h       |   4 +-
 16 files changed, 223 insertions(+), 63 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/guts.c
 rename arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h (97%)

-- 
2.7.4
