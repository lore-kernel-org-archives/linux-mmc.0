From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v4 03/10] omap_hsmmc: remove unused fields in platform_data
Date: Sat,  8 Nov 2014 15:33:10 +0100
Message-ID: <1415457197-14294-4-git-send-email-afenkart@gmail.com>
References: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48010 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbaKHOdd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Nov 2014 09:33:33 -0500
In-Reply-To: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

platform data is built from omap2_hsmmc_info, remove all fields that
are never set in omap_hsmmc_info, hence never copied to platform data.
Note that the omap_hsmmc driver is not affected by this patch those
fields were completely unused.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/mach-omap2/hsmmc.c              | 14 --------------
 arch/arm/mach-omap2/hsmmc.h              |  6 ------
 include/linux/platform_data/hsmmc-omap.h | 19 -------------------
 3 files changed, 39 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9edd759..75b75b9 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -263,9 +263,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].name = hc_name;
 	mmc->nr_slots = 1;
 	mmc->slots[0].caps = c->caps;
-	mmc->slots[0].pm_caps = c->pm_caps;
 	mmc->slots[0].internal_clock = !c->ext_clock;
-	mmc->max_freq = c->max_freq;
 	mmc->reg_offset = 0;
 	mmc->get_context_loss_count = hsmmc_get_context_loss;
 
@@ -281,18 +279,6 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	if (c->nonremovable)
 		mmc->slots[0].nonremovable = 1;
 
-	if (c->power_saving)
-		mmc->slots[0].power_saving = 1;
-
-	if (c->no_off)
-		mmc->slots[0].no_off = 1;
-
-	if (c->no_off_init)
-		mmc->slots[0].no_regulator_off_init = c->no_off_init;
-
-	if (c->vcc_aux_disable_is_sleep)
-		mmc->slots[0].vcc_aux_disable_is_sleep = 1;
-
 	/*
 	 * NOTE:  MMC slots should have a Vcc regulator set up.
 	 * This may be from a TWL4030-family chip, another
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 7f2e790..bdc8870 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -12,23 +12,17 @@ struct omap2_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u32	caps;		/* 4/8 wires and any additional host
 				 * capabilities OR'd (ref. linux/mmc/host.h) */
-	u32	pm_caps;	/* PM capabilities */
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
 	bool	cover_only;	/* No card detect - just cover switch */
 	bool	nonremovable;	/* Nonremovable e.g. eMMC */
 	bool	power_saving;	/* Try to sleep or power off when possible */
-	bool	no_off;		/* power_saving and power is not to go off */
-	bool	no_off_init;	/* no power off when not in MMC sleep state */
-	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
 	bool	deferred;	/* mmc needs a deferred probe */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
 	struct platform_device *pdev;	/* mmc controller instance */
 	int	ocr_mask;	/* temporary HACK */
-	int	max_freq;	/* maximum clock, if constrained by external
-				 * circuitry, or 0 for default */
 	/* Remux (pad configuration) when powering on/off */
 	void (*remux)(struct device *dev, int slot, int power_on);
 	/* init some special card */
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 7dd42e5..11d7ed9 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -73,16 +73,9 @@ struct omap_hsmmc_platform_data {
 		 * 4/8 wires and any additional host capabilities
 		 * need to OR'd all capabilities (ref. linux/mmc/host.h)
 		 */
-		u8  wires;	/* Used for the MMC driver on omap1 and 2420 */
 		u32 caps;	/* Used for the MMC driver on 2430 and later */
 		u32 pm_caps;	/* PM capabilities of the mmc */
 
-		/*
-		 * nomux means "standard" muxing is wrong on this board, and
-		 * that board-specific code handled it before common init logic.
-		 */
-		unsigned nomux:1;
-
 		/* switch pin can be for card detect (default) or card cover */
 		unsigned cover:1;
 
@@ -92,18 +85,9 @@ struct omap_hsmmc_platform_data {
 		/* nonremovable e.g. eMMC */
 		unsigned nonremovable:1;
 
-		/* Try to sleep or power off when possible */
-		unsigned power_saving:1;
-
-		/* If using power_saving and the MMC power is not to go off */
-		unsigned no_off:1;
-
 		/* eMMC does not handle power off when not in sleep state */
 		unsigned no_regulator_off_init:1;
 
-		/* Regulator off remapped to sleep */
-		unsigned vcc_aux_disable_is_sleep:1;
-
 		/* we can put the features above into this variable */
 #define HSMMC_HAS_PBIAS		(1 << 0)
 #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
@@ -142,8 +126,5 @@ struct omap_hsmmc_platform_data {
 		int card_detect_irq;
 
 		int (*card_detect)(struct device *dev, int slot);
-
-		unsigned int ban_openended:1;
-
 	} slots[OMAP_HSMMC_MAX_SLOTS];
 };
-- 
2.1.1

