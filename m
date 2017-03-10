From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v12 0/9] Cavium MMC driver
Date: Fri, 10 Mar 2017 14:24:58 +0100
Message-ID: <20170310132507.32025-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34178 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964969AbdCJNZb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2017 08:25:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>

Hi Ulf,

I've not heard back from you regarding the bitfields so I assume this
means you're insisting on that point. I'd really like to make some
progress with this series, so I'm reposting now. All comments should be
addressed. Patches are on top of 4.11-rc1.

@Rob: I kept your ACK after the removal of the duplicate voltage line,
please let me know if that is not OK.

Changes to v11:
- Fix build error and kill IS_ENABLED() by using an offset per arch
- Added Rob's ACK for the DT bindings
- Removed obsolete voltage-ranges from DT example
- Replace pci_msix_enable() with pci_alloc_irq_vectors()
- Remove superior hardware comment
- Prefixed probe/removal functions with of_
- Merged OF parsing code into one function, change order of property
  lookup and simplify code
- Removed slot->sclock, no need to store it there
- Substituted now invisible mmc_card_blockaddr()
- Use new 3.3V CAP for DDR
- Update Copyright
- Allow set_ios to set clock to zero
- Converted bitfields to shift-n-mask logic
- Improved error codes after receiving error interrupt
- Added ifndef guards to header
- Add meaningful interrupt names
- Remove stale mmc_host_ops prototype

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

-------

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

 .../devicetree/bindings/mmc/cavium-mmc.txt         |   58 +
 MAINTAINERS                                        |    8 +
 arch/mips/cavium-octeon/Makefile                   |    1 +
 arch/mips/cavium-octeon/octeon-mmc-l2c.c           |   98 ++
 drivers/mmc/host/Kconfig                           |   20 +
 drivers/mmc/host/Makefile                          |    4 +
 drivers/mmc/host/cavium-mmc.c                      | 1115 ++++++++++++++++++++
 drivers/mmc/host/cavium-mmc.h                      |  212 ++++
 drivers/mmc/host/cavium-pci-thunderx.c             |  201 ++++
 drivers/mmc/host/cavium-pltfm-octeon.c             |  260 +++++
 10 files changed, 1977 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/cavium-mmc.txt
 create mode 100644 arch/mips/cavium-octeon/octeon-mmc-l2c.c
 create mode 100644 drivers/mmc/host/cavium-mmc.c
 create mode 100644 drivers/mmc/host/cavium-mmc.h
 create mode 100644 drivers/mmc/host/cavium-pci-thunderx.c
 create mode 100644 drivers/mmc/host/cavium-pltfm-octeon.c

-- 
2.9.0.rc0.21.g7777322

