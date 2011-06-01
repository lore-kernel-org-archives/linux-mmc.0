From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 2/2] ARM: OMAP4: MMC: no regulator off during probe for eMMC
Date: Wed, 1 Jun 2011 16:45:23 +0530
Message-ID: <1306926923-3398-3-git-send-email-balajitk@ti.com>
References: <1306926923-3398-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58165 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758731Ab1FALRP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Jun 2011 07:17:15 -0400
In-Reply-To: <1306926923-3398-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, cjb@laptop.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com, Balaji T K <balajitk@ti.com>

eMMC does not handle power off when not in sleep state,
Skip regulator disable during probe when eMMC is
not in known state - state left by bootloader.

Resolves eMMC failure on OMAP4
mmc0: error -110 whilst initialising MMC card

Signed-off-by: Balaji T K <balajitk@ti.com>
Tested-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>
Acked-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c   |    1 +
 arch/arm/mach-omap2/hsmmc.c           |    3 +++
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |    3 +++
 5 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 73fa90b..b324605 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -322,6 +322,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.nonremovable   = true,
 		.ocr_mask	= MMC_VDD_29_30,
+		.no_off_init	= true,
 	},
 	{
 		.mmc		= 1,
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 24f25c7..66868c5 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -338,6 +338,9 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	if (c->no_off)
 		mmc->slots[0].no_off = 1;
 
+	if (c->no_off_init)
+		mmc->slots[0].no_regulator_off_init = c->no_off_init;
+
 	if (c->vcc_aux_disable_is_sleep)
 		mmc->slots[0].vcc_aux_disable_is_sleep = 1;
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index f119348..f757e78 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -18,6 +18,7 @@ struct omap2_hsmmc_info {
 	bool	nonremovable;	/* Nonremovable e.g. eMMC */
 	bool	power_saving;	/* Try to sleep or power off when possible */
 	bool	no_off;		/* power_saving and power is not to go off */
+	bool	no_off_init;	/* no power off when not in MMC sleep state */
 	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index f38fef9..c7b8741 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -101,6 +101,9 @@ struct omap_mmc_platform_data {
 		/* If using power_saving and the MMC power is not to go off */
 		unsigned no_off:1;
 
+		/* eMMC does not handle power off when not in sleep state */
+		unsigned no_regulator_off_init:1;
+
 		/* Regulator off remapped to sleep */
 		unsigned vcc_aux_disable_is_sleep:1;
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 259ece0..5b2e215 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -435,6 +435,9 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 		reg = regulator_get(host->dev, "vmmc_aux");
 		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
 
+		/* For eMMC do not power off when not in sleep state */
+		if (mmc_slot(host).no_regulator_off_init)
+			return 0;
 		/*
 		* UGLY HACK:  workaround regulator framework bugs.
 		* When the bootloader leaves a supply active, it's
-- 
1.7.0.4

