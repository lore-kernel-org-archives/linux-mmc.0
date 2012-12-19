From: Luciano Coelho <coelho@ti.com>
Subject: Re: 32kHz clock removal causes problems omap_hsmmc
Date: Wed, 19 Dec 2012 13:07:13 +0200
Message-ID: <1355915233.5273.23.camel@cumari.coelho.fi>
References: <1352968293.10872.51.camel@cumari.coelho.fi>
	  <20121218095450.GB27751@arwen.pp.htv.fi>
	  <20121219094552.GN4985@opensource.wolfsonmicro.com>
	  <50D19040.5090404@ti.com>
	  <20121219100909.GO4985@opensource.wolfsonmicro.com>
	  <50D19463.5010605@ti.com>
	  <20121219103206.GQ4985@opensource.wolfsonmicro.com>
	 <1355913954.5273.21.camel@cumari.coelho.fi> <50D19D54.2000307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <50D19D54.2000307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Felipe Balbi <balbi@ti.com>, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, lrg@ti.com, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2012-12-19 at 11:56 +0100, Peter Ujfalusi wrote:
> On 12/19/2012 11:45 AM, Luciano Coelho wrote:
> >> Well, we still haven't got the foggiest idea what the actual problem is
> >> beyond that it's probably related to the 32kHz clock in some way (unless
> >> it was one of the other reverts that coincidentally made a difference,
> >> but we don't know what they were) so it's unlikely that just randomly
> >> implementing clock support is going to fix anything immediately here.
> > 
> > This is exactly what I had to revert (as I mentioned in the other email,
> > I had to revert the other patches otherwise compilation would break):
> > 
> > 0e8e5c34 "regulator: twl: Remove references to 32kHz clock from DT bindings"
> > e76ab829 "regulator: twl: Remove references to the twl4030 regulator"
> > 029dd3ce "regulator: twl: Remove another unused variable warning"
> 
> Yeah. 32k clock is not provided by twl.
> 
> As I said I need to take a look at CCF to see if it already there. If it is
> clock driver + mapping + patch for wl12xx should fix the issue you are facing.
> 
> > Let me know if you need more info.
> 
> BTW: have you happened to ubdate u-boot recently? There is a nice easter egg
> added there:
> f3f98bb ARM: OMAP4/5: Do not configure non essential pads, clocks, dplls.
> 
> Which means that _essential_ clocks and pads are no longer configured.

Actually no, I haven't updated my u-boot for a while.  I'll check if
that improves things.

--
Luca.

