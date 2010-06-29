From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 2/3] omap_hsmmc: add init_card pass-through callback
Date: Tue, 29 Jun 2010 16:49:24 +0300
Message-ID: <1277819365-2761-3-git-send-email-notasas@gmail.com>
References: <1277819365-2761-1-git-send-email-notasas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34970 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab0F2Ntf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2010 09:49:35 -0400
In-Reply-To: <1277819365-2761-1-git-send-email-notasas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Adrian Hunter <adrian.hunter@nokia.com>, Tony Lindgren <tony@atomide.com>, Bob Copeland <me@bobcopeland.com>, Kalle Valo <kvalo@adurom.com>, Grazvydas Ignotas <notasas@gmail.com>

This will allow us to set up special cards in machine drivers just
after they are detected by MMC core.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/plat-omap/include/plat/mmc.h |    2 ++
 drivers/mmc/host/omap_hsmmc.c         |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index c835f1e..9b89ec6 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -122,6 +122,8 @@ struct omap_mmc_platform_data {
 		/* Call back after enabling / disabling regulators */
 		void (*after_set_reg)(struct device *dev, int slot,
 				      int power_on, int vdd);
+		/* if we have special card, init it using this callback */
+		void (*init_card)(struct mmc_card *card);
 
 		/* return MMC cover switch state, can be NULL if not supported.
 		 *
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b032828..e8eb39e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1598,6 +1598,14 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
 	return mmc_slot(host).get_ro(host->dev, 0);
 }
 
+static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
+
+	if (mmc_slot(host).init_card)
+		mmc_slot(host).init_card(card);
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1869,6 +1877,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
+	.init_card = omap_hsmmc_init_card,
 	/* NYET -- enable_sdio_irq */
 };
 
@@ -1879,6 +1888,7 @@ static const struct mmc_host_ops omap_hsmmc_ps_ops = {
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
+	.init_card = omap_hsmmc_init_card,
 	/* NYET -- enable_sdio_irq */
 };
 
-- 
1.6.3.3

