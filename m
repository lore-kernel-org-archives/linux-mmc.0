From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Mon, 14 Mar 2011 08:58:02 -0700 (PDT)
Message-ID: <727376.43956.qm@web161815.mail.bf1.yahoo.com>
References: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com> <20110312214348.GA312@pengutronix.de> <423716.64271.qm@web161805.mail.bf1.yahoo.com> <20110314101829.GB2206@pengutronix.de> <470477.34668.qm@web161814.mail.bf1.yahoo.com> <20110314152817.GD2206@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web161815.mail.bf1.yahoo.com ([98.139.210.165]:32916 "HELO
	web161815.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755616Ab1CNP6D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 11:58:03 -0400
In-Reply-To: <20110314152817.GD2206@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org

Hi,


> Then we'll have a  "useless" update. Won't hurt AFAICS, but might
> surprise people examining the  debug output.

Ok.

> > I only compile  tested this so far, so no proper patch yet, but what I would
> > write based  on the comments is something like this:
> 
> (Sidenote: Indentation is broken.  Tabwidth is 8)

Well yes, that is what yahoo likes to break. I will send a proper patch via
git send-email if/when I have actually tested it and it seems to work.

> 
> > --- a/drivers/mmc/host/sdhci.h
> > +++  b/drivers/mmc/host/sdhci.h
> > @@ -1545,9 +1546,20 @@ static void  sdhci_data_irq(struct sdhci_host *host, 
>u32 
>
> > intmask)
> >            * boundaries, but as we can't disable the  feature
> >           * we need to at least restart  the transfer.
> >           */
> > -         if (intmask & SDHCI_INT_DMA_END)
> > -             sdhci_writel(host, sdhci_readl(host,  SDHCI_DMA_ADDRESS),
> > -                 SDHCI_DMA_ADDRESS);
> > +        if (intmask  & SDHCI_INT_DMA_END) {
> > +             u32 dmastart, dmanow;
> > +             dmastart = sg_dma_address(host->data->sg);
> 
> Consecutive transfers  won't work (I know you know ;)).

I assume you mean a single transfer that exceeds whatever is
defined in SDHCI_DEFAULT_BOUNDARY_SIZE. As long as
it is kept at 512K things should be fine, but adding the auxiliary
variable to facilitate smaller values would make the patch
more invasive. Being an mmc non-hacker, I would rather leave
that kind of invasive patches for others :)


> 
> > +             dmanow = sdhci_readl(host, SDHCI_DMA_ADDRESS);
> > +             /*
> > +              * Force update to the next DMA block boundary.
> > +              */
> > +             dmanow = (dmastart &
> > +                 ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
> > +                  SDHCI_DEFAULT_BOUNDARY_SIZE;
> > +             DBG("%s: next DMA address after 0x%08x is 0x%08x\n",
> > +                 mmc_hostname(host->mmc), dmastart,  dmanow);
> > +            sdhci_writel(host,  dmanow, SDHCI_DMA_ADDRESS);
> > +        }
> 
> Other  than that, looks like the right direction to me.

Good to hear.

Mikko


      
