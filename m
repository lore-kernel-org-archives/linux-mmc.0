From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09.5/16] mmc: omap: Remove cpu_is_omap usage from the
 driver
Date: Fri, 5 Oct 2012 12:47:37 -0700
Message-ID: <20121005194737.GP3874@atomide.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220454.26676.10131.stgit@muffinssi.local>
 <20121005180840.GN3874@atomide.com>
 <87ipaog4mp.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87ipaog4mp.fsf@octavius.laptop.org>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

* Chris Ball <cjb@laptop.org> [121005 11:24]:
> Hi Tony,
> 
> On Fri, Oct 05 2012, Tony Lindgren wrote:
> > This is needed for the ARM common zImage support.
> >
> > We can use the existing slot features to pass omap1
> > specific options to the driver. For omap2 we don't
> > want to pass anything new as that will be eventually
> > moved to use device tree based init.
> >
> > Note that this patch depends on earlier patch that
> > moves plat/mmc.h into include/linux/platform_data.
> >
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Venkatraman S <svenkatr@ti.com>
> > Cc: linux-mmc@vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >
> > ---
> >
> > Chris, I can set up a minimal immutable branch with omap
> > header changes that you can also pull into MMC tree if these
> > two MMC patches look ackable to you.
> 
> Thanks, sounds good.
> 
> Acked-by: Chris Ball <cjb@laptop.org>

Thanks will do when -rc1 is available.

Looks like I posted a version before running stg refresh
that was missing two compile fixes: MMC_OMAP7XXX should be
MMC_OMAP7XX and !mmc_omap1 should be !mmc_omap1().
Updated patch below.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 4 Oct 2012 19:01:53 -0700
Subject: [PATCH] mmc: omap: Remove cpu_is_omap usage from the driver

This is needed for the ARM common zImage support.

We can use the existing slot features to pass omap1
specific options to the driver. For omap2 we don't
want to pass anything new as that will be eventually
moved to use device tree based init.

Note that this patch depends on earlier patch that
moves plat/mmc.h into include/linux/platform_data.

Cc: linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>
Acked-by: Chris Ball <cjb@laptop.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 1cc4e18..f9c4fb9 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -177,6 +177,13 @@ static int __init omap_mmc_add(const char *name, int id, unsigned long base,
 	res[3].name = "tx";
 	res[3].flags = IORESOURCE_DMA;
 
+	if (cpu_is_omap7xx())
+		data->slots[0].features = MMC_OMAP7XX;
+	if (cpu_is_omap15xx())
+		data->slots[0].features = MMC_OMAP15XX;
+	if (cpu_is_omap16xx())
+		data->slots[0].features = MMC_OMAP16XX;
+
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret == 0)
 		ret = platform_device_add_data(pdev, data, sizeof(*data));
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index e7c61b9..9f0e26f 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -30,7 +30,6 @@
 #include <linux/slab.h>
 #include <linux/platform_data/mmc-omap.h>
 
-#include <plat/cpu.h>
 #include <plat/dma.h>
 
 #define	OMAP_MMC_REG_CMD	0x00
@@ -73,6 +72,13 @@
 #define	OMAP_MMC_STAT_CARD_BUSY		(1 <<  2)
 #define	OMAP_MMC_STAT_END_OF_CMD	(1 <<  0)
 
+#define mmc_omap7xx()	(host->features & MMC_OMAP7XX)
+#define mmc_omap15xx()	(host->features & MMC_OMAP15XX)
+#define mmc_omap16xx()	(host->features & MMC_OMAP16XX)
+#define MMC_OMAP1_MASK	(MMC_OMAP7XX | MMC_OMAP15XX | MMC_OMAP16XX)
+#define mmc_omap1()	(host->features & MMC_OMAP1_MASK)
+#define mmc_omap2()	(!mmc_omap1())
+
 #define OMAP_MMC_REG(host, reg)		(OMAP_MMC_REG_##reg << (host)->reg_shift)
 #define OMAP_MMC_READ(host, reg)	__raw_readw((host)->virt_base + OMAP_MMC_REG(host, reg))
 #define OMAP_MMC_WRITE(host, reg, val)	__raw_writew((val), (host)->virt_base + OMAP_MMC_REG(host, reg))
@@ -148,6 +154,7 @@ struct mmc_omap_host {
 	u32			buffer_bytes_left;
 	u32			total_bytes_left;
 
+	unsigned		features;
 	unsigned		use_dma:1;
 	unsigned		brs_received:1, dma_done:1;
 	unsigned		dma_in_use:1;
@@ -989,7 +996,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 		 * blocksize is at least that large. Blocksize is
 		 * usually 512 bytes; but not for some SD reads.
 		 */
-		burst = cpu_is_omap15xx() ? 32 : 64;
+		burst = mmc_omap15xx() ? 32 : 64;
 		if (burst > data->blksz)
 			burst = data->blksz;
 
@@ -1105,8 +1112,7 @@ static void mmc_omap_set_power(struct mmc_omap_slot *slot, int power_on,
 	if (slot->pdata->set_power != NULL)
 		slot->pdata->set_power(mmc_dev(slot->mmc), slot->id, power_on,
 					vdd);
-
-	if (cpu_is_omap24xx()) {
+	if (mmc_omap2()) {
 		u16 w;
 
 		if (power_on) {
@@ -1240,7 +1246,7 @@ static int __devinit mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	mmc->ops = &mmc_omap_ops;
 	mmc->f_min = 400000;
 
-	if (cpu_class_is_omap2())
+	if (mmc_omap2())
 		mmc->f_max = 48000000;
 	else
 		mmc->f_max = 24000000;
@@ -1360,6 +1366,7 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 	init_waitqueue_head(&host->slot_wq);
 
 	host->pdata = pdata;
+	host->features = host->pdata->slots[0].features;
 	host->dev = &pdev->dev;
 	platform_set_drvdata(pdev, host);
 
@@ -1392,7 +1399,7 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 	host->dma_tx_burst = -1;
 	host->dma_rx_burst = -1;
 
-	if (cpu_is_omap24xx())
+	if (mmc_omap2())
 		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX : OMAP24XX_DMA_MMC2_TX;
 	else
 		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
@@ -1408,7 +1415,7 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
 			sig);
 #endif
-	if (cpu_is_omap24xx())
+	if (mmc_omap2())
 		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX : OMAP24XX_DMA_MMC2_RX;
 	else
 		sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
@@ -1436,7 +1443,7 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 	}
 
 	host->nr_slots = pdata->nr_slots;
-	host->reg_shift = (cpu_is_omap7xx() ? 1 : 2);
+	host->reg_shift = (mmc_omap7xx() ? 1 : 2);
 
 	host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
 	if (!host->mmc_omap_wq)
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 39a7abc..2bf6ea82 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -107,6 +107,9 @@ struct omap_mmc_platform_data {
 		/* we can put the features above into this variable */
 #define HSMMC_HAS_PBIAS		(1 << 0)
 #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
+#define MMC_OMAP7XX		(1 << 2)
+#define MMC_OMAP15XX		(1 << 3)
+#define MMC_OMAP16XX		(1 << 4)
 		unsigned features;
 
 		int switch_pin;			/* gpio (card detect) */
