From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 00/11] mmc: sdhci: Cleanup assignment/definition of PM ops
Date: Wed, 27 Jul 2016 13:31:56 +0200
Message-ID: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35854 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbcG0LcN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:13 -0400
Received: by mail-lf0-f46.google.com with SMTP id g62so25072167lfe.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

The code in various sdhci drivers can be cleaned up in regards how PM ops is
being defined and assigned. This series attempts to clean up this code.

In the end we want system PM sleep callbacks to be defined within #ifdef
CONFIG_PM_SLEEP and not as currently within CONFIG_PM.

Ulf Hansson (11):
  mmc: sdhci-pci-core: Simplify code by using SET_SYSTEM_SLEEP_PM_OPS
  mmc: sdhci-acpi: Simplify code by using SET_SYSTEM_SLEEP_PM_OPS
  mmc: sdhci-of-esdhc: Simplify code by using SIMPLE_DEV_PM_OPS
  mmc: sdhci-pxav3: Remove non needed #ifdef CONFIG_PM for dev_pm_ops
  mmc: sdhci-s3c: Remove non needed #ifdef CONFIG_PM for dev_pm_ops
  mmc: sdhci-sirf: Remove non needed #ifdef CONFIG_PM* for dev_pm_ops
  mmc: sdhci-esdhc-imx: Assign system PM ops within #ifdef
    CONFIG_PM_SLEEP
  mmc: sdhci-esdhc-imx: Use common sdhci_suspend|resume_host()
  mmc: sdhci-pltfm: Make sdhci_pltfm_suspend|resume() static
  mmc: sdhci-pltfm: Convert to use the SET_SYSTEM_SLEEP_PM_OPS
  mmc: sdhci-pltfm: Drop define for SDHCI_PLTFM_PMOPS

 drivers/mmc/host/sdhci-acpi.c      |  8 +-------
 drivers/mmc/host/sdhci-bcm-kona.c  |  2 +-
 drivers/mmc/host/sdhci-cns3xxx.c   |  2 +-
 drivers/mmc/host/sdhci-dove.c      |  2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++++++---
 drivers/mmc/host/sdhci-iproc.c     |  2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  | 16 ++++++----------
 drivers/mmc/host/sdhci-of-hlwd.c   |  2 +-
 drivers/mmc/host/sdhci-pci-core.c  | 16 +++++-----------
 drivers/mmc/host/sdhci-pltfm.c     | 13 +++++--------
 drivers/mmc/host/sdhci-pltfm.h     |  7 -------
 drivers/mmc/host/sdhci-pxav2.c     |  2 +-
 drivers/mmc/host/sdhci-pxav3.c     |  9 +--------
 drivers/mmc/host/sdhci-s3c.c       |  9 +--------
 drivers/mmc/host/sdhci-sirf.c      |  4 +---
 drivers/mmc/host/sdhci-tegra.c     |  2 +-
 drivers/mmc/host/sdhci_f_sdh30.c   |  2 +-
 17 files changed, 35 insertions(+), 73 deletions(-)

-- 
1.9.1

