From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: fix the spamming log message
Date: Thu, 22 Sep 2016 14:12:00 +0900
Message-ID: <1474521120-9797-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42350 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbcIVFMJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 01:12:09 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0ODW02I9X3S2LY20@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Sep 2016 14:12:02 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>

When there is no Card which is set to "broken-cd", it's displayed a clock
information continuously. Because it's polling for detecting card.
This patch is fixed this problem.

Fixed 'commit 65257a0deed5
("mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()")'

Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 14 +++++++++-----
 drivers/mmc/host/dw_mmc.h |  3 +++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 32380d5..767af20 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1112,11 +1112,12 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
-		dev_info(&slot->mmc->class_dev,
-			 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
-			 slot->id, host->bus_hz, clock,
-			 div ? ((host->bus_hz / div) >> 1) :
-			 host->bus_hz, div);
+		if (clock != slot->__clk_old || force_clkinit)
+			dev_info(&slot->mmc->class_dev,
+				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+				 slot->id, host->bus_hz, clock,
+				 div ? ((host->bus_hz / div) >> 1) :
+				 host->bus_hz, div);
 
 		/* disable clock */
 		mci_writel(host, CLKENA, 0);
@@ -1139,6 +1140,9 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		/* inform CIU */
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
+
+		/* keep the last clock value that was requested from core */
+		slot->__clk_old = clock;
 	}
 
 	host->current_speed = clock;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 9e740bc..e8cd2de 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -249,6 +249,8 @@ extern int dw_mci_resume(struct dw_mci *host);
  * @queue_node: List node for placing this node in the @queue list of
  *	&struct dw_mci.
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
+ * @__clk_old: The last clock value that was requested from core.
+ *	Keeping track of this helps us to avoid spamming the console.
  * @flags: Random state bits associated with the slot.
  * @id: Number of this slot.
  * @sdio_id: Number of this slot in the SDIO interrupt registers.
@@ -263,6 +265,7 @@ struct dw_mci_slot {
 	struct list_head	queue_node;
 
 	unsigned int		clock;
+	unsigned int		__clk_old;
 
 	unsigned long		flags;
 #define DW_MMC_CARD_PRESENT	0
-- 
1.9.1

