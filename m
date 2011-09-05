From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw_mmc: ensure the ciu-reset
Date: Mon, 05 Sep 2011 09:39:13 +0900
Message-ID: <4E641A31.8070604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38462 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab1IEAie (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Sep 2011 20:38:34 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LR000B19XR9X0E0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 05 Sep 2011 09:38:32 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LR000GR2XS8UC00@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 05 Sep 2011 09:38:32 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Wonil Choi <wonil22.choi@samsung.com>

This patch ensured the CIU-reset.

If data0 line is low, bit[9] in status register is set to 1.
Then we can know the card is busy.

Using this bit in status register, we can ensure to reset the CIU correctly.
When card is busy and doing ciu-reset, seem like reset completed.
But actually didn't complete ciu-reset. because card is busy.

So i think good whether check card busy or not before reset the ciu.


Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Reported-by: Wonil Choi <wonil22.choi@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   15 +++++++++------
 drivers/mmc/host/dw_mmc.h |    3 +++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0ed1d28..277f8ef 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1785,17 +1785,20 @@ no_dma:
 static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(500);
-	unsigned int ctrl;
+	unsigned int ctrl, status;
 
-	mci_writel(host, CTRL, (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
-				SDMMC_CTRL_DMA_RESET));
+	mci_writel(host, CTRL, SDMMC_CTRL_RESET_ALL);
 
 	/* wait till resets clear */
 	do {
 		ctrl = mci_readl(host, CTRL);
-		if (!(ctrl & (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
-			      SDMMC_CTRL_DMA_RESET)))
-			return true;
+		if (!(ctrl & SDMMC_CTRL_RESET_ALL)) {
+			status = mci_readl(host, STATUS);
+			if (!(status & SDMMC_DATA_BUSY))
+				return true;
+			else
+				mci_writel(host, CTRL, SDMMC_CTRL_RESET_ALL);
+		}
 	} while (time_before(jiffies, timeout));
 
 	dev_err(dev, "Timeout resetting block (ctrl %#x)\n", ctrl);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index bfa3c1c..94e48ad 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -69,6 +69,8 @@
 #define SDMMC_CTRL_DMA_RESET		BIT(2)
 #define SDMMC_CTRL_FIFO_RESET		BIT(1)
 #define SDMMC_CTRL_RESET		BIT(0)
+#define SDMMC_CTRL_RESET_ALL	(SDMMC_CTRL_DMA_RESET |\
+			SDMMC_CTRL_FIFO_RESET | SDMMC_CTRL_RESET)
 /* Clock Enable register defines */
 #define SDMMC_CLKEN_LOW_PWR		BIT(16)
 #define SDMMC_CLKEN_ENABLE		BIT(0)
@@ -118,6 +120,7 @@
 #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
 /* Status register defines */
 #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FF)
+#define SDMMC_DATA_BUSY			BIT(9)
 /* Internal DMAC interrupt defines */
 #define SDMMC_IDMAC_INT_AI		BIT(9)
 #define SDMMC_IDMAC_INT_NI		BIT(8)
