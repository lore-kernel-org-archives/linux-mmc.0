From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] mmc: sdio: reset card during power_restore
Date: Sat, 25 Jun 2011 19:20:11 +0100 (BST)
Message-ID: <20110625182011.7CB8E9D401C@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:48691 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751678Ab1FYSof (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Jun 2011 14:44:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, ohad@wizery.com

mmc_sdio_power_restore() skips some steps that are performed in other
power-related codepaths which are necessary to fully reset the card.
Without this, runtime PM fails for SD8686 SDIO wifi on OLPC XO-1.5.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/core/sdio.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

Replaces existing patch with the same name

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4d0c15b..262fff0 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -691,15 +691,54 @@ static int mmc_sdio_resume(struct mmc_host *host)
 static int mmc_sdio_power_restore(struct mmc_host *host)
 {
 	int ret;
+	u32 ocr;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
+
+	/*
+	 * Reset the card by performing the same steps that are taken by
+	 * mmc_rescan_try_freq() and mmc_attach_sdio() during a "normal" probe.
+	 *
+	 * sdio_reset() is technically not needed. Having just powered up the
+	 * hardware, it should already be in reset state. However, some
+	 * platforms (such as SD8686 on OLPC) do not instantly cut power,
+	 * meaning that a reset is required when restoring power soon after
+	 * powering off. It is harmless in other cases.
+	 *
+	 * The CMD5 reset (mmc_send_io_op_cond()), according to the SDIO spec,
+	 * is not necessary for non-removable cards. However, it is required
+	 * for OLPC SD8686 (which expects a [CMD5,5,3,7] init sequence), and
+	 * harmless in other situations.
+	 *
+	 * With these steps taken, mmc_select_voltage() is also required to
+	 * restore the correct voltage setting of the card.
+	 */
+	sdio_reset(host);
+	mmc_go_idle(host);
+	mmc_send_if_cond(host, host->ocr_avail);
+
+	ret = mmc_send_io_op_cond(host, 0, &ocr);
+	if (ret)
+		goto out;
+
+	if (host->ocr_avail_sdio)
+		host->ocr_avail = host->ocr_avail_sdio;
+
+	host->ocr = mmc_select_voltage(host, ocr & ~0x7F);
+	if (!host->ocr) {
+		ret = -EINVAL;
+		goto out;
+	}
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
1.7.5.4

