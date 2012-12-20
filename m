From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: Re: omap_hsmmc: SDIO IRQ on AM335x family
Date: Thu, 20 Dec 2012 23:04:44 +0100
Message-ID: <20121220220444.GA350@blumentopf>
References: <20121130111847.GA24674@blumentopf>
 <20121130174022.GM5312@atomide.com>
 <50B9019F.2020109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50B9019F.2020109@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Nov 30, 2012 at 07:57:35PM +0100, Daniel Mack wrote:
> 
> On 30.11.2012 18:40, Tony Lindgren wrote:
> > * Andreas Fenkart <andreas.fenkart@streamunlimited.com> [121130 03:21]:
> >>
> >> The alternative was to configure dat1 line as a GPIO, while
> >> waiting for an IRQ. Then configuring it back as dat1 when the
> >> SDIO card is signalling an IRQ. Or the host starts a transfer. I
> >> guess this will perform poorly, hence not considering it really.
> > 
> > This might work for SDIO cards. It should be disabled for data
> > cards naturally to avoid potential data corruption.
I don't understand your concern here, could you explain

> > The way to implement this is set named states in the .dts file
> > for the pins using pinctrl-single.c, then have the MMC driver
> > request states "default" "active" and "idle" during the probe,
> > then toggle between active and idle during the runtime.
> > 
> > As far as I remember the GPIO functionality does not need to
> > be enabled, just muxing the pin to GPIO mode for the wake-up
> > is enough.
> 
> Wouldn't that be racy, given that an interrupt which occurs at beween
> the point in time when the driver decides to wait for IRQs again until
> the mux has finished switching over, could potentially be lost?

The IRQ is level triggered, so can't be lost. I implemented it as
suggested and surprisingly performance is pretty good. Actually not
worse than keeping the fclk enabled all times.

module: 88W8787 / mwifiex
tx bitrate: 150.0 MBit/s MCS 7 40Mhz short GI

                   |   tcp tx         |  signal  | cpu idle
---------------------------------------------------------------
keep fclk enabled  |   50.3 Mbits/sec | -23 dBm  | 15 %
suspend/resume     |   49.7 Mbits/sec | -22 dBM  | 13 %

patch follows

/Andi
