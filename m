From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 2/2] mmc: dw_mmc: make sure of clearing HLE interrupt
Date: Wed, 28 Nov 2012 19:26:58 +0900
Message-ID: <001c01cdcd52$e58a2260$b09e6720$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11934 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572Ab2K1K07 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Nov 2012 05:26:59 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0ME700GKP10UL2Y0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 28 Nov 2012 19:26:58 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0ME7007PX10YOCA0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 28 Nov 2012 19:26:58 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Even though HLE interrupt is enabled, there is no touch.
This patch clears HLE interrupt which is not unhandled.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6785d62..b6db0ae 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1009,6 +1009,11 @@ static void dw_mci_tasklet_func(unsigned long priv)
 	state = host->state;
 	data = host->data;
 
+	if (host->cmd_status & SDMMC_INT_HLE) {
+		dev_err(host->dev, "hardware locked write error\n");
+		goto unlock;
+	}
+
 	do {
 		prev_state = state;
 
@@ -1577,6 +1582,12 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		if (!pending)
 			break;
 
+		if (pending & SDMMC_INT_HLE) {
+			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
+			host->cmd_status = pending;
+			tasklet_schedule(&host->tasklet);
+		}
+
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
 			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
 			host->cmd_status = pending;
-- 
1.7.0.4


