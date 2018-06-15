From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V2 0/7] mmc: add support for sdhci 4.0
Date: Fri, 15 Jun 2018 10:04:08 +0800
Message-ID: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
List-Id: linux-mmc@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

>From the SD host controller version 4.0 on, SDHCI implementation either
is version 3 compatible or version 4 mode. This patch-set covers those
changes which are common for SDHCI 4.0 version, regardless of whether
they are used with SD or eMMC storage devices.

This patchset also added a new sdhci driver for Spreadtrum's controller
which supports v4.0 mode.

This patchset has been tested on Spreadtrum's mobile phone, emmc can be
initialized, mounted, read and written, with these changes for common
sdhci framework and sdhci-sprd driver.

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
  mmc: sdhci: made changes for System Address register of SDMA
  mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: add 32-bit block count support for v4 mode
  mmc: sdhci: add CMD23 support for v4 mode
  mmc: sdhci-sprd: added Spreadtrum's initial host controller
  dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-sprd.c                      | 426 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |  85 +++-
 drivers/mmc/host/sdhci.h                           |  31 +-
 6 files changed, 575 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4
