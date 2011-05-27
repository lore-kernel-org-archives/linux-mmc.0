From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 0/4] Consolidate sdhci pltfm & OF drivers and get them self registered
Date: Fri, 27 May 2011 23:48:11 +0800
Message-ID: <1306511295-2433-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36859 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab1E0Pko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2011 11:40:44 -0400
Received: by pwi15 with SMTP id 15so852541pwi.19
        for <linux-mmc@vger.kernel.org>; Fri, 27 May 2011 08:40:44 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

Changes since v3:
 * Update Kconfig and Makefile to fix module build failure

Changes since v2:
 * Drop imx mpc esdhc consolidation
 * Fix checkpatch errors
 * Add sdhci-of-core.c copyright into sdhci-pltfm.c

Changes since v1:
 * Rebase on cjb's mmc-next tree
 * Introduce helper function pair sdhci_pltfm_register and
   sdhci_pltfm_unregister
 * Eliminate variable 'scratch' in .remove hook to make the code
   look simple
 * Return ERR_PTR in sdhci_pltfm_init and use IS_ERR/PTR_ERR to check
   return value in .probe hooks
 * Correct MODULE_AUTHOR statement
 * Split esdhc conlidation patch to ease reviewing

Shawn Guo (4):
      mmc: sdhci: make sdhci-pltfm device drivers self registered
      mmc: sdhci: eliminate sdhci_of_host and sdhci_of_data
      mmc: sdhci: make sdhci-of device drivers self registered
      mmc: sdhci: merge two sdhci-pltfm.h into one

 drivers/mmc/host/Kconfig           |   42 ++----
 drivers/mmc/host/Makefile          |   23 ++--
 drivers/mmc/host/sdhci-cns3xxx.c   |   43 ++++++-
 drivers/mmc/host/sdhci-dove.c      |   42 ++++++-
 drivers/mmc/host/sdhci-esdhc-imx.c |  114 +++++++++++-----
 drivers/mmc/host/sdhci-of-core.c   |  250 ---------------------------------
 drivers/mmc/host/sdhci-of-esdhc.c  |   85 +++++++++---
 drivers/mmc/host/sdhci-of-hlwd.c   |   66 ++++++++--
 drivers/mmc/host/sdhci-of.h        |   42 ------
 drivers/mmc/host/sdhci-pltfm.c     |  266 ++++++++++++++++++++----------------
 drivers/mmc/host/sdhci-pltfm.h     |   39 +++++-
 drivers/mmc/host/sdhci-tegra.c     |  116 +++++++++++-----
 include/linux/mmc/sdhci-pltfm.h    |   35 -----
 13 files changed, 574 insertions(+), 589 deletions(-)
