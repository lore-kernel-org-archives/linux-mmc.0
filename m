From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/9] mmc: tmio: tmio_mmc_host has .dma
Date: Mon, 05 Jan 2015 22:33:28 +0100
Message-ID: <7306460.62PqiTEhxi@wuerfel>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com> <4405974.QQJ6fqAfNe@wuerfel> <87bnmdo9hk.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:65436 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbbAEVdq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jan 2015 16:33:46 -0500
In-Reply-To: <87bnmdo9hk.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Monday 05 January 2015 09:35:16 Kuninori Morimoto wrote:
> 
> Hi Arnd
> 
> Thank you for your review
> 
> > > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > > index 3d02a3c1..4c5eda8 100644
> > > --- a/drivers/mmc/host/tmio_mmc.h
> > > +++ b/drivers/mmc/host/tmio_mmc.h
> > > @@ -40,6 +40,16 @@
> > >  
> > >  struct tmio_mmc_data;
> > >  
> > > +struct tmio_mmc_dma {
> > > +	void *chan_priv_tx;
> > > +	void *chan_priv_rx;
> > > +	int slave_id_tx;
> > > +	int slave_id_rx;
> > > +	int alignment_shift;
> > > +	dma_addr_t dma_rx_offset;
> > > +	bool (*filter)(struct dma_chan *chan, void *arg);
> > > +};
> > 
> > The slave_id/chan_priv values are now passed three times into the
> > driver, and one should really be enough. I'd suggest removing the
> > integer fields from both tmio_mmc_dma and tmio_mmc_data (added in
> > patch 9), and instead pass it as a void* argument only to tmio_mmc_data.
> 
> Hmm. I guess this priv_?x and slave_id are based on filter ?

priv_?x needs to be in a format that matches the filter function,
passing slave_id is basically always wrong, but dmaengine drivers
generally just ignore it.

> sh_mobile_sdhi case, and, if it is probed via non-DT,
> it will use shdma_chan_filter, and then, it doesn't need both priv_?x and slave_id.
> And, if it is probed via DT, it will use other filter,
> and yes, it also doesn't need these parameter.

Ok.

> So, from sh_mobile_sdhi point of view, yes, we can do your idea.
> But, if other driver want to use it with other filter, we need both ?
> (sh_mobile_sdhi is the only dmaengine user at this point, so, there
> is no problem though...)

No other driver besides shmobile should use the slave_id, and a lot
of them cannot even use it because it is not in a format that makes
sense to a driver. Passing just chan_priv is the only way to do
a platform-independent driver with our API, so if we ever wanted to
use DMA on another SoC with this driver, we have to make that change
anyway.

> > The alignment_shift and dma_rx_offset values seem to always be
> > the same for all users (at least the remaining ones, possibly there
> > were others originally), so you could hardcode those in tmio_mmc_dma.c
> > and remove the tmio_mmc_dma structure entirely.
> 
> Unfortunately, alignment_shift and dma_rx_offset value are based on SoC.
> we can't hardcode these.

Which SoCs use a different value here? Both of these look like
implementation details of the tmio_mmc, not of the integration
into the SoC, so they could just be keyed off the device identification.

> > For some obscure reason, the 'pdata->dma->slave_id_?x' fields currently
> > get passed into cfg.slave_id, which is something we really want to
> > get rid of so we can remove the slave_id field from dma_slave_config:
> > The slave ID is generally considered specific to the channel allocation,
> > not the configuration, and not all dmaengine drivers can express it
> > as a single integer, so the concept is obsolete. When you remove
> > the slave_id_?x fields here, you should also be able to just remove
> > the cfg.slave_id assignment without any replacement, unless there is
> > a bug in the dmaengine driver that should be fixed instead.
> 
> I guess maybe there is no problem about this,
> but, actually I don't want do it, because of compatibility.
> There are many combination for DMAEngine setting.
> In sh-mobile-sdhi case, we are using this driver via non-DT / DT cases,
> and different DMAEngine (sh-dma / rcar-dma).
> But, I can't test all patterns today. So, I would like to keep it as-is
> if possible.

