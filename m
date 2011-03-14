From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Mon, 14 Mar 2011 02:23:05 -0700 (PDT)
Message-ID: <423716.64271.qm@web161805.mail.bf1.yahoo.com>
References: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com> <20110312214348.GA312@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web161805.mail.bf1.yahoo.com ([98.139.210.114]:27209 "HELO
	web161805.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753036Ab1CNJ3r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 05:29:47 -0400
In-Reply-To: <20110312214348.GA312@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, mikko.vinni@gmail.com

Hi,



Wolfram Sang wrote:
> I finally found some time.

Greatly appreciated.

> > Some SD host controllers (noticed on an  integrated JMicron SD reader
> > on an HP Pavilion dv5-1250eo laptop) don't  update the dma address
> > register before signaling a dma interrupt due to  a dma boundary.
> > Detect this and update the register to the next 512KB  boundary,
> > at which the transfer presumably stopped.
> > 
> > As  long as each transfer is at most 512KB in size (on this hardware
> > the max  seems to be 65536 bytes), this fix is needed at most once
> > per  transfer.
> 
> But we can't guarantee that. Transfer could be up to 65535 *  2K.

In sdhci.c function sdhci_prepare_data there are these checks:

    /* Sanity checks */
    BUG_ON(data->blksz * data->blocks > 524288);
    BUG_ON(data->blksz > host->mmc->max_blk_size);
    BUG_ON(data->blocks > 65535);

I thought the first BUG_ON makes sure that the transfer doesn't go too big.
Then again, I might be missing something. Is 524288 not in bytes?

> 
> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=28462
> > 
> >  Signed-off-by: Mikko Vinni <mmvinni <at> yahoo.com>
> 
> Proper EMail  please.

Hm, @gmail.com? (cc added for further emails)


> > diff --git a/drivers/mmc/host/sdhci.c  b/drivers/mmc/host/sdhci.c
> > index a25db42..8651731 100644
> > ---  a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@  -1537,9 +1537,27 @@ static void sdhci_data_irq(struct sdhci_host *host, 
>u32  intmask)
> >           * boundaries, but  as we can't disable the feature
> >            * we need to at least restart the transfer.
> >            */
> > -         if (intmask & SDHCI_INT_DMA_END)
> >  -            sdhci_writel(host,  sdhci_readl(host, SDHCI_DMA_ADDRESS),
> > -                  SDHCI_DMA_ADDRESS);
> > +        if (intmask  & SDHCI_INT_DMA_END) {
> > +             u32 dmastart, dmanow;
> > +             dmastart =  sg_dma_address(host->data->sg);
> 
> This will only work for the first  512K, right?

True. If a transfer can cross more than one boundary, I suppose an
additional variable is needed to keep track of the current state.

> 
> > +             dmanow = sdhci_readl(host, SDHCI_DMA_ADDRESS);
> >  +            if (dmanow ==  dmastart) {
> > +                 /*
> > +                  * HW failed to increase the  address.
> > +                  * Update to the next 512KB block boundary.
> >  +                  */
> > +                 dmanow = (dmanow & ~0x7ffff) + 0x80000;
> 
> Hmm,  hardcoding these values is probably not a good idea. They should be
> dependent  on what is written to MAKE_BLKSIZE. Maybe a common define?

Sorry, implementing that goes beyond my comfort zone. I would be happy to
test patches, though.

> 
> >  +                if  (dmanow > dmastart + host->data->blksz *
> > +                              host->data->blocks) {
> >  +                     WARN_ON(1);
> > +                     dmanow =  dmastart;
> > +                 }
> 
> Did this happen?

No, but I though it brings some protection in case somebody *does*
change the boundary value without checking the code first (and happens
to be running on flawed hardware).

> 
> > +                 DBG("%s: next DMA  address forced "
> > +                     "from 0x%08x to  0x%08x\n",
> > +                     mmc_hostname(host->mmc), dmastart,  dmanow);
> > +             }
> > +             sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> > +         }
> >  
> >           if (intmask & SDHCI_INT_DATA_END) {
> >               if (host->cmd)  {
> > -- 
> > 1.7.4.1
> 
> Regards,
> 
>    Wolfram
> 

Thanks

Mikko


      
