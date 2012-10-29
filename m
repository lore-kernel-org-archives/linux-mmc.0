From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2] mmc: dw-mmc: relocate the position called dw_mci_setup_bus()
Date: Mon, 29 Oct 2012 14:19:36 +0900
Message-ID: <508E11E8.2040609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59848 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab2J2FTw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 01:19:52 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCN000WV2SJF160@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 29 Oct 2012 14:19:38 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MCN001Q42SPGT70@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 29 Oct 2012 14:19:37 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

After power-on, must be ensured at least 74~80 clocks before sending any first command.
To ensure, it's good that dw_mci_setup_bus() is located at dw_mci_set_ios
instead of __dw_mci_start_request()

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
------
Changelog V2:
	- Modified the commit-message.
---
 drivers/mmc/host/dw_mmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4b2bedc..de79093 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -682,9 +682,6 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	if (host->pdata->select_slot)
 		host->pdata->select_slot(slot->id);
 
-	/* Slot specific timing and width adjustment */
-	dw_mci_setup_bus(slot);
-
 	host->cur_slot = slot;
 	host->mrq = mrq;
 
@@ -810,6 +807,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (slot->host->drv_data->set_ios)
 		slot->host->drv_data->set_ios(slot->host, ios);
 
+	/* Slot specific timing and width adjustment */
+	dw_mci_setup_bus(slot);
+
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
-- 
1.7.4.1
