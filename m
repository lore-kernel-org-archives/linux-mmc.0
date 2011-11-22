From: Eliad Peller <eliad@wizery.com>
Subject: [PATCH 2/3] omap_hsmmc: add pm_caps field
Date: Tue, 22 Nov 2011 16:02:18 +0200
Message-ID: <1321970539-7104-2-git-send-email-eliad@wizery.com>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1321970539-7104-1-git-send-email-eliad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

Add pm_caps field to omap2_hsmmc_info and omap_mmc_slot_data
structs, so we will be able to indicate mmc pm capabilities
in the board file.

Signed-off-by: Eliad Peller <eliad@wizery.com>
---
 arch/arm/mach-omap2/hsmmc.c           |    1 +
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    1 +
 drivers/mmc/host/omap_hsmmc.c         |    2 ++
 4 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 097a42d..d00a54a 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -306,6 +306,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].name = hc_name;
 	mmc->nr_slots = 1;
 	mmc->slots[0].caps = c->caps;
+	mmc->slots[0].pm_caps = c->pm_caps;
 	mmc->slots[0].internal_clock = !c->ext_clock;
 	mmc->dma_mask = 0xffffffff;
 	if (cpu_is_omap44xx())
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index f757e78..c440973 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -12,6 +12,7 @@ struct omap2_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u32	caps;		/* 4/8 wires and any additional host
 				 * capabilities OR'd (ref. linux/mmc/host.h) */
+	u32	pm_caps;	/* PM capabilities */
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
 	bool	cover_only;	/* No card detect - just cover switch */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index c7b8741..d3263ac 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -79,6 +79,7 @@ struct omap_mmc_platform_data {
 		 */
 		u8  wires;	/* Used for the MMC driver on omap1 and 2420 */
 		u32 caps;	/* Used for the MMC driver on 2430 and later */
+		u32 pm_caps;	/* PM capabilities of the mmc */
 
 		/*
 		 * nomux means "standard" muxing is wrong on this board, and
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ec7c83c..2bc964a6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1985,6 +1985,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (mmc_slot(host).nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
 
+	mmc->pm_caps = mmc_slot(host).pm_caps;
+
 	omap_hsmmc_conf_bus_power(host);
 
 	/* Select DMA lines */
-- 
1.7.6.401.g6a319

