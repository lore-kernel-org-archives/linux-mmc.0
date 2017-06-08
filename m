From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] mmc: sdhci: clear interrupt when retune interrupt received
Date: Thu,  8 Jun 2017 11:51:56 -0700
Message-ID: <1496947916-15785-1-git-send-email-troy.kisky@boundarydevices.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wsip-98-189-142-135.oc.oc.cox.net ([98.189.142.135]:39094 "EHLO
        office-server2" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751442AbdFHTRB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 15:17:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: aisheng.dong@nxp.com, adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, fabio.estevam@nxp.com, gary.bisson@boundarydevices.com, Troy Kisky <troy.kisky@boundarydevices.com>

This lets the loop exit before max_loops reaches 0.

Fixes: f37b20ebc4bc ("mmc: sdhci: add standard hw auto retuning support")

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d43..e104194 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2687,7 +2687,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 		/* Clear selected interrupts. */
 		mask = intmask & (SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
-				  SDHCI_INT_BUS_POWER);
+				  SDHCI_INT_BUS_POWER | SDHCI_INT_RETUNE);
 		sdhci_writel(host, mask, SDHCI_INT_STATUS);
 
 		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
-- 
2.7.4

