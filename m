From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 6/7] mmc: dw_mmc: move mci_send_cmd forward to avoid declaration
Date: Fri, 17 Feb 2017 10:59:44 +0800
Message-ID: <1487300384-203966-1-git-send-email-shawn.lin@rock-chips.com>
References: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:57410 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755018AbdBQDCM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 22:02:12 -0500
In-Reply-To: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 81 +++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e8c5ee2..a4a43e6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -229,7 +229,6 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 }
 #endif /* defined(CONFIG_DEBUG_FS) */
 
-static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
 {
 	u32 ctrl;
@@ -251,6 +250,46 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
 	return true;
 }
 
+static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
+{
+	u32 status;
+
+	/*
+	 * Databook says that before issuing a new data transfer command
+	 * we need to check to see if the card is busy.  Data transfer commands
+	 * all have SDMMC_CMD_PRV_DAT_WAIT set, so we'll key off that.
+	 *
+	 * ...also allow sending for SDMMC_CMD_VOLT_SWITCH where busy is
+	 * expected.
+	 */
+	if ((cmd_flags & SDMMC_CMD_PRV_DAT_WAIT) &&
+	    !(cmd_flags & SDMMC_CMD_VOLT_SWITCH)) {
+		if (readl_poll_timeout_atomic(host->regs + SDMMC_STATUS,
+					      status,
+					      !(status & SDMMC_STATUS_BUSY),
+					      10, 500 * USEC_PER_MSEC))
+			dev_err(host->dev, "Busy; trying anyway\n");
+	}
+}
+
+static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
+{
+	struct dw_mci *host = slot->host;
+	unsigned int cmd_status = 0;
+
+	mci_writel(host, CMDARG, arg);
+	wmb(); /* drain writebuffer */
+	dw_mci_wait_while_busy(host, cmd);
+	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
+
+	if (readl_poll_timeout_atomic(host->regs + SDMMC_CMD, cmd_status,
+				      !(cmd_status & SDMMC_CMD_START),
+				      1, 500 * USEC_PER_MSEC))
+		dev_err(&slot->mmc->class_dev,
+			"Timeout sending command (cmd %#x arg %#x status %#x)\n",
+			cmd, arg, cmd_status);
+}
+
 static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
@@ -358,28 +397,6 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	return cmdr;
 }
 
-static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
-{
-	u32 status;
-
-	/*
-	 * Databook says that before issuing a new data transfer command
-	 * we need to check to see if the card is busy.  Data transfer commands
-	 * all have SDMMC_CMD_PRV_DAT_WAIT set, so we'll key off that.
-	 *
-	 * ...also allow sending for SDMMC_CMD_VOLT_SWITCH where busy is
-	 * expected.
-	 */
-	if ((cmd_flags & SDMMC_CMD_PRV_DAT_WAIT) &&
-	    !(cmd_flags & SDMMC_CMD_VOLT_SWITCH)) {
-		if (readl_poll_timeout_atomic(host->regs + SDMMC_STATUS,
-					      status,
-					      !(status & SDMMC_STATUS_BUSY),
-					      10, 500 * USEC_PER_MSEC))
-			dev_err(host->dev, "Busy; trying anyway\n");
-	}
-}
-
 static void dw_mci_start_command(struct dw_mci *host,
 				 struct mmc_command *cmd, u32 cmd_flags)
 {
@@ -1184,24 +1201,6 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 	}
 }
 
-static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
-{
-	struct dw_mci *host = slot->host;
-	unsigned int cmd_status = 0;
-
-	mci_writel(host, CMDARG, arg);
-	wmb(); /* drain writebuffer */
-	dw_mci_wait_while_busy(host, cmd);
-	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
-
-	if (readl_poll_timeout_atomic(host->regs + SDMMC_CMD, cmd_status,
-				      !(cmd_status & SDMMC_CMD_START),
-				      1, 500 * USEC_PER_MSEC))
-		dev_err(&slot->mmc->class_dev,
-			"Timeout sending command (cmd %#x arg %#x status %#x)\n",
-			cmd, arg, cmd_status);
-}
-
 static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
-- 
1.9.1


