From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: sdio irq hack for omap_hsmmc.c (was: Re: [PATCH] OMAP35xx:SDIO IRQ Support for OMAP35xx)
Date: Thu, 28 Jan 2010 17:52:44 -0600
Message-ID: <000801caa074$fca47fd0$544ff780@am.dhcp.ti.com>
References: <4b73d43f1001260904m212d2c53gde6328ad9b9bb14e@mail.gmail.com> <008001ca9fa6$87dc26e0$544ff780@am.dhcp.ti.com> <4b73d43f1001271556m5945d358v2ca5bea5862b0080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41080 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212Ab0A1Xww (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jan 2010 18:52:52 -0500
In-Reply-To: <4b73d43f1001271556m5945d358v2ca5bea5862b0080@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'John Rigby' <jcrigby@gmail.com>
Cc: 'Mike Rapoport' <mike@compulab.co.il>, 'Dirk Behme' <dirk.behme@googlemail.com>, 'Phaneendra Kumar Alapati' <phani@embwise.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, 'Adrian Hunter' <adrian.hunter@nokia.com>, "'Paasikivi Teemu.3 (EXT-Ixonos/Tampere)'" <ext-teemu.3.paasikivi@nokia.com>, "'Gabay, Benzy'" <benzyg@ti.com>

Hi,

I am not an SDIO expert. But what I understand from this is that we are
missing the wakeup capability on an SDIO interrupt.

Regards,
Madhu

> -----Original Message-----
> From: John Rigby [mailto:jcrigby@gmail.com]
> Sent: Wednesday, January 27, 2010 5:56 PM
> To: Madhusudhan
> Cc: Mike Rapoport; Dirk Behme; Phaneendra Kumar Alapati; linux-
> omap@vger.kernel.org; linux-mmc@vger.kernel.org; Adrian Hunter; Paasikivi
> Teemu.3 (EXT-Ixonos/Tampere)
> Subject: Re: sdio irq hack for omap_hsmmc.c (was: Re: [PATCH]
> OMAP35xx:SDIO IRQ Support for OMAP35xx)
> 
> Just to be clear, my post was in response to the reported problems
> with enabling sdio irqs with this patch:
> http://patchwork.kernel.org/patch/69122/
> 
> The patch originator reported good results but others reported
> complete failure.  My hack fixed the problem for me.  I believe this
> much more modest patch will also fix the problem but it is untested
> because I don't have a board running right now.  Beware, I'm sending
> this from gmail so it may get line wrapped but it is a trivial patch
> so I think it is understandable.
> 
> John
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index fa94580..7af970e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1727,10 +1727,16 @@ static int __init omap_hsmmc_probe
> 
>  	omap_hsmmc_context_save(host);
> 
> +#if 0
>  	mmc->caps |= MMC_CAP_DISABLE;
>  	mmc_set_disable_delay(mmc, OMAP_MMC_DISABLED_TIMEOUT);
>  	/* we start off in DISABLED state */
>  	host->dpm_state = DISABLED;
> +#else
> +	/* we start off in ENABLED state */
> +	host->dpm_state = ENABLED;
> +	clk_enable(host->fclk);
> +#endif
> 
>  	if (mmc_host_enable(host->mmc) != 0) {
>  		clk_put(host->iclk);
> 
> 
> On Wed, Jan 27, 2010 at 4:14 PM, Madhusudhan <madhu.cr@ti.com> wrote:
> > It is hard to comment on what is happening here without a patch. Is it a
> > performance issue or that SDIO functionality failure with PM enabled?
> >
> > The MMC controller supports wakeup capability on the dat1 line using a
> GPIO
> > for a SDIO interrupt. I guess that should help.
> >
> > Regards,
> > Madhu
> >

