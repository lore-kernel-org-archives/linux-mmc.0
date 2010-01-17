From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 7/10] omap_hsmmc: Allow for power saving without going off
Date: Sun, 17 Jan 2010 03:33:43 +0200
Message-ID: <20100117013343.17308.97040.sendpatchset@ahunter-work.research.nokia.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37161 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab0AQBeR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jan 2010 20:34:17 -0500
In-Reply-To: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

>From 9906604c602bff545e09cd78070c1c26b4ee8855 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Tue, 5 Jan 2010 14:14:07 +0200
Subject: [PATCH] omap_hsmmc: Allow for power saving without going off

An eMMC may be always powered on, so that the lowest
power saving state possible is sleeping. Add a field
to the platform data to indicate that.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/hsmmc.c           |    3 +++
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |    6 ++++++
 4 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 0ac5e4e..7e63296 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -201,6 +201,9 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		if (c->power_saving)
 			mmc->slots[0].power_saving = 1;
 
+		if (c->no_off)
+			mmc->slots[0].no_off = 1;
+
 		/* NOTE:  MMC slots should have a Vcc regulator set up.
 		 * This may be from a TWL4030-family chip, another
 		 * controllable regulator, or a fixed supply.
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index f641f59..2453a7a 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -14,6 +14,7 @@ struct omap2_hsmmc_info {
 	bool	cover_only;	/* No card detect - just cover switch */
 	bool	nonremovable;	/* Nonremovable e.g. eMMC */
 	bool	power_saving;	/* Try to sleep or power off when possible */
+	bool	no_off;		/* power_saving and power is not to go off */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 8b23d32..b463949 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -96,6 +96,9 @@ struct omap_mmc_platform_data {
 		/* Try to sleep or power off when possible */
 		unsigned power_saving:1;
 
+		/* If using power_saving and the MMC power is not to go off */
+		unsigned no_off:1;
+
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2c5e15d..e15d0f4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1656,6 +1656,9 @@ static int omap_hsmmc_disabled_to_sleep(struct omap_hsmmc_host *host)
 	dev_dbg(mmc_dev(host->mmc), "DISABLED -> %s\n",
 		host->dpm_state == CARDSLEEP ? "CARDSLEEP" : "REGSLEEP");
 
+	if (mmc_slot(host).no_off)
+		return 0;
+
 	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
 	    mmc_slot(host).card_detect ||
 	    (mmc_slot(host).get_cover_state &&
@@ -1671,6 +1674,9 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
 	if (!mmc_try_claim_host(host->mmc))
 		return 0;
 
+	if (mmc_slot(host).no_off)
+		return 0;
+
 	if (!((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
 	      mmc_slot(host).card_detect ||
 	      (mmc_slot(host).get_cover_state &&
-- 
1.6.0.4

