From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v11 0/9] Cavium MMC driver
Date: Mon,  6 Feb 2017 14:39:43 +0100
Message-ID: <20170206133953.8390-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

I've implemented the fixed regulator support as requested. Nevertheless
we need to keep the code for the global power gpio around because that
will still be used by existing Octeon systems (where we can't update the DT).

I've kept the dummy device approach for mmc_of_parse() and devm*,
because a device per child node is required and while we could adopt
mmc_of_parse() we can't change the devm* functions. So I don't see a better
solution at the moment.

Patches are against linux-next.

Changes to v10:
- Renamed files to get a common prefix
- Select GPIO driver in Kconfig
- Support a fixed regulator
- dts: fixed quotes and re-ordered example
- Use new MMC_CAP_3_3V_DDR instead of 1_8V hack
- Use blksz instead of now internal mmc_card_blockaddr
- Added some maintainers

Previous versions:
v10: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1295316.html
v9:  http://marc.info/?l=linux-mmc&m=147431759215233&w=2

Cheers,
Jan

-----------

Jan Glauber (9):
  dt-bindings: mmc: Add Cavium SOCs MMC bindings
  mmc: cavium: Add core MMC driver for Cavium SOCs
  mmc: cavium: Add MMC platform driver for Octeon SOCs
  mmc: cavium: Work-around hardware bug on cn6xxx and cnf7xxx
  mmc: cavium: Add support for Octeon cn7890
  mmc: cavium: Add MMC PCI driver for ThunderX SOCs
  mmc: cavium: Add scatter-gather DMA support
  mmc: cavium: Support DDR mode for eMMC devices
  MAINTAINERS: Add entry for Cavium MMC driver

 .../devicetree/bindings/mmc/cavium-mmc.txt         |   60 +
 MAINTAINERS                                        |    8 +
 arch/mips/cavium-octeon/Makefile                   |    1 +
 arch/mips/cavium-octeon/octeon-mmc-l2c.c           |   98 ++
 drivers/mmc/host/Kconfig                           |   20 +
 drivers/mmc/host/Makefile                          |    4 +
 drivers/mmc/host/cavium-mmc.c                      | 1157 ++++++++++++++++++++
 drivers/mmc/host/cavium-mmc.h                      |  429 ++++++++
 drivers/mmc/host/cavium-pci-thunderx.c             |  206 ++++
 drivers/mmc/host/cavium-pltfm-octeon.c             |  258 +++++
 10 files changed, 2241 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/cavium-mmc.txt
 create mode 100644 arch/mips/cavium-octeon/octeon-mmc-l2c.c
 create mode 100644 drivers/mmc/host/cavium-mmc.c
 create mode 100644 drivers/mmc/host/cavium-mmc.h
 create mode 100644 drivers/mmc/host/cavium-pci-thunderx.c
 create mode 100644 drivers/mmc/host/cavium-pltfm-octeon.c

-- 
2.9.0.rc0.21.g7777322
