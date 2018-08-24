From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V6 0/9] mmc: add support for sdhci 4.0
Date: Fri, 24 Aug 2018 17:20:19 +0800
Message-ID: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
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

This patchset is based on the unmerged patch: https://lkml.org/lkml/2018/8/20/140

Changes from V5:
- Added SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT;
- Removed sdhci_enable_cmd23();
- Added setting SDHCI_ARGUMENT2 for CMD23 in v4_mode;
- Clear SDHCI_CMD23_ENABLE when not using CMD23;
- Moved disabling auto-CMD23 to sprd sdhci driver;
- Added sdhci_sprd_request() function to hook to mmc_host_ops.request.


Previous patch series:
v5: https://lkml.org/lkml/2018/8/16/122
v4: https://lkml.org/lkml/2018/7/23/269
v3: https://lkml.org/lkml/2018/7/8/239
v2: https://lkml.org/lkml/2018/6/14/936
v1: https://lkml.org/lkml/2018/6/8/108

Chunyan Zhang (9):
  mmc: sdhci: Add version V4 definition
  mmc: sdhci: Add sd host v4 mode
  mmc: sdhci: Change SDMA address register for v4 mode
  mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: Add 32-bit block count support for v4 mode
  mmc: sdhci: Add Auto CMD Auto Select support
  mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
  mmc: sdhci-sprd: Add Spreadtrum's initial host controller
  dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-sprd.c                      | 485 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           | 225 ++++++++--
 drivers/mmc/host/sdhci.h                           |  23 +-
 6 files changed, 738 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4
