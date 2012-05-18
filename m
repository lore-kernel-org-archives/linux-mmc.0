From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 13/29] mmc: tmio: add regulator support
Date: Fri, 18 May 2012 11:55:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205181137570.23140@axis700.grange>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-14-git-send-email-g.liakhovetski@gmx.de>
 <20120503155655.GQ3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52072 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759137Ab2ERJzz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 May 2012 05:55:55 -0400
In-Reply-To: <20120503155655.GQ3955@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, 3 May 2012, Mark Brown wrote:

> On Thu, May 03, 2012 at 05:05:42PM +0200, Guennadi Liakhovetski wrote:
> 
> > +static void tmio_mmc_set_power(struct tmio_mmc_host *host, struct mmc_ios *ios)
> > +{
> > +	if (!(host->mmc->caps & MMC_CAP_POWER_OFF_CARD))
> > +		return;
> > +
> > +	if (host->vdd)
> > +		/* Errors ignored... */
> > +		mmc_regulator_set_ocr(host->mmc, host->vdd,
> > +				      ios->power_mode ? ios->vdd : 0);
> > +	else if (host->set_pwr)
> > +		host->set_pwr(host->pdev, ios->power_mode != MMC_POWER_OFF);
> > +}
> 
> This looks pretty much identical to the previous code,

Maybe it's because it's been written and is maintained by the same group 
of people? :-)

> should it be being factored out into the core?

Weeeell, it's not a lot of code. We could make this a library function, 
provided by the core, but I don't think it would be very straight forward 
to also automate its calling, thus freeing individual drivers from this 
task. As you can see in these two drivers, one of them turns the card on 
already upon MMC_POWER_UP, the other one only in MMC_POWER_ON. I'm not 
sure off the top of my head why this difference is there, but in any case 
different drivers might have different ideas about this. So, I'm not sure 
whether this micro-optimisation is worth it.

> Or put the regulator bit in the core
> and provide an option to override with manual callbacks if that's
> required.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
