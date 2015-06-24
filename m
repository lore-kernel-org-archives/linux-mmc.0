From: Joe Perches <joe@perches.com>
Subject: Re: [PATCHv2] mmc:Add pointer cast to uintptr_t for slave_id_rx and
 tx in the function, sh_mmcif_request_dma_one
Date: Tue, 23 Jun 2015 17:07:24 -0700
Message-ID: <1435104444.2504.28.camel@perches.com>
References: <1431366550-22045-1-git-send-email-xerofoify@gmail.com>
	 <87r3p2rnek.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87r3p2rnek.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: ulf.hansson@linaro.org, Nicholas Krause <xerofoify@gmail.com>, ben.dooks@codethink.co.uk, ykaneko0929@gmail.com, laurent.pinchart+renesas@ideasonboard.com, kouichi.tomita.yn@renesas.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 2015-06-24 at 08:54 +0900, Kuninori Morimoto wrote:
> Can you please teach us about status of this patch ?
> > This adds a cast to the variables,slave_id_rx and slave_id_rx
> > to uintptr_t before casting to void* in order to avoid build
> > warning on 64bit platforms for the function, sh_mmcif_request_dma_one.
[]
> > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
[]
> > @@ -398,8 +398,8 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
> >  
> >  	if (pdata)
> >  		slave_data = direction == DMA_MEM_TO_DEV ?
> > -			(void *)pdata->slave_id_tx :
> > -			(void *)pdata->slave_id_rx;
> > +			(void *)(uintptr_t)pdata->slave_id_tx :
> > +			(void *)(uintptr_t)pdata->slave_id_rx;

It's far more common (~10:1) in the kernel to cast using
	(<type> *)(unsigned long)<foo>
than
	(<type> *)(uintptr_t)<foo>
