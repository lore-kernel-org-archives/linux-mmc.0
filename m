From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: dw_mmc: Don't start commands while busy
Date: Fri, 20 Feb 2015 10:49:39 -0800
Message-ID: <1424458179-5456-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37138 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbbBTStu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Feb 2015 13:49:50 -0500
Received: by iecrl12 with SMTP id rl12so10040940iec.4
        for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2015 10:49:50 -0800 (PST)
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

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4d2e3c2..a3fcc91 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -102,6 +102,7 @@ struct idmac_desc {
 
 static bool dw_mci_reset(struct dw_mci *host);
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
+static int dw_mci_card_busy(struct mmc_host *mmc);
 
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
@@ -335,6 +336,26 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
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
+	 */
+	if (cmd_flags & SDMMC_CMD_PRV_DAT_WAIT) {
+		while (dw_mci_card_busy(host->cur_slot->mmc)) {
+			if (time_after(jiffies, timeout)) {
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
@@ -345,6 +366,7 @@ static void dw_mci_start_command(struct dw_mci *host,
 
 	mci_writel(host, CMDARG, cmd->arg);
 	wmb();
+	dw_mci_wait_while_busy(host, cmd_flags);
 
 	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
 }
-- 
2.2.0.rc0.207.ga3a616c

