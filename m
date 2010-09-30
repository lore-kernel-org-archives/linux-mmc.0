From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Keep nwires for omap1 and 2420 MMC controller (Re:
 [PATCH] omap mmc: extended to pass host capabilities from board file)
Date: Thu, 30 Sep 2010 11:38:19 -0700
Message-ID: <20100930183818.GK3117@atomide.com>
References: <1284562163-2828-1-git-send-email-s-ghorai@ti.com>
 <20100923230819.GS4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100923230819.GS4211@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [100923 16:00]:
> * Sukumar Ghorai <s-ghorai@ti.com> [100915 07:41]:
> >   wires variable is renamed, extended and this single variable to be used to
> >   pass the platform capabilities, e.g DDR mode. Also removed the hardcoded
> >   value was using as bus-width.
> 
> This looks like a nice clean-up, I'll queue this via the omap
> patches.

And of course this patch breaks all of mach-omap1 and omap2420.

Sukumar, your patch modified also drivers/mmc/host/omap.c and board-n8x0.c
to use caps instead of nwires. When you do things like that you absolutely
_must_test_your_changes_ before sending out any patches.

Planning on merging the following fix.

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 30 Sep 2010 10:25:46 -0700
Subject: [PATCH] Subject: [PATCH] omap: Keep nwires for omap1 and 2420 MMC controller

A patch from Sukumar Ghorai <s-ghorai@ti.com> changed the
nwires to use caps instead. However, nwires is still
needed for the earlier controller.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index abd7e77..6bd9d9a 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -488,7 +488,7 @@ static struct omap_mmc_platform_data mmc1_data = {
 	.max_freq			= 24000000,
 	.dma_mask			= 0xffffffff,
 	.slots[0] = {
-		.caps			= MMC_CAP_4_BIT_DATA,
+		.wires			= 4,
 		.set_power		= n8x0_mmc_set_power,
 		.set_bus_mode		= n8x0_mmc_set_bus_mode,
 		.get_cover_state	= n8x0_mmc_get_cover_state,
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 4f819fc..bc85010 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -73,9 +73,16 @@ struct omap_mmc_platform_data {
 
 	struct omap_mmc_slot_data {
 
-		/* 4/8 wires and any additional host capabilities
-		 * need to OR'd all capabilities (ref. linux/mmc/host.h) */
-		u32 caps;
+		/*
+		 * 4/8 wires and any additional host capabilities
+		 * need to OR'd all capabilities (ref. linux/mmc/host.h)
+		 */
+#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2420)
+		u8  wires;	/* Used for the MMC driver on omap1 and 2420 */
+#endif
+#ifdef CONFIG_ARCH_OMAP2PLUS
+		u32 caps;	/* Used for the MMC driver on 2430 and later */
+#endif
 
 		/*
 		 * nomux means "standard" muxing is wrong on this board, and
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index a9d62cf..d98ddcf 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1317,7 +1317,7 @@ static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	host->slots[id] = slot;
 
 	mmc->caps = 0;
-	if (host->pdata->slots[id].caps & MMC_CAP_8_BIT_DATA)
+	if (host->pdata->slots[id].wires >= 4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
 	mmc->ops = &mmc_omap_ops;
