From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Mon, 14 Mar 2011 06:00:29 -0700 (PDT)
Message-ID: <470477.34668.qm@web161814.mail.bf1.yahoo.com>
References: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com> <20110312214348.GA312@pengutronix.de> <423716.64271.qm@web161805.mail.bf1.yahoo.com> <20110314101829.GB2206@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web161814.mail.bf1.yahoo.com ([98.139.210.164]:20770 "HELO
	web161814.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752966Ab1CNNAa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 09:00:30 -0400
In-Reply-To: <20110314101829.GB2206@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org

Wolfram Sang wrote:

> > > >  Signed-off-by: Mikko Vinni <mmvinni <at>  yahoo.com>
> > > 
> > > Proper EMail  please.
> > 
> > Hm, @gmail.com? (cc added for further emails)
> 
> I was just  referring to using "<at>" instead of "@". The provider
> doesn't really  matter :)

Ah, ok. Yahoo makes it practically impossible to send well-formed
patches from the web interface, but as long as it's not completely
rejected for casual email, I prefer to keep the number of spam
addresses to the minimum.

> > > > -          if (intmask & SDHCI_INT_DMA_END)
> > >  >  -            sdhci_writel(host,   sdhci_readl(host, 
SDHCI_DMA_ADDRESS),
> > > > -                   SDHCI_DMA_ADDRESS);
> > > >  +        if (intmask  & SDHCI_INT_DMA_END)  {
> > > > +             u32 dmastart,  dmanow;
> > > > +             dmastart  =  sg_dma_address(host->data->sg);
> > > 
> > > This  will only work for the first  512K, right?
> > 
> > True. If a  transfer can cross more than one boundary, I suppose an
> > additional  variable is needed to keep track of the current state.
> 
> Yeah, thought  that, too. I also wondered if we then just could not
> always write our own  value to DMA_ADDRESS. This is redundant on working
> hardware, but the the  check is not much cheaper than just doing it.
> 
> Would that change also be  beyond your comfort zone?

Almost. There is one statement in the spec ("At the end of transfer, the Host
Controller may issue or may not issue DMA Interrupt"), which makes
me wonder whether a host hontroller may issue a DMA Interrupt also at
the end of a transfer which doesn't finish at the boundary.

> 
> > > > +              dmanow = sdhci_readl(host, SDHCI_DMA_ADDRESS);
> > >  >  +            if (dmanow ==   dmastart) {
> > > > +                  /*
> > > > +                   * HW failed to increase the  address.
> > > >  +                  * Update to the  next 512KB block boundary.
> > > >  +                   */
> > > > +                  dmanow = (dmanow & ~0x7ffff) +  0x80000;
> > > 
> > > Hmm,  hardcoding these values is  probably not a good idea. They should be
> > > dependent  on what is  written to MAKE_BLKSIZE. Maybe a common define?
> > 
> > Sorry,  implementing that goes beyond my comfort zone. I would be happy to
> > test  patches, though.
> 
> I was imagining something like:
> 
> #define  SDHCI_DEFAULT_BOUNDARY_SIZE    (512 * 1024)
> 
> which could be  used directly in your code and later  like
> 
> SDHCI_MAKE_BLKSZ(ilog2(SDHCI_DEFAULT_BOUNDARY_SIZE) - 12,  ...);
> 
> (Maybe the ilog2-thingie could be another macro)

In sdhci.c or sdhci.c? I see SDHCI_MAKE_BLKSZ is used also in
drivers/mmc/host/sdhci-esdhc-imx.c and drivers/mmc/host/sdhci-of-esdhc.c.

I only compile tested this so far, so no proper patch yet, but what I would
write based on the comments is something like this:

--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -201,6 +201,9 @@
 #define SDHCI_MAX_DIV_SPEC_200    256
 #define SDHCI_MAX_DIV_SPEC_300    2046
 
+#define SDHCI_DEFAULT_BOUNDARY_SIZE    (512 * 1024)
+#define SDHCI_DEFAULT_BOUNDARY_ARG    (ilog2(SDHCI_DEFAULT_BOUNDARY_SIZE) - 12)
+
 struct sdhci_ops {
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
     u32        (*read_l)(struct sdhci_host *host, int reg);

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -808,7 +808,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, 
struct mmc_data *data)
     sdhci_set_transfer_irqs(host);
 
     /* We do not handle DMA boundaries, so set it to max (512 KiB) */
-    sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, data->blksz), SDHCI_BLOCK_SIZE);
+    sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
+        data->blksz), SDHCI_BLOCK_SIZE);
     sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
 }
 
@@ -1545,9 +1546,20 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 
intmask)
          * boundaries, but as we can't disable the feature
          * we need to at least restart the transfer.
          */
-        if (intmask & SDHCI_INT_DMA_END)
-            sdhci_writel(host, sdhci_readl(host, SDHCI_DMA_ADDRESS),
-                SDHCI_DMA_ADDRESS);
+        if (intmask & SDHCI_INT_DMA_END) {
+            u32 dmastart, dmanow;
+            dmastart = sg_dma_address(host->data->sg);
+            dmanow = sdhci_readl(host, SDHCI_DMA_ADDRESS);
+            /*
+             * Force update to the next DMA block boundary.
+             */
+            dmanow = (dmastart &
+                ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
+                SDHCI_DEFAULT_BOUNDARY_SIZE;
+            DBG("%s: next DMA address after 0x%08x is 0x%08x\n",
+                mmc_hostname(host->mmc), dmastart, dmanow);
+            sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+        }
 
         if (intmask & SDHCI_INT_DATA_END) {
             if (host->cmd) {


I will test this a bit later and send it as a proper patch, if it looks better
than the original one.

Mikko


> 
> > >  >  +                if   (dmanow > dmastart + host->data->blksz *
> > > > +                                host->data->blocks) {
> > > >  +                       WARN_ON(1);
> > > > +                      dmanow =  dmastart;
> > > > +                  }
> > > 
> > > Did this  happen?
> > 
> > No, but I though it brings some protection in case  somebody *does*
> > change the boundary value without checking the code  first (and happens
> > to be running on flawed hardware).
> 
> So, it  could go if we make that dependent if I understand correctly.
> 
> Oh, and  what I forgot to say last time:
> 
> Thanks a lot for your debugging efforts!  I read the bugzilla entry and
> your persistency for nailing the cause is  greatly appreciated. Good
> work.
> 
> All the best,
> 
>     Wolfram
> 
> -- 
> Pengutronix e.K.                            | Wolfram Sang                 |
> Industrial Linux Solutions                  | http://www.pengutronix.de/  |
> 


      
