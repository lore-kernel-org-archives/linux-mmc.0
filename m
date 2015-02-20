From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2] mmc: dw_mmc: Don't start commands while busy
Date: Fri, 20 Feb 2015 12:31:56 -0800
Message-ID: <1424464316-4397-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:38740 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbbBTUcD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Feb 2015 15:32:03 -0500
Received: by iecrd18 with SMTP id rd18so10744407iec.5
        for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2015 12:32:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, Doug Anderson <dianders@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

We've seen problems on some WiFi modules where we seem to send a CMD53
(which requires the data lines) while the module is asserting busy.
We shouldn't do that.

The Designware Databook says that before issuing a new data transfer
command we should check for busy, so that's what we'll do.

We'll leverage the existing dw_mmc knowledge about whether it should
wait for the previous command to finish to know whether we should
check for busy before sending the command.  This means we won't end up
incorrectly waiting for things like CMD52 (SDIO) or CMD13 (SD) which
don't use the data line.

Note that this also has the advantage of making sure that we don't
change the clock while the card is busy, too.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v2:
- Also check for busy in in mci_send_cmd()

 drivers/mmc/host/dw_mmc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4d2e3c2..7733c5c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -102,6 +102,7 @@ struct idmac_desc {
 
 static bool dw_mci_reset(struct dw_mci *host);
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
+static int dw_mci_card_busy(struct mmc_host *mmc);
 
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
@@ -335,6 +336,31 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	return cmdr;
 }
 
+static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(500);
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
+		while (mci_readl(host, STATUS) & SDMMC_STATUS_BUSY) {
+			if (time_after(jiffies, timeout)) {
+				/* Command will fail; we'll pass error then */
+				dev_err(host->dev, "Busy; trying anyway\n");
+				break;
+			}
+			udelay(10);
+		}
+	}
+}
+
 static void dw_mci_start_command(struct dw_mci *host,
 				 struct mmc_command *cmd, u32 cmd_flags)
 {
@@ -345,6 +371,7 @@ static void dw_mci_start_command(struct dw_mci *host,
 
 	mci_writel(host, CMDARG, cmd->arg);
 	wmb();
+	dw_mci_wait_while_busy(host, cmd_flags);
 
 	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
 }
@@ -876,6 +903,7 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 
 	mci_writel(host, CMDARG, arg);
 	wmb();
+	dw_mci_wait_while_busy(host, cmd);
 	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
 
 	while (time_before(jiffies, timeout)) {
-- 
2.2.0.rc0.207.ga3a616c

