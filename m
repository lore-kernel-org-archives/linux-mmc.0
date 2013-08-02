From: <dinguyen@altera.com>
Subject: [PATCH] mmc: dw_mmc: Handle the Hardware Locked Write Error(HLE)
Date: Thu, 1 Aug 2013 22:50:44 -0500
Message-ID: <1375415444-23407-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:31147
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753019Ab3HBDvi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 23:51:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, linux-mmc@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@altera.com>, Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <cjb@laptop.org>

From: Dinh Nguyen <dinguyen@altera.com>

The Handle the Hardware Locked Write Error(HLE) was getting triggered
intermittently on the SOCFPGA platform. But since the driver did not
have a mechanism to handle this interrupt, it was stuck in the ISR.

Clear the HLE interrupt when it gets triggered.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/dw_mmc.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ee5f167..ef30bec 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1664,6 +1664,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			queue_work(host->card_workqueue, &host->card_work);
 		}
 
+		if (pending & SDMMC_INT_HLE)
+			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
+
 		/* Handle SDIO Interrupts */
 		for (i = 0; i < host->num_slots; i++) {
 			struct dw_mci_slot *slot = host->slot[i];
-- 
1.7.9.5


