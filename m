From: akpm@linux-foundation.org
Subject: [patch 045/177] omap_hsmmc: add init_card pass-through callback
Date: Tue, 10 Aug 2010 18:01:52 -0700
Message-ID: <201008110101.o7B11q3D027081@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34435 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757575Ab0HKBDM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:03:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, notasas@gmail.com, adrian.hunter@nokia.com, kishore.kadiyala@ti.com, kvalo@adurom.com, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, madhu.cr@ti.com, me@bobcopeland.com, tony@atomide.com

From: Grazvydas Ignotas <notasas@gmail.com>

This will allow us to set up special cards in machine drivers just after
they are detected by MMC core.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Bob Copeland <me@bobcopeland.com>
Cc: Kalle Valo <kvalo@adurom.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/plat-omap/include/plat/mmc.h |    2 ++
 drivers/mmc/host/omap_hsmmc.c         |   10 ++++++++++
 2 files changed, 12 insertions(+)

diff -puN arch/arm/plat-omap/include/plat/mmc.h~omap_hsmmc-add-init_card-pass-through-callback arch/arm/plat-omap/include/plat/mmc.h
--- a/arch/arm/plat-omap/include/plat/mmc.h~omap_hsmmc-add-init_card-pass-through-callback
+++ a/arch/arm/plat-omap/include/plat/mmc.h
@@ -122,6 +122,8 @@ struct omap_mmc_platform_data {
 		/* Call back after enabling / disabling regulators */
 		void (*after_set_reg)(struct device *dev, int slot,
 				      int power_on, int vdd);
+		/* if we have special card, init it using this callback */
+		void (*init_card)(struct mmc_card *card);
 
 		/* return MMC cover switch state, can be NULL if not supported.
 		 *
diff -puN drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-add-init_card-pass-through-callback drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-add-init_card-pass-through-callback
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -1598,6 +1598,14 @@ static int omap_hsmmc_get_ro(struct mmc_
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
@@ -1869,6 +1877,7 @@ static const struct mmc_host_ops omap_hs
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
+	.init_card = omap_hsmmc_init_card,
 	/* NYET -- enable_sdio_irq */
 };
 
@@ -1879,6 +1888,7 @@ static const struct mmc_host_ops omap_hs
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
+	.init_card = omap_hsmmc_init_card,
 	/* NYET -- enable_sdio_irq */
 };
 
_
