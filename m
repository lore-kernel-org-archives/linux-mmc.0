From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Thu, 26 Aug 2010 23:10:24 +0100
Message-ID: <20100826221024.GA11300@console-pimps.org>
References: <20100708144626.2091f6c1.akpm@linux-foundation.org>
 <4C3BBE77.8080000@renesas.com>
 <20100715132552.fcb5791b.akpm@linux-foundation.org>
 <20100825231107.45227d6a@linux-g6p1.site>
 <20100825160722.9c9c38c8.akpm@linux-foundation.org>
 <4C75BB0D.2030202@renesas.com>
 <20100826075320.0538043b@linux-g6p1.site>
 <AANLkTim2_8UU62hnvSrPK94MgaM35K0PbppGe8yeW-bC@mail.gmail.com>
 <20100826072642.GB19339@console-pimps.org>
 <20100826141237.c31bc1ed.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:60878 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753127Ab0HZWK1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 18:10:27 -0400
Content-Disposition: inline
In-Reply-To: <20100826141237.c31bc1ed.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Paul Mundt <lethal@linux-sh.org>

On Thu, Aug 26, 2010 at 02:12:37PM -0700, Andrew Morton wrote:
> On Thu, 26 Aug 2010 08:26:42 +0100
> Matt Fleming <matt@console-pimps.org> wrote:
> 
> > On Thu, Aug 26, 2010 at 03:58:38PM +0900, Magnus Damm wrote:
> > >
> > > Hi Matt,
> > > 
> > > Just FYI, the newer version of these patches also have a whole bunch
> > > of acked-by and tested-by tags, see this email:
> > > 
> > > http://lkml.org/lkml/2010/8/20/429
> > > 
> > > Thanks for your help!
> > 
> > Argh, right. Claws-mail searching has completely failed me. I didn't
> > even see that thread when searching to "tmio_mmc". Back to mutt..
> > 
> > Andrew, can you drop the patch with my changelog and pick up the one in
> > that thread seeing as it's got all the tags and a new changelog? Thanks.
> 
> I actually already had it, as
> tmio_mmc-dont-clear-unhandled-pending-interrupts.patch, scheduled for
> 2.6.36 and -stable.
> 
> What's the score with "tmio_mmc: allow 2 byte requests in 4-bit mode"? 
> I didn't merge it because Ian said "This change needs to be modified to
> test what hardware is present.  this wont work on my hardware TTBOMK.".
>  Then I later _did_ merge it because it got sneakily renamed to
> "tmio_mmc: revise a limit of the data size". 

I've stuck my oar in and confused everybody now, it seems. As Ian
pointed out, before "tmio_mmc: revise a limit of the data size" can be
merged something like the following is needed,

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ee7d0a5..3eabd91 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -657,11 +657,15 @@ static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	struct mmc_data *data)
 {
+	struct mfd_cell	*cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
+
 	pr_debug("setup data transfer: blocksize %08x  nr_blocks %d\n",
 		 data->blksz, data->blocks);
 
 	/* Hardware cannot perform 1 and 2 byte requests in 4 bit mode */
-	if (data->blksz < 4 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
+	if (data->blksz < 4 && !(pdata->flags & TMIO_MMC_2BYTE_BLKSZ) &&
+	    host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
 		pr_err("%s: %d byte block unsupported in 4 bit mode\n",
 		       mmc_hostname(host->mmc), data->blksz);
 		return -EINVAL;
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index f07425b..56467cb 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -52,6 +52,11 @@
 
 /* tmio MMC platform flags */
 #define TMIO_MMC_WRPROTECT_DISABLE	(1 << 0)
+/*
+ * Some controllers can support a 2-byte block size when the bus width
+ * is configured in 4-bit mode.
+ */
+#define TMIO_MMC_2BYTE_BLKSZ		(1 << 1)
 
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);


Magnus, since people have tested 2-byte blksz transfers on SDHI and it
works, does it make sense to have this change to
drivers/mfd/sh_mobile_sdhi.c? Are you aware of a version of the SDHI
block that doens't support this mode?

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index cd16459..1f3a1b1 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -112,6 +112,12 @@ static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->ocr_mask = p->tmio_ocr_mask;
 	}
 
+	/*
+	 * All SDHI blocks support 2-byte and larger block sizes in 4-bit
+	 * bus width mode.
+	 */
+	mmc_data->flags |= TMIO_MMC_2BYTE_BLKSZ;
+
 	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
 		priv->param_tx.slave_id = p->dma_slave_tx;
 		priv->param_rx.slave_id = p->dma_slave_rx;

So I think these patches need to either be merged into "tmio_mmc: revise
a limit of the data size" with a bit in the changelog explaning that
some tmio blocks don't support 2-byte tranfers, or added as separate
patches before it.

Does everyone agree?
