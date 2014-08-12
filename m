From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: sdhci: use udelay instead of mdelay
Date: Tue, 12 Aug 2014 16:19:28 +0800
Message-ID: <1407831568-23862-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:11680 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbaHLIRr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Aug 2014 04:17:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>, Yunpeng Gao <yunpeng.gao@intel.com>

From: Chuanxiao Dong <chuanxiao.dong@intel.com>

This patch uses udelay instead of mdelay when waiting
for SDHC hardware to be stable. udelay can help to
reduce the waiting time when is in critical region
which is protected by spinlock.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..74d8c42 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -179,7 +179,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 	}
 
 	/* Wait max 100 ms */
-	timeout = 100;
+	timeout = 10000;
 
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
@@ -190,7 +190,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
@@ -975,7 +975,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	WARN_ON(host->cmd);
 
 	/* Wait max 10 ms */
-	timeout = 10;
+	timeout = 1000;
 
 	mask = SDHCI_CMD_INHIBIT;
 	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
@@ -996,7 +996,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 
 	timeout = jiffies;
@@ -1202,7 +1202,7 @@ clock_set:
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 	/* Wait max 20 ms */
-	timeout = 20;
+	timeout = 2000;
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (timeout == 0) {
@@ -1212,7 +1212,7 @@ clock_set:
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
-- 
1.7.9.5

