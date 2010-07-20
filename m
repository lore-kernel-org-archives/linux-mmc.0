From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not
 define
Date: Tue, 20 Jul 2010 13:21:16 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E3107D8@dbde02.ent.ti.com>
References: <1279607878-2405-1-git-send-email-s-ghorai@ti.com>
 <4C454B99.7090705@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44578 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922Ab0GTHv1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jul 2010 03:51:27 -0400
In-Reply-To: <4C454B99.7090705@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Tuesday, July 20, 2010 12:39 PM
> To: Ghorai, Sukumar
> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Shilimkar,
> Santosh; Chikkature Rajashekar, Madhusudhan; Andrew Morton
> Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not
> define
> 
> Sukumar Ghorai wrote:
> >     Issue if power_saving option passed from board file and CONFIG_PM
> not define.
> >     This is because hosts refer to wrong operation table and that try to
> power save.
> 
> power_saving is not related to power management.  It should work with or
> without
> CONFIG_PM.  What problem are you seeing?
[Ghorai] when CONFIG_PM is not defined but power_saving flag is TRUE, then host operation table point to table which handles in state machine as: ENABLE -> CARDSLEEP -> REGSLEEP -> DISABLED for power/clock cut. And do the reverse for the enable clock/power. 
And power saving is not required and wont work when CONFIG_PM is not enabled.

So if CONFIG_PM is not enable, then it should do simple clock disable/enable, and not via the power state machine.

> 
> >
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > CC: Madhusudhan Chikkature <madhu.cr@ti.com>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  Tested on omap3, omap4430 ES2.0
> >
> >  drivers/mmc/host/omap_hsmmc.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c
> b/drivers/mmc/host/omap_hsmmc.c
> > index b032828..f84eed0 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -2015,9 +2015,11 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
> >  	platform_set_drvdata(pdev, host);
> >  	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
> >
> > +#ifdef CONFIG_PM
> >  	if (mmc_slot(host).power_saving)
> >  		mmc->ops	= &omap_hsmmc_ps_ops;
> >  	else
> > +#endif
> >  		mmc->ops	= &omap_hsmmc_ops;
> >
> >  	/*
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

Regards,
Ghorai
