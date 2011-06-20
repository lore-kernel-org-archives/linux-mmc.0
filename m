From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: dw_mmc: protect a sequence of request and request-done.
Date: Mon, 20 Jun 2011 17:24:16 +0900
Message-ID: <1308558256-20824-1-git-send-email-tgih.jun@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:57863 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab1FTIbX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 04:31:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, cjb@laptop.org, kgene.kim@samsung.com, Seungwon Jeon <tgih.jun@samsung.com>

Response timeout(RTO), Response crc error(RCRC) and Response error(RE)
signals come with command done(CD) and can be raised preceding command
done(CD). That is these error interrupts and CD can be handled in
separate dw_mci_interrupt(). If mmc_request_done() is called because of
response timeout before command done is occured, next request can be
sent, but CD of current request is not finished. This can bring about
a broken sequence of request and request-done.

And Data error interrupt(DRTO, DCRC, SBE, EBE) and data transfer
over(DTO) are same reanson.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ca830c..22be372 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1202,7 +1202,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			host->cmd_status = status;
 			smp_wmb();
 			set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
-			tasklet_schedule(&host->tasklet);
 		}
 
 		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
@@ -1211,7 +1210,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			host->data_status = status;
 			smp_wmb();
 			set_bit(EVENT_DATA_ERROR, &host->pending_events);
-			tasklet_schedule(&host->tasklet);
+			if (!(pending & (SDMMC_INT_DTO | SDMMC_INT_DCRC |
+					 SDMMC_INT_SBE | SDMMC_INT_EBE)))
+				tasklet_schedule(&host->tasklet);
 		}
 
 		if (pending & SDMMC_INT_DATA_OVER) {
-- 
1.7.1

