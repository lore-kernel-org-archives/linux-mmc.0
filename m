From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V4 0/7] mmc: add support for sdhci 4.0
Date: Mon, 23 Jul 2018 18:08:21 +0800
Message-ID: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
List-Id: linux-mmc@vger.kernel.org

>From the SD host controller version 4.0 on, SDHCI implementation either
is version 3 compatible or version 4 mode. This patch-set covers those
changes which are common for SDHCI 4.0 version, regardless of whether
they are used with SD or eMMC storage devices.

This patchset also added a new sdhci driver for Spreadtrum's controller
which supports v4.0 mode.

This patchset has been tested on Spreadtrum's mobile phone, emmc can be
initialized, mounted, read and written, with these changes for common
sdhci framework and sdhci-sprd driver.

Changes from V3:
* Addressed comments from Adrian:
- set "Host Control 2" when enabled v4 mode, and do the same for reset-for-all in sdhci_do_reset();
- Moved "v4_mode" above to the private;
- Change the subject of patch 2/7;
- Use %pad to pirnt dma_addr_t;
- Adjusted to not clear SDHCI_USE_SDMA for v4 mode in sdhci_setup_host();
- Changed the function name to sdhci_can_64bit_dma() instead of sdhci_use_64bit_dma;
- Adjusted to write SDHCI_CTRL_64BIT_ADDR when we decide to use 64-bit DMA in V4 mode,
  rather than check the register to decide if use 64-bit DMA;
- Added a comments for using dma_zalloc_coherent() to replace dma_alloc_coherent();
- Added SDHCI_SPEC_420;
- Set 16-bit block count register to zero conditionally when using 32-bit block count;
- Adjusted to Use 32-bit block count register only for v4.10 v4 mode;
- Added the rules used for AUTO CMD23/12 to AUTO CMD as well;
- Moved the selection of Host Control 2 register CMD23 Enable to sdhci_init() from Spreadtrum's driver;
- Used usleep_range() to replace udelay();
- Added the checks for clk_prepare_enable().
* Added comments for Spreadtrum's specific changes to the register SDHCI_SOFTWARE_RESET;

Changes from V2:
* Addressed comments from Adrian:
- Added sdhci_enable_v4_mode() for enabling v4 mode instead of determining by reading from registers;
- Added support for 64-bit SDMA address in v4 mode;
- Dropped the changes of ADMA2 data aglinment;
- Added support for "Auto Cmd Auto Select".
* Rebased on v4.18-rc2.
* Dealt with a few issues in sdhci-sprd:
- Save return value of mmc_of_parse();
- Add checking for clk_prepare_enable();
- Use BIT() macro instead.

Changes from v1:
* Addressed comments from Ulf:
 - Add dt-bindings for Spreadtrum sdhci;
 - Use assigned-clocks* DT bindings to set default source of sdio clock;
 - Removed unuseful print;
 - Removed two functions which are not used;
 - Add back the missing pm_runtime_put_autosuspend() after adding sdhci host.

* Changed Spreadtrum sdhci driver name to sdhci-sprd.

Chunyan Zhang (7):
  mmc: sdhci: add sd host v4 mode
  mmc: sdhci: Change SDMA address register for v4 mode
  mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: add 32-bit block count support for v4 mode
  mmc: sdhci: add Auto CMD Auto Select support
  mmc: sdhci-sprd: added Spreadtrum's initial host controller
  dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-sprd.c                      | 455 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           | 223 +++++++---
 drivers/mmc/host/sdhci.h                           |  23 +-
 6 files changed, 708 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4
