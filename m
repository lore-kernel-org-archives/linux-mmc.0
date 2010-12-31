From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v3] mmc: davinci: add support for SDIO irq handling
Date: Fri, 31 Dec 2010 11:15:20 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024806DF98@dbde02.ent.ti.com>
References: <1293706357-21358-1-git-send-email-nsekhar@ti.com>
 <4D1C7E19.7050605@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45398 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab0LaFpb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Dec 2010 00:45:31 -0500
In-Reply-To: <4D1C7E19.7050605@mvista.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Chris Ball <cjb@laptop.org>

Hi Sergei,

On Thu, Dec 30, 2010 at 18:12:01, Sergei Shtylyov wrote:

> > diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> > index b643dde..04c2fa4 100644
> > --- a/drivers/mmc/host/davinci_mmc.c
> > +++ b/drivers/mmc/host/davinci_mmc.c
> [...]
> > @@ -1209,7 +1267,8 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
> >   		host->nr_sg = MAX_NR_SG;
> >
> >   	host->use_dma = use_dma;
> > -	host->irq = irq;
> > +	host->mmc_irq = irq;
> > +	host->sdio_irq = platform_get_irq(pdev, 1);
> >
> >   	if (host->use_dma&&  davinci_acquire_dma_channels(host) != 0)
> >   		host->use_dma = 0;
> > @@ -1270,6 +1329,13 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
> >   	if (ret)
> >   		goto out;
> >
> > +	if (host->sdio_irq != NO_IRQ) {
> 
>     Note that platform_get_irq() will return -EXDEV if the resource is not 
> present. Perhaps you should check for it...

I checked and got back -ENXIO. arch/arm/include/asm/irq.h suggests NO_IRQ
as the return value. I guess I will just settle for "host->sdio_irq >= 0"
to check for a valid IRQ number passed.

Thanks,
Sekhar
