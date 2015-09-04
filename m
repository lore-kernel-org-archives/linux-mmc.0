From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/2] regulator: Fix pbias regulator enable
Date: Fri, 4 Sep 2015 14:44:55 +0200
Message-ID: <CAPDyKFqCYx0JfXGq0T-44034UcR=v8nvKp7Fww=Zxa7N-z_vFg@mail.gmail.com>
References: <1441368025-21182-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441368025-21182-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 4 September 2015 at 14:00, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> vsel_reg and enable_reg of the pbias regulator descriptor should actually
> have the offset from syscon.
>
> However after
> "ARM: dts: <platform>: add minimal l4 bus layout with control module
> support"
> vsel_reg and enable_reg started to have the absolute address because
> of address translation that happens due to pbias node made as the
> child node of syscon. This breaks the pbias regulator enable.
>
> This series adds the 'offset' to be populated in vsel_reg and enable_reg
> in the pbias driver itself.
>
> Changes from v2:
> *) Squashed all the dt patches into a single patch
>
> Changes from v1:
> *) Fixed Tony's review comments on adding a 'comment' for adding offset in
>    the driver and adding a warning for using platform_get_resource.
> *) Added Tony's Acked-by.
>
> Tested these patches against mmc -next in omap4 panda, omap3 beagle xm,
> dra72 and omap5 uevm
>
> Kishon Vijay Abraham I (2):
>   regulator: pbias: program pbias register offset in pbias driver
>   ARM: dts: <omap2/3/4/5/dra7>: use "ti,pbias-<platform>" compatible
>     string for pbias
>
>  .../bindings/regulator/pbias-regulator.txt         |    7 ++-
>  arch/arm/boot/dts/dra7.dtsi                        |    2 +-
>  arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
>  arch/arm/boot/dts/omap3.dtsi                       |    2 +-
>  arch/arm/boot/dts/omap4.dtsi                       |    2 +-
>  arch/arm/boot/dts/omap5.dtsi                       |    2 +-
>  drivers/regulator/pbias-regulator.c                |   56 +++++++++++++++++---
>  7 files changed, 61 insertions(+), 12 deletions(-)
>
> --
> 1.7.9.5
>

Okay, just to be clear on the way forward. I spoked with Mark Brown
offlist, and he will/has picked up the regulator patch and will send
it as fix for the 4.3 rc[n].

Regarding the ARM patch here, I guess Tony might as well handle it and
send through arm-soc, especially since the regression won't be fixed
within my mmc tree anyway.

So, I am going to leave my next branch as is - and thus relying on
that the regression for OMAP will be fixed in some the 4.3 rc[n].

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
