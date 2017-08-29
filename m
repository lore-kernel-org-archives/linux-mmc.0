From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 29 Aug 2017 12:09:20 -0500
Message-ID: <20170829170920.xpgk5ywlvfgrtbqi@rob-hp-laptop>
References: <20170821142132.GH6008@atomide.com>
 <20170823054246.23927-1-kishon@ti.com>
 <CAPDyKFp7gchVQ+JPNqv4LktvHRm2Lzx6KakOw85zEZxDEX0OhA@mail.gmail.com>
 <c9342689-f09e-44af-0975-d43ef122a477@ti.com>
 <CAPDyKFqCZFM7UmHyQCm=DwwZXJvzUde3pW0HqARKrsgfgxSuaw@mail.gmail.com>
 <0c7e0705-d9c2-4499-54ba-cbd84589dc01@ti.com>
 <20170829115050.3axlr5uysmqlhvd2@earth>
 <20170829135822.GR6008@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170829135822.GR6008-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 29, 2017 at 06:58:23AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170829 04:51]:
> > On Tue, Aug 29, 2017 at 04:50:22PM +0530, Kishon Vijay Abraham I wrote:
> > > On Thursday 24 August 2017 04:59 PM, Ulf Hansson wrote:
> > > > I guess we have two options.
> > > > 
> > > > 1) Allow us to invent and use new bindings - and a new compatible.
> > > > When everything is implemented in sdhci-omap, we can deprecate the old
> > > > omap_hsmmc driver and its corresponding compatible/bindings. At some
> > > > point later we can remove the legacy driver/bindings altogether - of
> > > > course that might take a while. This option allows us to re-think some
> > > > of the old bindings and really clean up some if its related code. For
> > > > example, I think "ti,dual-volt" is a bad binding. Instead it would be
> > > > better to use the existing mmc bindings about which speed mode the
> > > > controller/board supports (as the voltage level comes with it).
> > > > 
> > > > 2) Invent only a new compatible, but stick to use the old omap hsmmc
> > > > bindings and thus also deploy the similar code dealing with them. When
> > > > everything is implemented move the old omap_hsmmc compatibles into the
> > > > new sdhci-omap driver and them remove the old omap_hsmmc driver. At
> > > > that point we could also deprecate the old omap hsmmc compatibles, but
> > > > to me that is rather pointless.
> > > > 
> > > > The two options has different advantages, feel free to pick any of them!
> > > 
> > > Okay. I'll send a new version with option '1' (new compatible/new bindings).
> 
> Agreed.
> 
> > > And when we deprecate the omap_hsmmc driver (some time later), we'll add
> > > support for the legacy bindings in sdhci-omap driver (so that old dtbs continue
> > > to work). Tony, are you okay with this?
> > 
> > I think you should Cc Rob Herring and Mark Rutland (DT binding
> > maintainers). This sounds like "I use DT to describe driver
> > behaviour" instead of "I use DT to describe hardware".

Indeed...

> 
> Yes please.
> 
> > I would expect the conversion to look like the one done for UART,
> > see CONFIG_SERIAL_OMAP vs CONFIG_SERIAL_8250_OMAP. Both use the
> > same compatible value and you can choose using kernel configuration.
> 
> That does not work unfortunately :( We are now stuck in a situation
> where two drivers are attempting to probe with the same compatible
> and we can't enable 8250_OMAP because of the user space breakage
> with the device names. And I'm actuallly thinking we should add a
> new compatible for 8250-omap to be able to start enabling it one
> board at a time.

Is that the only problem? Presumably, the SD driver doesn't have a 
userspace facing issue.

> It's best to enable devices to use the new compatible as things are
> tested rather than hope for some magic "flag day" flip that might
> never happen. Having two days attempting to probe with the same
> binding just won't work.

Aren't you just picking whether the flag day is in DT or the kernel? I 
guess you're assuming one kernel build and it would be switching all 
boards at one. 

> So yeah, I agree with Kishon that we should stick with generic
> and sdhci bindings. And then we can start already using it for
> boards that can use it, then eventually when we're ready, start
> parsing also the legacy bindings and maybe drop the old driver.

I assume there are some other common properties you would switch to in 
the transition?  You could make the legacy driver bail from probe based 
on presence or absence of other properties. Or you could just blacklist 
converted platforms in the legacy driver. The point is that the problems 
are solvable in the kernel.

But if your really want a new compatible, I don't really care. It's 
only one device.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
