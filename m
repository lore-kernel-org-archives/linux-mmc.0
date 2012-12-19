From: Luciano Coelho <coelho@ti.com>
Subject: Re: 32kHz clock removal causes problems omap_hsmmc
Date: Wed, 19 Dec 2012 12:45:54 +0200
Message-ID: <1355913954.5273.21.camel@cumari.coelho.fi>
References: <1352968293.10872.51.camel@cumari.coelho.fi>
	 <20121218095450.GB27751@arwen.pp.htv.fi>
	 <20121219094552.GN4985@opensource.wolfsonmicro.com>
	 <50D19040.5090404@ti.com>
	 <20121219100909.GO4985@opensource.wolfsonmicro.com>
	 <50D19463.5010605@ti.com>
	 <20121219103206.GQ4985@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121219103206.GQ4985@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Felipe Balbi <balbi@ti.com>, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, lrg@ti.com, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2012-12-19 at 10:32 +0000, Mark Brown wrote:
> On Wed, Dec 19, 2012 at 11:18:11AM +0100, Peter Ujfalusi wrote:
> 
> > Sure. It must be a clock driver. I already have similar driver (for McPDM fclk
> > clock) for twl6040.
> > Let me check linux-next, if CCF is there for OMAP I can send the 32k clock
> > driver soon (after writing it and testing it). It is going to be for 3.9 but
> > we can roll it with us I think locally to resolv issues.
> 
> Well, we still haven't got the foggiest idea what the actual problem is
> beyond that it's probably related to the 32kHz clock in some way (unless
> it was one of the other reverts that coincidentally made a difference,
> but we don't know what they were) so it's unlikely that just randomly
> implementing clock support is going to fix anything immediately here.

This is exactly what I had to revert (as I mentioned in the other email,
I had to revert the other patches otherwise compilation would break):

0e8e5c34 "regulator: twl: Remove references to 32kHz clock from DT bindings"
e76ab829 "regulator: twl: Remove references to the twl4030 regulator"
029dd3ce "regulator: twl: Remove another unused variable warning"

Let me know if you need more info.

--
Luca.

