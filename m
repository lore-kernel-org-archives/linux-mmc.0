From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 16/30] omap_hsmmc: make use of new MMC_CAP_NONREMOVABLE host capability
Date: Wed, 09 Sep 2009 14:58:33 +0300
Message-ID: <20090909115833.12833.93842.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>
List-Id: linux-mmc@vger.kernel.org

>From 4344e2509599b187ff98b5ad8ea0f8dede2d9374 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 11 May 2009 10:06:38 +0300
Subject: [PATCH] omap_hsmmc: make use of new MMC_CAP_NONREMOVABLE host capability

Let the board specify that a card is nonremovable e.g. eMMC

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c     |    3 +++
 arch/arm/mach-omap2/mmc-twl4030.h     |    1 +
 arch/arm/plat-omap/include/mach/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |    3 +++
 4 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 30d0286..56f07f2 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -415,6 +415,9 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 		} else
 			mmc->slots[0].gpio_wp = -EINVAL;
 
+		if (c->nonremovable)
+			mmc->slots[0].nonremovable = 1;
+
 		/* NOTE:  MMC slots should have a Vcc regulator set up.
 		 * This may be from a TWL4030-family chip, another
 		 * controllable regulator, or a fixed supply.
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index 3807c45..75b0c64 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -12,6 +12,7 @@ struct twl4030_hsmmc_info {
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
 	bool	cover_only;	/* No card detect - just cover switch */
+	bool	nonremovable;	/* Nonremovable e.g. eMMC */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 2f7cf31..bab486c 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -83,6 +83,9 @@ struct omap_mmc_platform_data {
 		/* use the internal clock */
 		unsigned internal_clock:1;
 
+		/* nonremovable e.g. eMMC */
+		unsigned nonremovable:1;
+
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index df13a54..ed35b0d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1383,6 +1383,9 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	else if (pdata->slots[host->slot_id].wires >= 4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
+	if (pdata->slots[host->slot_id].nonremovable)
+		mmc->caps |= MMC_CAP_NONREMOVABLE;
+
 	omap_hsmmc_init(host);
 
 	/* Select DMA lines */
-- 
1.5.6.3

