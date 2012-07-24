From: <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: not busy flag has also to be used for read operations
Date: Tue, 24 Jul 2012 11:42:04 +0200
Message-ID: <1343122924-7799-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:32824 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2GXJmu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jul 2012 05:42:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Even if the datasheet says that the not busy flag has to be used only for
write operations, it's false excepted for version lesser than v2xx.
Not waiting the not busy flag for read operations can cause the controller to
hang-up during the initialization of some SD cards.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: stable@vger.kernel.org


Hello,

This is a fix for 3.5 and later.

Due to the big changes into atmel-mci driver to support all atmel mci versions,
a bug was introduced.
With some SD cards (mainly micro) when using DMA, the controller hangs-up after
the first CMD6 command because the next command is sent too early.

Regards

Ludovic


---
 drivers/mmc/host/atmel-mci.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index f2c115e..b6abfa7 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -81,6 +81,7 @@ struct atmel_mci_caps {
 	bool	has_bad_data_ordering;
 	bool	need_reset_after_xfer;
 	bool	need_blksz_mul_4;
+	bool	need_notbusy_for_read_ops;
 };
 
 struct atmel_mci_dma {
@@ -1619,7 +1620,8 @@ static void atmci_tasklet_func(unsigned long priv)
 				__func__);
 			atmci_set_completed(host, EVENT_XFER_COMPLETE);
 
-			if (host->data->flags & MMC_DATA_WRITE) {
+			if (host->caps.need_notbusy_for_read_ops
+			    || (host->data->flags & MMC_DATA_WRITE)) {
 				atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 				state = STATE_WAITING_NOTBUSY;
 			} else if (host->mrq->stop) {
@@ -2212,6 +2214,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 	host->caps.has_bad_data_ordering = 1;
 	host->caps.need_reset_after_xfer = 1;
 	host->caps.need_blksz_mul_4 = 1;
+	host->caps.need_notbusy_for_read_ops = 0;
 
 	/* keep only major version number */
 	switch (version & 0xf00) {
@@ -2232,6 +2235,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 	case 0x200:
 		host->caps.has_rwproof = 1;
 		host->caps.need_blksz_mul_4 = 0;
+		host->caps.need_notbusy_for_read_ops = 1;
 	case 0x100:
 		host->caps.has_bad_data_ordering = 0;
 		host->caps.need_reset_after_xfer = 0;
-- 
1.7.5.4
