From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 09/12] ARM: omap: remove mmc platform data dma_mask and
 initialization
Date: Mon, 23 Apr 2012 17:07:12 +0100
Message-ID: <E1SMLnE-0002Wc-EM@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

DMAengine uses the DMA engine device structure when mapping/unmapping
memory for DMA, so the MMC devices do not need their DMA masks
initialized (this reflects hardware: the MMC device is not the device
doing DMA.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/board-h2-mmc.c    |    1 -
 arch/arm/mach-omap1/board-h3-mmc.c    |    1 -
 arch/arm/mach-omap1/board-nokia770.c  |    1 -
 arch/arm/mach-omap2/board-n8x0.c      |    1 -
 arch/arm/mach-omap2/hsmmc.c           |    1 -
 arch/arm/plat-omap/include/plat/mmc.h |    2 --
 6 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index da0e37d..e1362ce 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -54,7 +54,6 @@ static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
 	.init				= mmc_late_init,
 	.cleanup			= mmc_cleanup,
-	.dma_mask			= 0xffffffff,
 	.slots[0]       = {
 		.set_power              = mmc_set_power,
 		.ocr_mask               = MMC_VDD_32_33 | MMC_VDD_33_34,
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index f8242aa..c74daac 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -36,7 +36,6 @@ static int mmc_set_power(struct device *dev, int slot, int power_on,
  */
 static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
-	.dma_mask			= 0xffffffff,
 	.slots[0]       = {
 		.set_power              = mmc_set_power,
 		.ocr_mask               = MMC_VDD_32_33 | MMC_VDD_33_34,
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index d21dcc2..cac9954 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -185,7 +185,6 @@ static int nokia770_mmc_get_cover_state(struct device *dev, int slot)
 
 static struct omap_mmc_platform_data nokia770_mmc2_data = {
 	.nr_slots                       = 1,
-	.dma_mask			= 0xffffffff,
 	.max_freq                       = 12000000,
 	.slots[0]       = {
 		.set_power		= nokia770_mmc_set_power,
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 518091c..1003748 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -470,7 +470,6 @@ static struct omap_mmc_platform_data mmc1_data = {
 	.cleanup			= n8x0_mmc_cleanup,
 	.shutdown			= n8x0_mmc_shutdown,
 	.max_freq			= 24000000,
-	.dma_mask			= 0xffffffff,
 	.slots[0] = {
 		.wires			= 4,
 		.set_power		= n8x0_mmc_set_power,
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b0268ea..41e5277 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -315,7 +315,6 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].caps = c->caps;
 	mmc->slots[0].pm_caps = c->pm_caps;
 	mmc->slots[0].internal_clock = !c->ext_clock;
-	mmc->dma_mask = 0xffffffff;
 	mmc->max_freq = c->max_freq;
 	if (cpu_is_omap44xx())
 		mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 7a38750..9fe87a7 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -80,8 +80,6 @@ struct omap_mmc_platform_data {
 	/* Return context loss count due to PM states changing */
 	int (*get_context_loss_count)(struct device *dev);
 
-	u64 dma_mask;
-
 	/* Integrating attributes from the omap_hwmod layer */
 	u8 controller_flags;
 
-- 
1.7.4.4

