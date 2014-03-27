From: <dinguyen@altera.com>
Subject: [PATCH] mmc: dw_mmc: fix status error for Kingston brand SD cards
Date: Thu, 27 Mar 2014 17:00:22 -0500
Message-ID: <1395957622-3428-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0136.outbound.protection.outlook.com ([157.56.110.136]:8981
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757228AbaC0WRI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Mar 2014 18:17:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tgih.jun@samsung.com, jh80.chung@samsung.com
Cc: dinh.linux@gmail.com, linux-mmc@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

commits [90c2143a8f mmc: dw_mmc: guarantee stop-abort cmd in data errors]
and [e352c813110 mmc: dw_mmc: rework the code related to cmd/data completion]
cause the SD/MMC DMA interface to stop working on Kingston brand SD cards.

---
Hi Seungwon,

I am seeing this error on v3.13 kernel of the dw_mmc driver:

mmc0: problem reading SD Status register.
mmc0: error -110 whilst initialising SD card

I only see this error on a Kingston brand card, although I have heard reports
that it also fails a Samsung card. Also it only fails when with
CONFIG_MMC_DW_IDMAC=y.

The patch below seems to fix it for me. Any chance you have seen this error?

Dinh
---
 drivers/mmc/host/dw_mmc.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7833002..7dcaa30 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1312,7 +1312,8 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
 				dw_mci_stop_dma(host);
-				send_stop_abort(host, data);
+				if (data->stop)
+					send_stop_abort(host, data);
 				state = STATE_DATA_ERROR;
 				break;
 			}
@@ -1334,6 +1335,11 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
 			err = dw_mci_data_complete(host, data);
 
+			if (!data->stop) {
+				dw_mci_request_end(host, host->mrq);
+				goto unlock;
+			}
+
 			if (!err) {
 				if (!data->stop || mrq->sbc) {
 					if (mrq->sbc)
-- 
1.7.9.5

