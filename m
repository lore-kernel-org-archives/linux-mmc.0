From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 03/11] Documentation: mmc: sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs
Date: Mon, 13 Jun 2016 11:32:18 +0200
Message-ID: <1678454.YQFjtBiLV1@diego>
References: <1465339484-969-1-git-send-email-dianders@chromium.org> <1465339484-969-4-git-send-email-dianders@chromium.org> <45a7e8c7-5bd4-8c40-004a-b8906eff881a@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <45a7e8c7-5bd4-8c40-004a-b8906eff881a-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Am Montag, 13. Juni 2016, 16:18:24 schrieb Shawn Lin:
> On 2016/6/8 6:44, Douglas Anderson wrote:
> > As can be seen in Arasan's datasheet [1] there are several "corecfg"
> > settings in their SDHCI IP Block that are supposed to be controlled by
> > software.  Although the datasheet referenced is a bit vague about how to
> > access corecfg, in Figure 5 you can see that for Arasan's PHY (a
> > separate component than their SDHCI component) they describe the
> > "phyctrl" registers as being "FROM SOC CTL REG", implying that it's up
> > to the licensee of the Arasan IP block to implement these registers.  It
> > seems sane to assume that the "corecfg" registers in their SDHCI IP
> > block works in a similar way for all licensees of the IP Block.
> > 
> > Device tree has a model that allows a device to get a reference to
> > random registers located elsewhere in the SoC: sysctl.  Let's leverage
> > this model and allow adding a sysctl reference to access the control
> > registers for the Arasan SDHCI PHYs.
> > 
> > Having a reference to the control registers doesn't do much for us on
> > its own since the Arasan spec doesn't specify how these corecfg values
> > are laid out in memory.  In the SDHCI driver we'll need a map detailing
> > where each corecfg can be found in each implementation.  This map can be
> > found using the primary compatible string of the SDHCI device.  In that
> > spirit, document that existing rk3399 device trees already have a
> > specific compatible string, though up to now they've always been relying
> > on the driver supporting the generic.
> > 
> > Note that since existing devices seem to work fairly well as-is, we'll
> > list the syscon reference as "optional", but it's likely that we'll run
> > into much fewer problems if we can actually set the proper values in the
> > syscon, so it is strongly suggested that any SoCs where we have a map to
> > set the corecfg also include a reference to the syscon.
> 
> yes, the interaction of phy and controller should be more explicitly
> now. Why not make it mandatory for arasan,sdhci-5.1.

The omnipresent backwards-compatiblity :-) .

The binding did not require any of this in the past, so the driver should 
always also work with devicetrees created according to this old binding.

And obviously it was working without that before as well, as Doug stated.


Heiko

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
