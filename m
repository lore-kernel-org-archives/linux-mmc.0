From: Viswanath Puttagunta <vishp@ti.com>
Subject: [PATCH 2/3] mmc: omap_hsmmc: Errata: Fix SD card removal detection
Date: Thu, 24 May 2012 15:14:26 -0500
Message-ID: <1337890467-32573-3-git-send-email-vishp@ti.com>
References: <1337890467-32573-1-git-send-email-vishp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59555 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758601Ab2EXUOc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 16:14:32 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4OKEVwL007506
	for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 15:14:31 -0500
Received: from DFLE70.ent.ti.com (dfle70.ent.ti.com [128.247.5.40])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4OKEVMI010813
	for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 15:14:31 -0500
In-Reply-To: <1337890467-32573-1-git-send-email-vishp@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux-mmc <linux-mmc@vger.kernel.org>
Cc: T Krishnamoorthy Balaji <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, Volodymyr Riazantsev <v.riazantsev@ti.com>, Viswanath Puttagunta <vishp@ti.com>

Because of OMAP4 Silicon errata (i705), we have to turn off the
PBIAS and VMMC for SD card as soon as we get card disconnect
interrupt. Because of this, we don't wait for all higher layer
structures to be dismantled before turning off power. As a side
effect of this, we might end up getting a mmc_request
even after SD is removed and VMMC and PBIAS are turned off.
In that case, just fail the mmc_request and return immediately

Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
Signed-off-by: Semen Protsenko <semen.protsenko@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 61d830f..49a1a03 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1180,12 +1180,20 @@ static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 	if (carddetect) {
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
 	} else {
+	/*
+	 * Because of OMAP4 Silicon errata (i705), we have to turn off the
+	 * PBIAS and VMMC for SD card as soon as we get card disconnect
+	 * interrupt. Because of this, we don't wait for all higher layer
+	 * structures to be dismantled before turning off power
+	 */
+		mmc_claim_host(host->mmc);
 		if ((MMC_POWER_OFF != host->power_mode) &&
 				(mmc_slot(host).set_power != NULL)) {
 			mmc_slot(host).set_power(host->dev, host->slot_id,
 						0, 0);
 			host->power_mode = MMC_POWER_OFF;
 		}
+		mmc_release_host(host->mmc);
 		mmc_detect_change(host->mmc, 0);
 	}
 	return IRQ_HANDLED;
@@ -1500,6 +1508,26 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	} else if (host->reqs_blocked)
 		host->reqs_blocked = 0;
 	WARN_ON(host->mrq != NULL);
+
+	/*
+	 * Because of OMAP4 Silicon errata (i705), we have to turn off the
+	 * PBIAS and VMMC for SD card as soon as we get card disconnect
+	 * interrupt. Because of this, we don't wait for all higher layer
+	 * structures to be dismantled before turning off power. Because
+	 * of this, we might end up here even after SD card is removed
+	 * and VMMC and PBIAS are turned off. In that case, just fail
+	 * the commands immediately
+	 */
+	if (host->power_mode == MMC_POWER_OFF) {
+		req->cmd->error = EIO;
+		if (req->data)
+			req->data->error = -EIO;
+		dev_warn(mmc_dev(host->mmc),
+			"Card is no longer present\n");
+		mmc_request_done(mmc, req);
+		return;
+	}
+
 	host->mrq = req;
 	err = omap_hsmmc_prepare_data(host, req);
 	if (err) {
-- 
1.7.4.1

