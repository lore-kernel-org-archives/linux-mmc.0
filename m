From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/5] mmc: dw-mmc: ensure that the card is not busy when
 changing clock.
Date: Thu, 23 Aug 2012 20:31:49 +0900
Message-ID: <503614A5.5090906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22746 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab2HWLcI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 07:32:08 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9700L0VHD7CG20@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 20:32:05 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9700JGPHDGWSB0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 20:32:05 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

To avoid glitches in the card clock output,
need to check whether card is busy or not. 

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   30 ++++++++++++++++++++++++------
 drivers/mmc/host/dw_mmc.h |    1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 36f98c0..8bef3c2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -623,6 +623,27 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 		cmd, arg, cmd_status);
 }
 
+static void dw_mci_inform_ciu(struct dw_mci_slot *slot)
+{
+	struct dw_mci *host = slot->host;
+	unsigned long timeout = jiffies + msecs_to_jiffies(500);
+	u32 ctrl, status;
+
+	do {
+		status = mci_readl(host, STATUS);
+		if (!(status & SDMMC_DATA_BUSY))
+			break;
+		ctrl = mci_readl(host, CTRL);
+		ctrl |= SDMMC_CTRL_RESET;
+		mci_writel(host, CTRL, ctrl);
+	} while (time_before(jiffies, timeout));
+
+	if (status & SDMMC_DATA_BUSY)
+		dev_err(&slot->mmc->class_dev,"Card is busy..!\n");
+
+	mci_send_cmd(slot, SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
+}
+
 static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 {
 	struct dw_mci *host = slot->host;
@@ -650,15 +671,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 		mci_writel(host, CLKSRC, 0);
 
 		/* inform CIU */
-		mci_send_cmd(slot,
-			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
+		dw_mci_inform_ciu(slot);
 
 		/* set clock to desired speed */
 		mci_writel(host, CLKDIV, div);
 
 		/* inform CIU */
-		mci_send_cmd(slot,
-			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
+		dw_mci_inform_ciu(slot);
 
 		/* enable clock; only low power if no SDIO */
 		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
@@ -667,8 +686,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 		mci_writel(host, CLKENA, clk_en_a);
 
 		/* inform CIU */
-		mci_send_cmd(slot,
-			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
+		dw_mci_inform_ciu(slot);
 
 		host->current_speed = slot->clock;
 	}
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 15c27e1..b6a1a78 100644
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
