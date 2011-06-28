From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci: specify maximum discard timeout
Date: Tue, 28 Jun 2011 17:16:03 +0300
Message-ID: <1309270563-28817-3-git-send-email-adrian.hunter@intel.com>
References: <1309270563-28817-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20936 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758133Ab1F1OQY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2011 10:16:24 -0400
In-Reply-To: <1309270563-28817-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>

In general, SDHC hardware timeout cannot be avoided.
Accordingly, the maximum timeout is specified to limit
the maximum discard size.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91d9892..f7e0434 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2488,6 +2488,11 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
+	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
+		mmc->max_discard_to = (1 << 27) / (mmc->f_max / 1000);
+	else
+		mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
-- 
1.7.4.4

