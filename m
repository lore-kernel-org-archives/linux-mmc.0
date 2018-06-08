From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH 0/6] mmc: add support for sdhci 4.0
Date: Fri,  8 Jun 2018 16:18:07 +0800
Message-ID: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
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

Chunyan Zhang (6):
  mmc: sdhci: add sd host v4 mode
  mmc: sdhci: made changes for System Address register of SDMA
  mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: add 32-bit block count support for v4 mode
  mmc: sdhci: add CMD23 support for v4 mode
  mmc: host: sdhci-sprd: added Spreadtrum's host controller R11

 drivers/mmc/host/Kconfig          |  13 ++
 drivers/mmc/host/Makefile         |   1 +
 drivers/mmc/host/sdhci-sprd-r11.c | 472 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          |  85 +++++--
 drivers/mmc/host/sdhci.h          |  31 ++-
 5 files changed, 580 insertions(+), 22 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-sprd-r11.c

-- 
2.7.4
