From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2] mmc: atmel-mci: use probe deferring if dma controller
 is not ready yet
Date: Wed, 19 Nov 2014 16:15:25 +0100
Message-ID: <20141119151525.GG3639@ldesroches-Latitude-E6320>
References: <1416408667-4666-1-git-send-email-ludovic.desroches@atmel.com>
 <12322299.5p08TVzGz4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:30355 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbaKSPPH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 10:15:07 -0500
Content-Disposition: inline
In-Reply-To: <12322299.5p08TVzGz4@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, nicolas.ferre@atmel.com

On Wed, Nov 19, 2014 at 03:57:56PM +0100, Arnd Bergmann wrote:
> On Wednesday 19 November 2014 15:51:07 Ludovic Desroches wrote:
> > @@ -2265,37 +2265,39 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
> >         mmc_free_host(slot->mmc);
> >  }
> >  
> > -static bool atmci_configure_dma(struct atmel_mci *host)
> > +static int atmci_configure_dma(struct atmel_mci *host)
> >  {
> >         struct mci_platform_data        *pdata;
> >         dma_cap_mask_t mask;
> > +       int ret = 0;
> >  
> >         if (host == NULL)
> > -               return false;
> > +               return -EINVAL;
> >  
> >         pdata = host->pdev->dev.platform_data;
> >  
> >         dma_cap_zero(mask);
> >         dma_cap_set(DMA_SLAVE, mask);
> >  
> > 
> 
> Host can't be NULL here, the only caller has already checked and dereferenced
> the pointer before calling atmci_configure_dma.
> 
> The mask variable is now completely unused and can be removed.

Thanks, there is some extra stuff that can be removed too. I'll split
those changes in two patches, one to remove all non DT DMA stuff and one
for probe deferring.

Ludovic
