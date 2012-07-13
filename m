From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw-mmc: retry to send when inform ciu
Date: Fri, 13 Jul 2012 12:58:15 +0900
Message-ID: <4FFF9CD7.6000904@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59326 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab2GMD61 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jul 2012 23:58:27 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M72006MOZ1DQL20@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 13 Jul 2012 12:58:26 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M7200810Z1CVZ50@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 13 Jul 2012 12:58:25 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

As DesignWare spec, when inform ciu, waiting for clearing start_bit
or HLE is set. In case of HLE, repeat the command.

Before the patch, repeat the below message.
mmc_host mmc0: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)
If this message is produced, repeat the send command during 10 times.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   39 +++++++++++++++++++++++++++++++--------
 1 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 72dc3cd..bec1a67 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -603,7 +603,7 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 	}
 }
 
-static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
+static int mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 {
 	struct dw_mci *host = slot->host;
 	unsigned long timeout = jiffies + msecs_to_jiffies(500);
@@ -616,11 +616,37 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 	while (time_before(jiffies, timeout)) {
 		cmd_status = mci_readl(host, CMD);
 		if (!(cmd_status & SDMMC_CMD_START))
-			return;
+			return 0;
 	}
 	dev_err(&slot->mmc->class_dev,
 		"Timeout sending command (cmd %#x arg %#x status %#x)\n",
 		cmd, arg, cmd_status);
+
+	return -ETIMEDOUT;
+}
+
+static void dw_mci_inform_ciu(struct dw_mci_slot *slot)
+{
+	struct dw_mci *host = slot->host;
+	unsigned long retry = 10;
+	int ret;
+	u32 ctrl;
+
+	while (1) {
+		ret = mci_send_cmd(slot,
+		     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
+		if (!ret)
+			break;
+		ctrl = mci_readl(host, CTRL);
+		ctrl |= SDMMC_CTRL_RESET;
+		mci_writel(host, CTRL, ctrl);
+
+		if (retry-- == 0) {
+			dev_err(&slot->mmc->class_dev,"Timeout inform CIU\n");
+			break;
+		} else
+			dev_info(&slot->mmc->class_dev,"Retry send command\n");
+	}
 }
 
 static void dw_mci_setup_bus(struct dw_mci_slot *slot)
@@ -649,23 +675,20 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
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
 
 		/* enable clock */
 		mci_writel(host, CLKENA, ((SDMMC_CLKEN_ENABLE |
 			   SDMMC_CLKEN_LOW_PWR) << slot->id));
 
 		/* inform CIU */
-		mci_send_cmd(slot,
-			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
+		dw_mci_inform_ciu(slot);
 
 		host->current_speed = slot->clock;
 	}
