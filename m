From: Joe Perches <joe@perches.com>
Subject: Re: [PATCHv2] mmc:Add pointer cast to uintptr_t for slave_id_rx and
 tx in the function, sh_mmcif_request_dma_one
Date: Tue, 23 Jun 2015 17:40:55 -0700
Message-ID: <1435106455.2504.35.camel@perches.com>
References: <1431366550-22045-1-git-send-email-xerofoify@gmail.com>
	 <87r3p2rnek.wl%kuninori.morimoto.gx@renesas.com>
	 <1435104444.2504.28.camel@perches.com> <5589F6D8.5090107@gmail.com>
	 <87oak6rm5k.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:56499 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932464AbbFXAk7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jun 2015 20:40:59 -0400
In-Reply-To: <87oak6rm5k.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: nick <xerofoify@gmail.com>, ulf.hansson@linaro.org, ben.dooks@codethink.co.uk, ykaneko0929@gmail.com, laurent.pinchart+renesas@ideasonboard.com, kouichi.tomita.yn@renesas.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2015-06-24 at 00:24 +0000, Kuninori Morimoto wrote:
> Hi Joe, Nick
> 
> > >>> This adds a cast to the variables,slave_id_rx and slave_id_rx
> > >>> to uintptr_t before casting to void* in order to avoid build
> > >>> warning on 64bit platforms for the function, sh_mmcif_request_dma_one.
> > > []
> > >>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> > > []
> > >>> @@ -398,8 +398,8 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
> > >>>  
> > >>>  	if (pdata)
> > >>>  		slave_data = direction == DMA_MEM_TO_DEV ?
> > >>> -			(void *)pdata->slave_id_tx :
> > >>> -			(void *)pdata->slave_id_rx;
> > >>> +			(void *)(uintptr_t)pdata->slave_id_tx :
> > >>> +			(void *)(uintptr_t)pdata->slave_id_rx;
> > > 
> > > It's far more common (~10:1) in the kernel to cast using
> > > 	(<type> *)(unsigned long)<foo>
> > > than
> > > 	(<type> *)(uintptr_t)<foo>
> > > 
> > Joe,
> > I agree it's more common in the kernel but one of the maintainers when I sent
> > this patch a month ago requested I use uintpr_t instead of unsigned long for
> > the casting. Otherwise I would have done the cast to fix the build warning
> > with unsigned long instead.
> 
> This mail
> http://thread.gmane.org/gmane.linux.kernel.mmc/32304

uintptr_t was introduced to avoid ptrdiff_t misuse in
commit 142956af5250 ("fix abuses of ptrdiff_t") by Al Viro.

unsigned long is preponderant, long is used about 1/4 as
often as unsigned long, uintptr_t is relatively uncommon.

If someone wants to go and convert the 800 or so casts to
long or unsigned long to uintptr_t so that's the style most
frequently used, that'd be different.  I'm not going to
submit any patches for that.


