From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/7] mmc: dw_mmc: improve the timeout polling code
Date: Fri, 17 Feb 2017 10:56:39 +0800
Message-ID: <1487300205-202825-2-git-send-email-shawn.lin@rock-chips.com>
References: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:50747 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754293AbdBQC7e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 21:59:34 -0500
In-Reply-To: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Just use the readl_poll_timeout{_atomic} to avold open
coding them.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 92 ++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a9ac0b4..a1ddbb8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -64,6 +65,8 @@
 
 struct idmac_desc_64addr {
 	u32		des0;	/* Control Descriptor */
+#define IDMAC_OWN_CLR64(x) \
+	!((x) & cpu_to_le32(IDMAC_DES0_OWN))
 
 	u32		des1;	/* Reserved */
 
@@ -342,7 +345,7 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 
 static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(500);
+	u32 status;
 
 	/*
 	 * Databook says that before issuing a new data transfer command
@@ -354,14 +357,11 @@ static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
 	 */
 	if ((cmd_flags & SDMMC_CMD_PRV_DAT_WAIT) &&
 	    !(cmd_flags & SDMMC_CMD_VOLT_SWITCH)) {
-		while (mci_readl(host, STATUS) & SDMMC_STATUS_BUSY) {
-			if (time_after(jiffies, timeout)) {
-				/* Command will fail; we'll pass error then */
-				dev_err(host->dev, "Busy; trying anyway\n");
-				break;
-			}
-			udelay(10);
-		}
+		if (readl_poll_timeout_atomic(host->regs + SDMMC_STATUS,
+					      status,
+					      !(status & SDMMC_STATUS_BUSY),
+					      10, 500 * USEC_PER_MSEC))
+			dev_err(host->dev, "Busy; trying anyway\n");
 	}
 }
 
@@ -554,7 +554,7 @@ static inline int dw_mci_prepare_desc64(struct dw_mci *host,
 {
 	unsigned int desc_len;
 	struct idmac_desc_64addr *desc_first, *desc_last, *desc;
-	unsigned long timeout;
+	u32 val;
 	int i;
 
 	desc_first = desc_last = desc = host->sg_cpu;
@@ -576,12 +576,10 @@ static inline int dw_mci_prepare_desc64(struct dw_mci *host,
 			 * isn't still owned by IDMAC as IDMAC's write
 			 * ops and CPU's read ops are asynchronous.
 			 */
-			timeout = jiffies + msecs_to_jiffies(100);
-			while (readl(&desc->des0) & IDMAC_DES0_OWN) {
-				if (time_after(jiffies, timeout))
-					goto err_own_bit;
-				udelay(10);
-			}
+			if (readl_poll_timeout_atomic(&desc->des0, val,
+						!(val & IDMAC_DES0_OWN),
+						10, 100 * USEC_PER_MSEC))
+				goto err_own_bit;
 
 			/*
 			 * Set the OWN bit and disable interrupts
@@ -628,7 +626,7 @@ static inline int dw_mci_prepare_desc32(struct dw_mci *host,
 {
 	unsigned int desc_len;
 	struct idmac_desc *desc_first, *desc_last, *desc;
-	unsigned long timeout;
+	u32 val;
 	int i;
 
 	desc_first = desc_last = desc = host->sg_cpu;
@@ -650,13 +648,11 @@ static inline int dw_mci_prepare_desc32(struct dw_mci *host,
 			 * isn't still owned by IDMAC as IDMAC's write
 			 * ops and CPU's read ops are asynchronous.
 			 */
-			timeout = jiffies + msecs_to_jiffies(100);
-			while (readl(&desc->des0) &
-			       cpu_to_le32(IDMAC_DES0_OWN)) {
-				if (time_after(jiffies, timeout))
-					goto err_own_bit;
-				udelay(10);
-			}
+			if (readl_poll_timeout_atomic(&desc->des0, val,
+						      IDMAC_OWN_CLR64(val),
+						      10,
+						      100 * USEC_PER_MSEC))
+				goto err_own_bit;
 
 			/*
 			 * Set the OWN bit and disable interrupts
@@ -1135,7 +1131,6 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 {
 	struct dw_mci *host = slot->host;
-	unsigned long timeout = jiffies + msecs_to_jiffies(500);
 	unsigned int cmd_status = 0;
 
 	mci_writel(host, CMDARG, arg);
@@ -1143,14 +1138,12 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 	dw_mci_wait_while_busy(host, cmd);
 	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
 
-	while (time_before(jiffies, timeout)) {
-		cmd_status = mci_readl(host, CMD);
-		if (!(cmd_status & SDMMC_CMD_START))
-			return;
-	}
-	dev_err(&slot->mmc->class_dev,
-		"Timeout sending command (cmd %#x arg %#x status %#x)\n",
-		cmd, arg, cmd_status);
+	if (readl_poll_timeout_atomic(host->regs + SDMMC_CMD, cmd_status,
+				      !(cmd_status & SDMMC_CMD_START),
+				      1, 500 * USEC_PER_MSEC))
+		dev_err(&slot->mmc->class_dev,
+			"Timeout sending command (cmd %#x arg %#x status %#x)\n",
+			cmd, arg, cmd_status);
 }
 
 static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
@@ -2825,7 +2818,6 @@ static void dw_mci_init_dma(struct dw_mci *host)
 
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(500);
 	u32 ctrl;
 
 	ctrl = mci_readl(host, CTRL);
@@ -2833,17 +2825,16 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
 	mci_writel(host, CTRL, ctrl);
 
 	/* wait till resets clear */
-	do {
-		ctrl = mci_readl(host, CTRL);
-		if (!(ctrl & reset))
-			return true;
-	} while (time_before(jiffies, timeout));
-
-	dev_err(host->dev,
-		"Timeout resetting block (ctrl reset %#x)\n",
-		ctrl & reset);
+	if (readl_poll_timeout_atomic(host->regs + SDMMC_CTRL, ctrl,
+				      !(ctrl & reset),
+				      1, 500 * USEC_PER_MSEC)) {
+		dev_err(host->dev,
+			"Timeout resetting block (ctrl reset %#x)\n",
+			ctrl & reset);
+		return false;
+	}
 
-	return false;
+	return true;
 }
 
 static bool dw_mci_reset(struct dw_mci *host)
@@ -2872,17 +2863,12 @@ static bool dw_mci_reset(struct dw_mci *host)
 
 		/* if using dma we wait for dma_req to clear */
 		if (host->use_dma) {
-			unsigned long timeout = jiffies + msecs_to_jiffies(500);
 			u32 status;
 
-			do {
-				status = mci_readl(host, STATUS);
-				if (!(status & SDMMC_STATUS_DMA_REQ))
-					break;
-				cpu_relax();
-			} while (time_before(jiffies, timeout));
-
-			if (status & SDMMC_STATUS_DMA_REQ) {
+			if (readl_poll_timeout_atomic(host->regs + SDMMC_STATUS,
+						      status,
+						      !(status & SDMMC_STATUS_DMA_REQ),
+						      1, 500 * USEC_PER_MSEC)) {
 				dev_err(host->dev,
 					"%s: Timeout waiting for dma_req to clear during reset\n",
 					__func__);
-- 
1.9.1


