From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 08/29] mmc: sh_mmcif: add regulator support
Date: Fri, 18 May 2012 11:35:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205181132170.23140@axis700.grange>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-9-git-send-email-g.liakhovetski@gmx.de>
 <20120503154532.GP3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120503154532.GP3955@opensource.wolfsonmicro.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 3 May 2012, Mark Brown wrote:

> On Thu, May 03, 2012 at 05:05:37PM +0200, Guennadi Liakhovetski wrote:
> 
> > +#include <linux/regulator/consumer.h>
> 
> Where's this used?

You're right, it's not. A forward declaration of struct regulator would 
suffice.

> > +static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
> > +{
> > +	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
> > +
> > +	if (!(host->mmc->caps & MMC_CAP_POWER_OFF_CARD))
> > +		return;
> 
> Surely the core should be implementing this?

Hm, actually, I don't think so. sh_mmcif_set_power() is called as a part 
of the driver's .set_ios() method. The core has to call that method 
regardless whether MMC_CAP_POWER_OFF_CARD is set or not. Only inside that 
method we can decide, that a part of its functionality (power on / off) is 
unavailable.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
