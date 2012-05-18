From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 07/29] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Fri, 18 May 2012 11:28:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205181059560.23140@axis700.grange>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-8-git-send-email-g.liakhovetski@gmx.de>
 <20120503154252.GO3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120503154252.GO3955@opensource.wolfsonmicro.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 3 May 2012, Mark Brown wrote:

> On Thu, May 03, 2012 at 05:05:36PM +0200, Guennadi Liakhovetski wrote:
> 
> > +	ret = mmc_regulator_get_ocrmask(supply);
> > +	if (ret > 0)
> > +		mmc->ocr_avail = ret;
> > +
> > +	if (regulator_can_change_status(supply)) {
> > +		mmc->caps |= MMC_CAP_POWER_OFF_CARD;
> > +		return supply;
> > +	}
> > + 
> > +	devm_regulator_put(supply);
> > +
> > +	if (ret <= 0)
> > +		dev_warn(dev, "Ignoring useless (dummy?) regulator\n");
> 
> This code seems very tricky and a bit confusing - you're checking that
> either you can change the voltage or change the status but you're doing
> it in a fairly abstruse way and it'll come out as saying that a fixed
> voltage regulator is a useful regulator to have which probably isn't what
> you want if it's worth ignoring a dummy regulator.

This function handles 3 cases:

1. A regulator that can (in principle) change state, i.e., switch on and 
off. Such a regulator is good to keep for the runtime to power up and down 
the card.
2. A regulator, that cannot switch, but at least can tell its supplied 
voltage is used ones to read out supported voltages and released again.
3. A regulator that can do none of the above is defined as "useless"

So, a fixed voltage regulator is indeed a useful one - it can tell us the 
voltage and maybe even switch power. A dummy regulator can do none of the 
above.

> You may also run into trouble on boards that use the ability to disable
> unused regulators at the end of boot - they'll power things off even
> without the ability to change status at runtime.

Aha, you mean, I shouldn't put() the regulator, even if it cannot change 
status itself? Can this also happen with a dummy regulator?

> It'd at least be nice to write things more directly, or add some
> comments.

Hm, sure, I can add some comments:-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
