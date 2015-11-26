From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/7] mmc: Some fixes
Date: Thu, 26 Nov 2015 14:00:43 +0200
Message-ID: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21455 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbbKZMEB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 07:04:01 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wenkai Du <wenkai.du@intel.com>

Hi

Here are some fixes.  The important ones have cc: stable.
It doesn't matter to me whether you queue them as fixes
or for v4.5.


Adrian Hunter (6):
      mmc: sdhci-pci: Do not default to 33 Ohm driver strength for Intel SPT
      mmc: sdhci: Do not BUG on invalid vdd
      mmc: sdio: Fix invalid vdd in voltage switch power cycle
      mmc: sdhc: Fix DMA descriptor with zero data length
      mmc: sdhci: 64-bit DMA actually has 4-byte alignment
      mmc: sdhci: Fix sdhci_runtime_pm_bus_on/off()

Wenkai Du (1):
      mmc: mmc: Fix incorrect use of driver strength switching HS200 and HS400

 drivers/mmc/core/mmc.c            |  6 ++---
 drivers/mmc/core/sdio.c           |  2 +-
 drivers/mmc/host/sdhci-pci-core.c |  2 +-
 drivers/mmc/host/sdhci.c          | 49 +++++++++++++++++++--------------------
 drivers/mmc/host/sdhci.h          | 21 ++++++++++-------
 5 files changed, 40 insertions(+), 40 deletions(-)


Regards
Adrian