Maybe we can hide the slave_id field in dma_slave_config within
'#if defined(CONFIG_ARCH_SH_MOBILE) && defined(CONFIG_ATAGS)' then?

I would really like to prevent other people from copying the mistake.
Apparently it has already happened on MIPS jz4740, but that one seems
easy enough to fix. Tegra used to use slave_id as well, but it's been
converted to DT-only a while ago and that is just dead code for them.

I've had a closer look at the existing code now and came up with a
patch that should work for all out-of-tree drivers you may be worried
about.

	Arnd
---
dmaengine: shdma: use normal interface for passing slave id

The shmobile platform is one of only two users of the slave_id field
in dma_slave_config, which is incompatible with the way that the
dmaengine API normally works.

I've had a closer look at the existing code now and found that all
slave drivers that pass a slave_id in dma_slave_config for SH do that
right after passing the same ID into shdma_chan_filter, so we can just
rely on that. However, the various shdma drivers currently do not
remember the slave ID that was passed into the filter function when
used in non-DT mode and only check the value to find a matching channel,
unlike all other drivers.

There might still be drivers that are not part of the kernel that rely
on setting the slave_id to some other value, so to be on the safe side,
this adds another 'real_slave_id' field to shdma_chan that remembers
the ID and uses it when a driver passes a zero slave_id in dma_slave_config,
like most drivers do.

Eventually, the real_slave_id and slave_id fields should just get merged
into one field, but that requires other changes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
 drivers/dma/sh/shdma-base.c     | 70 ++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 drivers/mmc/host/sh_mmcif.c     |  4 +---
 drivers/mmc/host/tmio_mmc_dma.c |  4 ----
 drivers/mtd/nand/sh_flctl.c     |  2 --
 drivers/spi/spi-rspi.c          |  1 -
 drivers/spi/spi-sh-msiof.c      |  1 -
 include/linux/shdma-base.h      |  1 +
 7 files changed, 52 insertions(+), 31 deletions(-)

Note: this also changes all affected drivers to no longer pass the slave_id
field in dma_slave_config, but those changes can also be done later, as
long as the main patch gets merged first.

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 3a2adb131d46..cb3e7e3b5027 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -171,8 +171,7 @@ static struct shdma_desc *shdma_get_desc(struct shdma_chan *schan)
 	return NULL;
 }
 
-static int shdma_setup_slave(struct shdma_chan *schan, int slave_id,
-			     dma_addr_t slave_addr)
+static int shdma_setup_slave(struct shdma_chan *schan, dma_addr_t slave_addr)
 {
 	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
 	const struct shdma_ops *ops = sdev->ops;
@@ -183,25 +182,23 @@ static int shdma_setup_slave(struct shdma_chan *schan, int slave_id,
 		ret = ops->set_slave(schan, match, slave_addr, true);
 		if (ret < 0)
 			return ret;
-
-		slave_id = schan->slave_id;
 	} else {
-		match = slave_id;
+		match = schan->real_slave_id;
 	}
 
-	if (slave_id < 0 || slave_id >= slave_num)
+	if (schan->real_slave_id < 0 || schan->real_slave_id >= slave_num)
 		return -EINVAL;
 
-	if (test_and_set_bit(slave_id, shdma_slave_used))
+	if (test_and_set_bit(schan->real_slave_id, shdma_slave_used))
 		return -EBUSY;
 
 	ret = ops->set_slave(schan, match, slave_addr, false);
 	if (ret < 0) {
-		clear_bit(slave_id, shdma_slave_used);
+		clear_bit(schan->real_slave_id, shdma_slave_used);
 		return ret;
 	}
 
-	schan->slave_id = slave_id;
+	schan->slave_id = schan->real_slave_id;
 
 	return 0;
 }
