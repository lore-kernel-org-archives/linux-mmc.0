From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw-mmc: check whether card is busy or not,
 before disabling clock
Date: Mon, 29 Oct 2012 16:51:20 +0900
Message-ID: <508E3578.9050007@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:31262 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432Ab2J2HvX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 03:51:23 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCN004729TF2VU0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 29 Oct 2012 16:51:21 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MCN009IO9TLIZ30@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 29 Oct 2012 16:51:21 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

Before disabling clock, need to check whether card is busy on not.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   53 +++++++++++++++++++++++++++-----------------
 drivers/mmc/host/dw_mmc.h |    1 +
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4b2bedc..5707bb6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -228,6 +228,27 @@ static void dw_mci_set_timeout(struct dw_mci *host)
 	mci_writel(host, TMOUT, 0xffffffff);
 }
 
+static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(500);
+	unsigned int ctrl;
+
+	mci_writel(host, CTRL, (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
+				SDMMC_CTRL_DMA_RESET));
+
+	/* wait till resets clear */
+	do {
+		ctrl = mci_readl(host, CTRL);
+		if (!(ctrl & (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
+			      SDMMC_CTRL_DMA_RESET)))
+			return true;
+	} while (time_before(jiffies, timeout));
+
+	dev_err(dev, "Timeout resetting block (ctrl %#x)\n", ctrl);
+
+	return false;
+}
+
 static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct mmc_data	*data;
@@ -621,6 +642,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 	struct dw_mci *host = slot->host;
 	u32 div;
 	u32 clk_en_a;
+	int timeout = 1000;
 
 	if (slot->clock != host->current_speed) {
 		div = host->bus_hz / slot->clock;
@@ -637,6 +659,16 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 			 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ"
 			 " div = %d)\n", slot->id, host->bus_hz, slot->clock,
 			 div ? ((host->bus_hz / div) >> 1) : host->bus_hz, div);
+		do {
+			if (!(mci_readl(host, STATUS) & SDMMC_DATA_BUSY))
+				break;
+			if (timeout-- < 0) {
+				dev_err(host->dev, "Can't disable clock"
+					"because Card is busy!!\n");
+				return;
+			}
+			mci_wait_reset(host->dev, host);
+		} while (1);
 
 		/* disable clock */
 		mci_writel(host, CLKENA, 0);
@@ -1995,27 +2027,6 @@ no_dma:
 	return;
 }
 
-static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(500);
-	unsigned int ctrl;
-
-	mci_writel(host, CTRL, (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
-				SDMMC_CTRL_DMA_RESET));
-
-	/* wait till resets clear */
-	do {
-		ctrl = mci_readl(host, CTRL);
-		if (!(ctrl & (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
-			      SDMMC_CTRL_DMA_RESET)))
-			return true;
-	} while (time_before(jiffies, timeout));
-
-	dev_err(dev, "Timeout resetting block (ctrl %#x)\n", ctrl);
-
-	return false;
-}
-
 #ifdef CONFIG_OF
 static struct dw_mci_of_quirks {
 	char *quirk;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 53b8fd9..4f27357 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -127,6 +127,7 @@
 #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
 /* Status register defines */
 #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
+#define SDMMC_DATA_BUSY			BIT(9)
 /* Internal DMAC interrupt defines */
 #define SDMMC_IDMAC_INT_AI		BIT(9)
 #define SDMMC_IDMAC_INT_NI		BIT(8)
-- 
1.7.4.1
