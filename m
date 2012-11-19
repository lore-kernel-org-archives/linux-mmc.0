From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 4/4] mmc: dw_mmc: Add sdio power bindings
Date: Mon, 19 Nov 2012 10:26:21 +0530
Message-ID: <1353300981-24652-5-git-send-email-a.kesavan@samsung.com>
References: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18525 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762Ab2KSEwp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 23:52:45 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDP00E4RXIQS1J0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:52:44 +0900 (KST)
Received: from localhost.localdomain ([107.108.73.92])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDP00338XGFP3E0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:52:44 +0900 (KST)
In-reply-to: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org

Add dt-based retrieval of host sdio pm capabilities. Based on
the dt based discovery do a bus init in the resume function.

Signed-off-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   20 +++++++++++++++++---
 include/linux/mmc/dw_mmc.h |    1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5b41348..7342029 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -617,13 +617,13 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 		cmd, arg, cmd_status);
 }
 
-static void dw_mci_setup_bus(struct dw_mci_slot *slot)
+static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
 	u32 div;
 	u32 clk_en_a;
 
-	if (slot->clock != host->current_speed) {
+	if (slot->clock != host->current_speed || force_clkinit) {
 		div = host->bus_hz / slot->clock;
 		if (host->bus_hz % slot->clock && host->bus_hz > slot->clock)
 			/*
@@ -684,7 +684,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 		host->pdata->select_slot(slot->id);
 
 	/* Slot specific timing and width adjustment */
-	dw_mci_setup_bus(slot);
+	dw_mci_setup_bus(slot, false);
 
 	host->cur_slot = slot;
 	host->mrq = mrq;
@@ -1850,6 +1850,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
 
+	if (host->pdata->pm_caps)
+		mmc->pm_caps = host->pdata->pm_caps;
+
 	if (host->dev->of_node) {
 		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
 		if (ctrl_id < 0)
@@ -2072,6 +2075,12 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(ret);
 	}
 
+	if (of_find_property(np, "keep-power-in-suspend", NULL))
+		pdata->pm_caps |= MMC_PM_KEEP_POWER;
+
+	if (of_find_property(np, "enable-sdio-wakeup", NULL))
+		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+
 	return pdata;
 }
 
@@ -2411,6 +2420,11 @@ int dw_mci_resume(struct dw_mci *host)
 		struct dw_mci_slot *slot = host->slot[i];
 		if (!slot)
 			continue;
+		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
+			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
+			dw_mci_setup_bus(slot, true);
+		}
+
 		ret = mmc_resume_host(host->slot[i]->mmc);
 		if (ret < 0)
 			return ret;
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index a5498dc..34be4f4 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -231,6 +231,7 @@ struct dw_mci_board {
 
 	u32 caps;	/* Capabilities */
 	u32 caps2;	/* More capabilities */
+	u32 pm_caps;	/* PM capabilities */
 	/*
 	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
 	 * but note that this may not be reliable after a bootloader has used
-- 
1.6.6.1