@@ -221,10 +218,12 @@ static int shdma_alloc_chan_resources(struct dma_chan *chan)
 	 */
 	if (slave) {
 		/* Legacy mode: .private is set in filter */
-		ret = shdma_setup_slave(schan, slave->slave_id, 0);
+		schan->real_slave_id = slave->slave_id;
+		ret = shdma_setup_slave(schan, 0);
 		if (ret < 0)
 			goto esetslave;
 	} else {
+		/* Normal mode: real_slave_id was set by filter */
 		schan->slave_id = -EINVAL;
 	}
 
@@ -258,11 +257,14 @@ esetslave:
 
 /*
  * This is the standard shdma filter function to be used as a replacement to the
- * "old" method, using the .private pointer. If for some reason you allocate a
- * channel without slave data, use something like ERR_PTR(-EINVAL) as a filter
+ * "old" method, using the .private pointer.
+ * You always have to pass a valid slave id as the argument, old drivers that
+ * pass ERR_PTR(-EINVAL) as a filter parameter and set it up in dma_slave_config
+ * need to be updated so we can remove the slave_id field from dma_slave_config.
  * parameter. If this filter is used, the slave driver, after calling
  * dma_request_channel(), will also have to call dmaengine_slave_config() with
- * .slave_id, .direction, and either .src_addr or .dst_addr set.
+ * .direction, and either .src_addr or .dst_addr set.
+ *
  * NOTE: this filter doesn't support multiple DMAC drivers with the DMA_SLAVE
  * capability! If this becomes a requirement, hardware glue drivers, using this
  * services would have to provide their own filters, which first would check
@@ -276,7 +278,7 @@ bool shdma_chan_filter(struct dma_chan *chan, void *arg)
 {
 	struct shdma_chan *schan;
 	struct shdma_dev *sdev;
-	int match = (long)arg;
+	int slave_id = (long)arg;
 	int ret;
 
 	/* Only support channels handled by this driver. */
@@ -284,16 +286,35 @@ bool shdma_chan_filter(struct dma_chan *chan, void *arg)
 	    shdma_alloc_chan_resources)
 		return false;
 
-	if (match < 0)
+	schan = to_shdma_chan(chan);
+	sdev = to_shdma_dev(chan->device);
+
+	/*
+	 * For DT, the schan->slave_id field is generated by the
+	 * set_slave function from the slave ID that is passed in
+	 * from xlate. For the non-DT case, the slave ID is
+	 * directly passed into the filter function by the driver
+	 */
+	if (schan->dev->of_node) {
+		ret = sdev->ops->set_slave(schan, slave_id, 0, true);
+		if (ret < 0)
+			return false;
+
+		schan->real_slave_id = schan->slave_id;
+		return true;
+	}
+
+	if (slave_id < 0) {
 		/* No slave requested - arbitrary channel */
+		dev_warn(sdev->dma_dev.dev, "invalid slave ID passed to dma_request_slave\n");
 		return true;
+	}
 
-	schan = to_shdma_chan(chan);
-	if (!schan->dev->of_node && match >= slave_num)
+	if (slave_id >= slave_num)
 		return false;
 
-	sdev = to_shdma_dev(schan->dma_chan.device);
-	ret = sdev->ops->set_slave(schan, match, 0, true);
+	ret = sdev->ops->set_slave(schan, schan->real_slave_id, 0, true);
+	schan->real_slave_id = slave_id;
 	if (ret < 0)
 		return false;
 
@@ -452,6 +473,8 @@ static void shdma_free_chan_resources(struct dma_chan *chan)
 		chan->private = NULL;
 	}
 
+	schan->real_slave_id = 0;
+
 	spin_lock_irq(&schan->chan_lock);
 
 	list_splice_init(&schan->ld_free, &list);
@@ -767,7 +790,14 @@ static int shdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		 * channel, while using it...
 		 */
 		config = (struct dma_slave_config *)arg;
