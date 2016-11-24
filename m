From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/3] mmc: dw_mmc: display the clock message only one time when
 card is polling
Date: Thu, 24 Nov 2016 20:04:42 +0900
Message-ID: <20161124110442.22058-3-jh80.chung@samsung.com>
References: <20161124110442.22058-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59475 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937926AbcKXLFC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 06:05:02 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH5034GM83XHCD0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 24 Nov 2016 20:04:45 +0900 (KST)
In-reply-to: <20161124110442.22058-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

When card is polling (broken-cd), there is a spamming messge related to
clock.
After applied this patch, display the message only one time at boot
time. It's enough to check which clock values is used.
Also prevent to display the spamming message.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 13 ++++++++++++-
 drivers/mmc/host/dw_mmc.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d508225..dd7e95d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1176,13 +1176,24 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
-		if (clock != slot->__clk_old || force_clkinit)
+		if ((clock != slot->__clk_old &&
+			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
+			force_clkinit) {
 			dev_info(&slot->mmc->class_dev,
 				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
 				 slot->id, host->bus_hz, clock,
 				 div ? ((host->bus_hz / div) >> 1) :
 				 host->bus_hz, div);
 
+			/*
+			 * If card is polling, display the message only
+			 * one time at boot time.
+			 */
+			if (slot->mmc->caps & MMC_CAP_NEEDS_POLL &&
+					slot->mmc->f_min == clock)
+				set_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags);
+		}
+
 		/* disable clock */
 		mci_writel(host, CLKENA, 0);
 		mci_writel(host, CLKSRC, 0);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 4a6ae750..c594658 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -272,6 +272,7 @@ struct dw_mci_slot {
 #define DW_MMC_CARD_NEED_INIT	1
 #define DW_MMC_CARD_NO_LOW_PWR	2
 #define DW_MMC_CARD_NO_USE_HOLD 3
+#define DW_MMC_CARD_NEEDS_POLL	4
 	int			id;
 	int			sdio_id;
 };
-- 
2.10.1

