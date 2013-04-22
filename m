From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/3] mmc: mvsdio: Support inverted CD and WP GPIO lines
Date: Mon, 22 Apr 2013 17:09:49 -0400
Message-ID: <20130422210949.GJ25724@titan.lakedaemon.net>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
 <1366660500-26835-2-git-send-email-gmbnomis@gmail.com>
 <87wqrutjss.fsf@octavius.laptop.org>
 <20130422203723.GI29947@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37081 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751628Ab3DVVJ7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Apr 2013 17:09:59 -0400
Content-Disposition: inline
In-Reply-To: <20130422203723.GI29947@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chris Ball <cjb@laptop.org>, gmbnomis@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, thomas.petazzoni@free-electrons.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Mon, Apr 22, 2013 at 10:37:23PM +0200, Andrew Lunn wrote:
> On Mon, Apr 22, 2013 at 04:03:15PM -0400, Chris Ball wrote:
> > Hi Simon,
> > 
> > On Mon, Apr 22 2013, Simon Baatz wrote:
> > > diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> > > index 145cdaf..d444efd 100644
> > > --- a/drivers/mmc/host/mvsdio.c
> > > +++ b/drivers/mmc/host/mvsdio.c
> > > @@ -691,6 +691,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
> > >  	struct resource *r;
> > >  	int ret, irq;
> > >  	int gpio_card_detect, gpio_write_protect;
> > > +	enum of_gpio_flags gpio_flags;
> > >  	struct pinctrl *pinctrl;
> > >  
> > >  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > @@ -731,8 +732,17 @@ static int __init mvsd_probe(struct platform_device *pdev)
> > >  		}
> > >  
> > >  		host->base_clock = clk_get_rate(host->clk) / 2;
> > > -		gpio_card_detect = of_get_named_gpio(np, "cd-gpios", 0);
> > > -		gpio_write_protect = of_get_named_gpio(np, "wp-gpios", 0);
> > > +		gpio_card_detect = of_get_named_gpio_flags(np, "cd-gpios", 0,
> > > +						     &gpio_flags);
> > > +		if (gpio_is_valid(gpio_card_detect) &&
> > > +		    !(gpio_flags & OF_GPIO_ACTIVE_LOW))
> > > +			mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> > > +
> > > +		gpio_write_protect = of_get_named_gpio_flags(np, "wp-gpios", 0,
> > > +						       &gpio_flags);
> > > +		if (gpio_is_valid(gpio_write_protect) &&
> > > +		    !(gpio_flags & OF_GPIO_ACTIVE_LOW))
> > > +			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> > >  	} else {
> > >  		const struct mvsdio_platform_data *mvsd_data;
> > >  		mvsd_data = pdev->dev.platform_data;
> > 
> > The core function mmc_of_parse() (new in 3.9) will do all of this DT
> > parsing for you, and will also take care of the driver's later calls
> > to mmc_gpio_request_{cd,wp}().  Could you try using that function
> > instead, please?
> 
> Hi Chris, Simon
> 
> I have a vague recollection that Thomas Petazzoni already did this
> conversion. Take a look in linux-next, or maybe Jason can point you at
> a branch.

Andrew,

Thomas did a board conversion here (slated for v3.11 in /pcie branch):

  cd2bde5 arm: kirkwood: convert db-88f6281 to the Device Tree

And Sebastian did some mvsdio WP and CD pin work here:

  0d0644eARM: Kirkwood: fix unused mvsdio gpio pins

Nothing else really jumps out though.  Where either of these what you
were thinking of?

thx,

Jason.
