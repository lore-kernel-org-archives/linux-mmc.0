From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] mmc: sdio: reset card during power_restore
Date: Sun,  5 Jun 2011 13:38:52 +0100 (BST)
Message-ID: <20110605123852.BC6F39D401C@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:26860 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756017Ab1FEMi6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2011 08:38:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ohad@wizery.com

mmc_sdio_power_restore() skips some steps that are performed in other
power-related codepaths which are necessary to fully reset the card.
Without this, the card can't be powered up and probe fails.

All these steps are needed, to satisfy the cases of both normal
runtime PM and also suspend/resume situations.

Tested on sd8686 libertas wifi on XO-1.5.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/core/sdio.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8af3330..9170ea2 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -706,10 +706,25 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
+
+	/*
+	 * Reset the card by performing the same steps that are taken by
+	 * mmc_rescan_try_freq() and mmc_attach_sdio() during a "normal" probe
+	 */
+	sdio_reset(host);
+	mmc_go_idle(host);
+	mmc_send_if_cond(host, host->ocr_avail);
+
+	ret = mmc_send_io_op_cond(host, 0, NULL);
+	if (ret)
+		goto out;
+
 	ret = mmc_sdio_init_card(host, host->ocr, host->card,
 				mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
+
+out:
 	mmc_release_host(host);
 
 	return ret;
-- 
1.7.5.2

