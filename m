From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 8/8] omap_hsmmc: allow for a shared VccQ
Date: Wed, 13 Jan 2010 13:41:09 +0200
Message-ID: <20100113114109.7615.56900.sendpatchset@ahunter-work.research.nokia.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21108 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab0AMLlY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2010 06:41:24 -0500
In-Reply-To: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

>From e9f84e6199b09525bef9daf4673ea2b56c4c7151 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Thu, 7 Jan 2010 13:54:45 +0200
Subject: [PATCH] omap_hsmmc: allow for a shared VccQ

EMMC can have two voltage supplies, Vcc and VccQ
which are implemented in the code as consumer
supplies vmmc and vmmc_aux.

If the regulator that supplies vmmc_aux is shared
with other consumers, then sending it to sleep
will disrupt those consumers.  However, the
TWL4030-family regulators may have OFF remapped
to SLEEP, in which case 'regulator_disable()'
will put the regulator to sleep only when all
consumers are disabled - which is the desired
behaviour.

This patch adds a platform data field to allow
that option.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/hsmmc.c           |    3 +++
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |    6 +++++-
 4 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 457ac48..bd8d19b 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -95,6 +95,9 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		if (c->no_off)
 			mmc->slots[0].no_off = 1;
 
+		if (c->vcc_aux_disable_is_sleep)
+			mmc->slots[0].vcc_aux_disable_is_sleep = 1;
+
 		/* NOTE:  MMC slots should have a Vcc regulator set up.
 		 * This may be from a TWL4030-family chip, another
 		 * controllable regulator, or a fixed supply.
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 1887e4b..88e4459 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -15,6 +15,7 @@ struct omap2_hsmmc_info {
 	bool	nonremovable;	/* Nonremovable e.g. eMMC */
 	bool	power_saving;	/* Try to sleep or power off when possible */
 	bool	no_off;		/* power_saving and power is not to go off */
+	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index b6cd39c..865644b 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -102,6 +102,9 @@ struct omap_mmc_platform_data {
 		/* If using power_saving and the MMC power is not to go off */
 		unsigned no_off:1;
 
+		/* Regulator off remapped to sleep */
+		unsigned vcc_aux_disable_is_sleep:1;
+
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 677be61..2b09659 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -425,7 +425,11 @@ static int omap_hsmmc_23_set_sleep(struct device *dev, int slot, int sleep,
 		err = regulator_set_mode(host->vcc, mode);
 	if (err)
 		return err;
-	return regulator_set_mode(host->vcc_aux, mode);
+
+	if (mmc_slot(host).vcc_aux_disable_is_sleep)
+		return regulator_disable(host->vcc_aux);
+	else
+		return regulator_set_mode(host->vcc_aux, mode);
 }
 
 static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
-- 
1.6.0.4

