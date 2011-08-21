From: Alexander Tarasikov <alexander.tarasikov@gmail.com>
Subject: [PATCH 2/2] msm: Implement init_card operation for MSM SDCC
Date: Sun, 21 Aug 2011 15:52:44 +0400
Message-ID: <1313927564-10355-3-git-send-email-alexander.tarasikov@gmail.com>
References: <1313927564-10355-1-git-send-email-alexander.tarasikov@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56197 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab1HULx1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Aug 2011 07:53:27 -0400
In-Reply-To: <1313927564-10355-1-git-send-email-alexander.tarasikov@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, cjb@laptop.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, Alexander Tarasikov <alexander.tarasikov@gmail.com>

This allows boards with non-standard sdio cards to fill the CIS/CCCR data.
It is particularly important for old msm72k boards using wl1251.
Also drop the obsolete embedded_sdio_data structure from the header
as it was intended to surve a similiar purpose but was not implemented.

Signed-off-by: Alexander Tarasikov <alexander.tarasikov@gmail.com>
---
 arch/arm/mach-msm/include/mach/mmc.h |    9 +--------
 drivers/mmc/host/msm_sdcc.c          |    9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/mmc.h b/arch/arm/mach-msm/include/mach/mmc.h
index 5631b51..ffcd9e3 100644
--- a/arch/arm/mach-msm/include/mach/mmc.h
+++ b/arch/arm/mach-msm/include/mach/mmc.h
@@ -8,13 +8,6 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/sdio_func.h>

-struct embedded_sdio_data {
-	struct sdio_cis cis;
-	struct sdio_cccr cccr;
-	struct sdio_embedded_func *funcs;
-	int num_funcs;
-};
-
 struct msm_mmc_gpio {
	unsigned no;
	const char *name;
@@ -29,9 +22,9 @@ struct msm_mmc_platform_data {
	unsigned int ocr_mask;			/* available voltages */
	u32 (*translate_vdd)(struct device *, unsigned int);
	unsigned int (*status)(struct device *);
-	struct embedded_sdio_data *embedded_sdio;
	int (*register_status_notify)(void (*callback)(int card_present, void *dev_id), void *dev_id);
	struct msm_mmc_gpio_data *gpio_data;
+	void (*init_card)(struct mmc_card *card);
 };

 #endif
diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index d06539d..e40d8ec 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1052,10 +1052,19 @@ static void msmsdcc_enable_sdio_irq(struct mmc_host *mmc, int enable)
	spin_unlock_irqrestore(&host->lock, flags);
 }

+static void msmsdcc_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct msmsdcc_host *host = mmc_priv(mmc);
+
+	if (host->plat->init_card)
+		host->plat->init_card(card);
+}
+
 static const struct mmc_host_ops msmsdcc_ops = {
	.request	= msmsdcc_request,
	.set_ios	= msmsdcc_set_ios,
	.enable_sdio_irq = msmsdcc_enable_sdio_irq,
+	.init_card = msmsdcc_init_card,
 };

 static void
--
1.7.5.4
