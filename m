From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 1/4] mmc: dw-mmc: relocate the position called
 dw_mci_setup_bus()
Date: Thu, 08 Nov 2012 17:35:29 +0900
Message-ID: <509B6ED1.7030707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:56560 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2KHIfp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Nov 2012 03:35:45 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MD500II1UJGAMI0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 08 Nov 2012 17:35:44 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MD500LVNUJJG180@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 08 Nov 2012 17:35:43 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

To ensure the stable clock need to enable before set the DW_MMC_CARD_NEED_INIT flag.
If set DW_MMC_CARD_NEED_INIT flag, wait for 80-clock before first command after power-up.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Changelog v2-v3:
	- Modified the commit-message
 drivers/mmc/host/dw_mmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
---
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c0667c8..a1369aa 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -683,9 +683,6 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	if (host->pdata->select_slot)
 		host->pdata->select_slot(slot->id);
 
-	/* Slot specific timing and width adjustment */
-	dw_mci_setup_bus(slot);
-
 	host->cur_slot = slot;
 	host->mrq = mrq;
 
@@ -812,6 +809,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (drv_data && drv_data->set_ios)
 		drv_data->set_ios(slot->host, ios);
 
+	/* Slot specific timing and width adjustment */
+	dw_mci_setup_bus(slot);
+
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
-- 
1.7.4.1
