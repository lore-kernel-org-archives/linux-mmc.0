From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Wed, 18 Apr 2012 18:39:14 -0700
Message-ID: <20120419013914.GV21106@atomide.com>
References: <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
 <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
 <20120418152956.GP25053@n2100.arm.linux.org.uk>
 <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
 <20120418194224.GS25053@n2100.arm.linux.org.uk>
 <20120418200214.GP21106@atomide.com>
 <20120418202447.GT25053@n2100.arm.linux.org.uk>
 <20120418210142.GR21106@atomide.com>
 <20120418211606.GU25053@n2100.arm.linux.org.uk>
 <20120418213642.GV25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36611 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab2DSBjS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 21:39:18 -0400
Content-Disposition: inline
In-Reply-To: <20120418213642.GV25053@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120418 14:40]:
> On Wed, Apr 18, 2012 at 10:16:06PM +0100, Russell King - ARM Linux wrote:
> > I don't think it has to in this case, though I am thinking that we
> > may have to adjust the frame size for other peripherals.
> > 
> > In the case of the OMAP1 MMC driver, let me pull out that chunk of code
> > again:
> > 
> >         frame = data->blksz;
> >         if (cpu_is_omap15xx() && frame > 32)
> >                 frame = 32;
> >         else if (frame > 64)
> >                 frame = 64;
> >         frame >>= 1;
> >         if (!(data->flags & MMC_DATA_WRITE)) {
> >                 buf = 0x800f | ((frame - 1) << 8);
> >         } else {
> >                 buf = 0x0f80 | ((frame - 1) << 0);
> >         }
> >         OMAP_MMC_WRITE(host, BUF, buf);
> > 
> > Nothing there depends on the size of an individual scatterlist entry -
> > the dependencies for the frame size are the smaller of the FIFO size
> > and the data block size.  I believe we can cope with that quite well on
> > a per-transfer basis, and I _think_ we can get away with writing this
> > BUF register just once per transfer (similar to what happens for PIO
> > transfers.)
> > 
> > However, this is going to be rather hit and miss for me - all I can do
> > is create a patch and check that it builds.  I have no way (that I know
> > of) to test this change as I don't have any OMAP1 nor OMAP2 hardware.
> 
> Right, so from a purely theoretical standpoint, here's the OMAP1 driver
> converted, and build-tested only.  Modulo a few warnings and patch 8,
> you should be able to convert between DMA engine and the original DMA
> engine implementation by changing the definition at the top.
> 
> I have to stress: this is untested, it may eat your MMC/SD cards.  Test
> it carefully and test it well.

Cool, you almost got it. Got it working for n800 and 770 with the following
patch. Only extremely light testing done now so careful with this patch too..

Had to hack in support for the src_port and dst_port that's needed for
omap_set_dma_src/dest_params on omap1. For that I just used existing
struct omap_dma_channel_params to pass src_port and dst_port to
omap_dma_filter_fn. Got any better ideas for doing that?

Regards,

Tony


diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index dc562a5..1f65d8e 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -401,6 +401,8 @@ struct omap_dma_channel_params {
 	unsigned char read_prio;/* read priority */
 	unsigned char write_prio;/* write priority */
 
+	unsigned dma_sig;
+
 #ifndef CONFIG_ARCH_OMAP1
 	enum omap_dma_burst_mode burst_mode; /* Burst mode 4/8/16 words */
 #endif
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 5b12f74..b2f8c62 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -36,6 +36,9 @@ struct omap_chan {
 	int dma_ch;
 	struct omap_desc *desc;
 	unsigned sgidx;
+
+	uint8_t src_port;	/* OMAP_DMA_PORT_xxx, omap1 only */
+	uint8_t dst_port;	/* OMAP_DMA_PORT_xxx, omap1 only */
 };
 
 struct omap_sg {
@@ -83,10 +86,10 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
 	struct omap_sg *sg = d->sg + idx;
 
 	if (d->dir == DMA_DEV_TO_MEM)
-		omap_set_dma_dest_params(c->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
+		omap_set_dma_dest_params(c->dma_ch, c->dst_port, OMAP_DMA_AMODE_POST_INC,
 				sg->addr, 0, 0);
 	else
-		omap_set_dma_src_params(c->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
+		omap_set_dma_src_params(c->dma_ch, c->src_port, OMAP_DMA_AMODE_POST_INC,
 				sg->addr, 0, 0);
 
 	omap_set_dma_transfer_params(c->dma_ch, d->es, sg->en, sg->fn,
@@ -111,10 +114,10 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	c->sgidx = 0;
 
 	if (d->dir == DMA_DEV_TO_MEM)
-		omap_set_dma_src_params(c->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
+		omap_set_dma_src_params(c->dma_ch, c->src_port, OMAP_DMA_AMODE_CONSTANT,
 			d->dev_addr, 0, 0);
 	else
-		omap_set_dma_dest_params(c->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
+		omap_set_dma_dest_params(c->dma_ch, c->dst_port, OMAP_DMA_AMODE_CONSTANT,
 			d->dev_addr, 0, 0);
 
 	omap_dma_start_sg(c, d, 0);
@@ -475,11 +478,17 @@ static struct platform_driver omap_dma_driver = {
 
 bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
 {
+	struct omap_dma_channel_params *p = param;
+
 	if (chan->device->dev->driver == &omap_dma_driver.driver) {
 		struct omap_chan *c = to_omap_dma_chan(chan);
-		unsigned req = *(unsigned *)param;
+		unsigned req = p->dma_sig;
 
-		return req == c->dma_sig;
+		if (req == c->dma_sig) {
+			c->src_port = p->src_port;
+			c->dst_port = p->dst_port;
+			return true;
+		}
 	}
 	return false;
 }
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index a77c72e..284e602 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1531,7 +1531,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
 	dma_cap_mask_t mask;
-	unsigned sig;
+	struct omap_dma_channel_params p;
 	int i, ret = 0;
 	int irq;
 
@@ -1616,34 +1616,49 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 #ifdef USE_DMA_ENGINE
 	host->dma_tx_burst = -1;
 	host->dma_rx_burst = -1;
-
-	sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
-	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	if (cpu_is_omap24xx()) {
+		p.dma_sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX : OMAP24XX_DMA_MMC2_TX;
+		p.src_port = 0;
+		p.dst_port = 0;
+	} else {
+		p.dma_sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
+		p.src_port = OMAP_DMA_PORT_EMIFF;
+		p.dst_port = OMAP_DMA_PORT_TIPB;
+	}
+	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &p);
 #if 0
 	if (!host->dma_tx) {
-		def_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
+		dev_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
 			sig);
 		goto err_dma;
 	}
 #else
 	if (!host->dma_tx)
 		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
-			sig);
+			p.dma_sig);
 #endif
 #endif
 #ifdef USE_DMA_ENGINE
-	sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
-	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	if (cpu_is_omap24xx()) {
+		p.dma_sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX :  OMAP24XX_DMA_MMC2_RX;
+		p.src_port = 0;
+		p.dst_port = 0;
+	} else {
+		p.dma_sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
+		p.src_port = OMAP_DMA_PORT_TIPB;
+		p.dst_port = OMAP_DMA_PORT_EMIFF;
+	}
+	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &p);
 #if 0
 	if (!host->dma_rx) {
 		dev_err(host->dev, "unable to obtain RX DMA engine channel %u\n",
-			sig);
+			p.dma_sig);
 		goto err_dma;
 	}
 #else
 	if (!host->dma_rx)
 		dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
-			sig);
+			p.dma_sig);
 #endif
 #endif
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fa85efe..f373791 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -42,6 +42,7 @@
 #include <plat/board.h>
 #include <plat/mmc.h>
 #include <plat/cpu.h>
+#include <plat/dma.h>
 
 /* OMAP HSMMC Host Controller Registers */
 #define OMAP_HSMMC_SYSCONFIG	0x0010
@@ -1772,6 +1773,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
+	struct omap_dma_channel_params p;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -1920,13 +1922,17 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
+	p.dma_sig = rx_req;
+	p.src_port = 0;
+	p.dst_port = 0;
+	host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &p);
 	if (!host->rx_chan) {
 		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
 		goto err_irq;
 	}
 
-	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
+	p.dma_sig = tx_req;
+	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &p);
 	if (!host->tx_chan) {
 		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
 		goto err_irq;