-		ret = shdma_setup_slave(schan, config->slave_id,
+
+		/* overriding the slave_id through dma_slave_config is deprecated,
+		 * but possibly some out-of-tree drivers still do it. */
+		if (WARN_ON_ONCE(config->slave_id &&
+		    config->slave_id != schan->real_slave_id))
+			schan->real_slave_id = config->slave_id;
+
+		ret = shdma_setup_slave(schan,
 					config->direction == DMA_DEV_TO_MEM ?
 					config->src_addr : config->dst_addr);
 		if (ret < 0)
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7d9d6a321521..df3a537f5a83 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -388,7 +388,7 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 {
 	struct dma_slave_config cfg = { 0, };
 	struct dma_chan *chan;
-	unsigned int slave_id;
+	void *slave_data;
 	struct resource *res;
 	dma_cap_mask_t mask;
 	int ret;
@@ -414,8 +414,6 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 
 	res = platform_get_resource(host->pd, IORESOURCE_MEM, 0);
 
-	/* In the OF case the driver will get the slave ID from the DT */
-	cfg.slave_id = slave_id;
 	cfg.direction = direction;
 
 	if (direction == DMA_DEV_TO_MEM) {
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 7d077388b9eb..2ba47ab689ff 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -288,8 +288,6 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_tx)
 			return;
 
-		if (pdata->dma->chan_priv_tx)
-			cfg.slave_id = pdata->dma->slave_id_tx;
 		cfg.direction = DMA_MEM_TO_DEV;
 		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->pdata->bus_shift);
 		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -307,8 +305,6 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_rx)
 			goto ereqrx;
 
-		if (pdata->dma->chan_priv_rx)
-			cfg.slave_id = pdata->dma->slave_id_rx;
 		cfg.direction = DMA_DEV_TO_MEM;
 		cfg.src_addr = cfg.dst_addr + pdata->dma->dma_rx_offset;
 		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index a21c378f096a..c3ce81c1a716 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -159,7 +159,6 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
 		return;
 
 	memset(&cfg, 0, sizeof(cfg));
-	cfg.slave_id = pdata->slave_id_fifo0_tx;
 	cfg.direction = DMA_MEM_TO_DEV;
 	cfg.dst_addr = (dma_addr_t)FLDTFIFO(flctl);
 	cfg.src_addr = 0;
@@ -175,7 +174,6 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
 	if (!flctl->chan_fifo0_rx)
 		goto err;
 
-	cfg.slave_id = pdata->slave_id_fifo0_rx;
 	cfg.direction = DMA_DEV_TO_MEM;
 	cfg.dst_addr = 0;
 	cfg.src_addr = (dma_addr_t)FLDTFIFO(flctl);
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 2071f788c6fb..6cbcdc04c947 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -918,7 +918,6 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 	}
 
 	memset(&cfg, 0, sizeof(cfg));
-	cfg.slave_id = id;
 	cfg.direction = dir;
 	if (dir == DMA_MEM_TO_DEV) {
 		cfg.dst_addr = port_addr;
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 239be7cbe5a8..786ac9ec11fc 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -984,7 +984,6 @@ static struct dma_chan *sh_msiof_request_dma_chan(struct device *dev,
 	}
 
 	memset(&cfg, 0, sizeof(cfg));
-	cfg.slave_id = id;
 	cfg.direction = dir;
 	if (dir == DMA_MEM_TO_DEV) {
 		cfg.dst_addr = port_addr;
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index abdf1f229dc3..dd0ba502ccb3 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -69,6 +69,7 @@ struct shdma_chan {
 	int id;				/* Raw id of this channel */
 	int irq;			/* Channel IRQ */
 	int slave_id;			/* Client ID for slave DMA */
+	int real_slave_id;		/* argument passed to filter function */
 	int hw_req;			/* DMA request line for slave DMA - same
 					 * as MID/RID, used with DT */
 	enum shdma_pm_state pm_state;

