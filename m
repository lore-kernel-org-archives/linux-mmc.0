From: Dongjin Kim <dongjin.kim@agreeyamobility.net>
Subject: mmc: =?utf-8?b?ZHdfbW1jOg==?= release hardware lock error
Date: Tue, 28 Feb 2012 05:32:09 +0000 (UTC)
Message-ID: <loom.20120228T060529-421@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39427 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866Ab2B1FpN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Feb 2012 00:45:13 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1S2Frz-0008Fh-5o
	for linux-mmc@vger.kernel.org; Tue, 28 Feb 2012 06:45:03 +0100
Received: from 210.113.108.23 ([210.113.108.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2012 06:45:03 +0100
Received: from dongjin.kim by 210.113.108.23 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2012 06:45:03 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I encountered the problem that my hardware is frozen while switching clock from 
400kHz to others. This is caused that hardware locked error was triggered when 
CMD register was written and interrupt was pended. Tested IP version is 2.10a

Cheers,
Dongjin.

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2f7f5ee..05ccee8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -520,15 +520,33 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 
cmd, u32 arg)
 	struct dw_mci *host = slot->host;
 	unsigned long timeout = jiffies + msecs_to_jiffies(500);
 	unsigned int cmd_status = 0;
+	u32 ctrl;
 
+resend:
 	mci_writel(host, CMDARG, arg);
 	wmb();
 	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
+
 	while (time_before(jiffies, timeout)) {
 		cmd_status = mci_readl(host, CMD);
 		if (!(cmd_status & SDMMC_CMD_START))
 			return;
+
+		if (host->cmd_status & SDMMC_INT_HLE) {
+			dev_err(&slot->mmc->class_dev,
+				"Hardware locked error (cmd %#x arg %#x)\n",
+				cmd, arg);
+
+			ctrl = mci_readl(host, CTRL);
+			ctrl |= SDMMC_CTRL_RESET;
+			mci_writel(host, CTRL, ctrl);
+
+			host->cmd_status &= ~SDMMC_INT_HLE;
+
+			goto resend;
+		}
 	}
+
 	dev_err(&slot->mmc->class_dev,
 		"Timeout sending command (cmd %#x arg %#x status %#x)\n",
 		cmd, arg, cmd_status);
@@ -1429,6 +1447,12 @@ static irqreturn_t dw_mci_interrupt(int irq, void 
*dev_id)
 		if (!pending)
 			break;
 
+		if (pending & SDMMC_INT_HLE) {
+			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
+			host->cmd_status = status;
+			smp_wmb();
+		}
+
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
 			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
 			host->cmd_status = status;

