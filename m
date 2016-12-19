From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v10 0/8] Cavium MMC driver
Date: Mon, 19 Dec 2016 13:15:44 +0100
Message-ID: <20161219121552.18316-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33654 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbcLSMQJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2016 07:16:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>

While this patch series seems to be somehow overdue, in the meantime the
same MMC unit was re-used on Cavium's ThunderX SOC so our interest in making
progress upstreaming this driver has doubled now...

Glancing over the history of the series I think most of the high-level
comments should be adressed by now (like DTS representation of the
multiple slots). I've added some new features for the ARM64 port
and in the process re-wrote parts of the driver and split it into smaller,
hopefully easier to review parts.

In porting the driver to arm64 I run into some issues.

1. mmc_parse_of is not capable of supporting multiple slots behind one
   controller. On arm64 the host controller is presented as one PCI device.
   There are no devices per slot as with the platform variant, so I
   needed to create dummy devices to make mmc_parse_of work.
   IMHO it would be cleaner if mmc_parse_of could be extended to cover
   the multiple slots case.

2. Without setting MMC_CAP_1_8V_DDR DDR mode is not usable for eMMC.
   I would prefer to introduce a new cap flag, MMC_CAP_3_3V_DDR,
   if possible. Currently I need to add "mmc-ddr-1_8v" to DTS,
   which seems odd for a 3.3v only host controller.

3. Because the slots share the host controller using the
   "full-pwr-cycle" attribute turned out to not work well.
   I'm not 100% sure just ignoring the attribute is correct.

For the driver to work GPIO support is required, the GPIO driver is
not yet available upstream. Therefore, for the time being I removed
the GPIO dependency from Kconfig.

Feedback welcome!

Changes to v9:
- Split into several patches for easier review
- Re-factor code into smaller functions
- Introduce callback functions for platform specific code
- Remove some dead code
- Remove lots of type casts
- Use NSEC_PER_SEC
- Invert if's to reduce code indentation
- Remove host->linear_buf for now, maybe we can use MMC bounce buffers feature instead
- Use dma_[un]map_sg and length/address accessors instead of direct access
- Set DMA mask
- Add scatter-gather support
- Check for switch errors
- Wait until switch is done
- Enable DDR support for eMMC
- Post CMD23 capability
- Add pr_debug logs
- Split lock acquire from switch_to
- Sort include headers
- Fix code indentation and some checkpatch errors
- Fix includes for octeon specific file
- Fixed modular build on Octeon
- Fail fast on CRC errors (Steven)
- Document devicetree bindings

Cheers,
Jan

--------------------

Jan Glauber (8):
  mmc: cavium: Add core MMC driver for Cavium SOCs
  mmc: octeon: Add MMC platform driver for Octeon SOCs
  mmc: octeon: Work-around hardware bug on cn6xxx and cnf7xxx
  mmc: octeon: Add support for Octeon cn7890
  mmc: thunderx: Add MMC PCI driver for ThunderX SOCs
  mmc: thunderx: Add scatter-gather DMA support
  mmc: thunderx: Support DDR mode for eMMC devices
  dt-bindings: mmc: Add Cavium SOCs MMC bindings

 .../devicetree/bindings/mmc/octeon-mmc.txt         |   59 +
 arch/mips/cavium-octeon/Makefile                   |    1 +
 arch/mips/cavium-octeon/octeon-mmc.c               |   98 ++
 drivers/mmc/host/Kconfig                           |   19 +
 drivers/mmc/host/Makefile                          |    4 +
 drivers/mmc/host/cavium_core_mmc.c                 | 1137 ++++++++++++++++++++
 drivers/mmc/host/cavium_mmc.h                      |  425 ++++++++
 drivers/mmc/host/octeon_platdrv_mmc.c              |  260 +++++
 drivers/mmc/host/thunderx_pcidrv_mmc.c             |  217 ++++
 9 files changed, 2220 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt
 create mode 100644 arch/mips/cavium-octeon/octeon-mmc.c
 create mode 100644 drivers/mmc/host/cavium_core_mmc.c
 create mode 100644 drivers/mmc/host/cavium_mmc.h
 create mode 100644 drivers/mmc/host/octeon_platdrv_mmc.c
 create mode 100644 drivers/mmc/host/thunderx_pcidrv_mmc.c

-- 
2.9.0.rc0.21.g7777322

