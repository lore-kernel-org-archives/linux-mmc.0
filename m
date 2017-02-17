From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/7] mmc: dw_mmc: move dw_mci_ctrl_reset forward to avoid declaration
Date: Fri, 17 Feb 2017 10:56:41 +0800
Message-ID: <1487300205-202825-4-git-send-email-shawn.lin@rock-chips.com>
References: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:35609 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754293AbdBQDAP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 22:00:15 -0500
In-Reply-To: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 20fe96c8..e87fd95 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -106,7 +106,6 @@ struct idmac_desc {
 /* Each descriptor can transfer up to 4KB of data in chained mode */
 #define DW_MCI_DESC_DATA_LENGTH	0x1000
 
-static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
 static int dw_mci_card_busy(struct mmc_host *mmc);
 static int dw_mci_get_cd(struct mmc_host *mmc);
 
@@ -234,6 +233,26 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 #endif /* defined(CONFIG_DEBUG_FS) */
 
 static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
+static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
+{
+	u32 ctrl;
+
+	ctrl = mci_readl(host, CTRL);
+	ctrl |= reset;
+	mci_writel(host, CTRL, ctrl);
+
+	/* wait till resets clear */
+	if (readl_poll_timeout_atomic(host->regs + SDMMC_CTRL, ctrl,
+				      !(ctrl & reset),
+				      1, 500 * USEC_PER_MSEC)) {
+		dev_err(host->dev,
+			"Timeout resetting block (ctrl reset %#x)\n",
+			ctrl & reset);
+		return false;
+	}
+
+	return true;
+}
 
 static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
@@ -2880,27 +2899,6 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	host->use_dma = TRANS_MODE_PIO;
 }
 
-static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
-{
-	u32 ctrl;
-
-	ctrl = mci_readl(host, CTRL);
-	ctrl |= reset;
-	mci_writel(host, CTRL, ctrl);
-
-	/* wait till resets clear */
-	if (readl_poll_timeout_atomic(host->regs + SDMMC_CTRL, ctrl,
-				      !(ctrl & reset),
-				      1, 500 * USEC_PER_MSEC)) {
-		dev_err(host->dev,
-			"Timeout resetting block (ctrl reset %#x)\n",
-			ctrl & reset);
-		return false;
-	}
-
-	return true;
-}
-
 static void dw_mci_cmd11_timer(unsigned long arg)
 {
 	struct dw_mci *host = (struct dw_mci *)arg;
-- 
1.9.1


