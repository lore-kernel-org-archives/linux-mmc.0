From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 4/5] mmc: sdhci: Simplify tuning block size logic
Date: Thu,  1 Dec 2016 16:04:30 +0200
Message-ID: <1480601071-8881-5-git-send-email-adrian.hunter@intel.com>
References: <1480601071-8881-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47701 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757792AbcLAOJl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Dec 2016 09:09:41 -0500
In-Reply-To: <1480601071-8881-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fa89870a690b..e9ff7d005851 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2024,17 +2024,11 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode,
 	 * block to the Host Controller. So we set the block size
 	 * to 64 here.
 	 */
-	if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200) {
-		if (mmc->ios.bus_width == MMC_BUS_WIDTH_8)
-			sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
-				     SDHCI_BLOCK_SIZE);
-		else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4)
-			sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
-				     SDHCI_BLOCK_SIZE);
-	} else {
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
-			     SDHCI_BLOCK_SIZE);
-	}
+	if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200 &&
+	    mmc->ios.bus_width == MMC_BUS_WIDTH_8)
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128), SDHCI_BLOCK_SIZE);
+	else
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
 
 	/*
 	 * The tuning block is sent by the card to the host controller.
-- 
1.9.1

