From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 2/2] mmc: sdhci: Ignore capability register when it comes to
 speeds and use DT binding instead when sdhci-cap-speed-modes-broken is set.
Date: Wed, 19 Oct 2016 09:10:39 +0200
Message-ID: <CAPDyKFrusfEcxWwM1ehXEAfoyK7UFihL30VQHc2bdEyZgzTu3g@mail.gmail.com>
References: <1476824736-9337-1-git-send-email-zach.brown@ni.com> <1476824736-9337-3-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476824736-9337-3-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 18 October 2016 at 23:05, Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org> wrote:
> When the sdhci-cap-speed-modes-broken DT property is set, the driver
> will ignore the bits of the capability registers that correspond to
> speed modes and will read the of properties of the device to determine
> which speeds are supported.

To me this seems like a great idea. Yeah, I proposed it so I guess
that's why. :-)

Anyway, it's Adrian call to decide how he want to go with this. He
might consider the other option [1] to be better.

Some more comments below.

>
> Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1e25b01..100649a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -22,6 +22,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
>
>  #include <linux/leds.h>
>
> @@ -3020,6 +3021,32 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
>  }
>  EXPORT_SYMBOL_GPL(__sdhci_read_caps);
>
> +void sdhci_get_speed_caps_from_of(struct sdhci_host *host)
> +{
> +       struct mmc_host *mmc = host->mmc;
> +
> +       host->caps &= ~SDHCI_CAN_DO_HISPD;
> +
> +       if (of_property_read_bool(mmc_dev(mmc)->of_node, "cap-sd-highspeed"))
> +               host->caps |= SDHCI_CAN_DO_HISPD;
> +
> +       if (host->version < SDHCI_SPEC_300)
> +               return;
> +
> +       host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
> +                        SDHCI_SUPPORT_DDR50);
> +
> +       if (of_property_read_bool(mmc_dev(mmc)->of_node, "sd-uhs-sdr50"))
> +               host->caps1 |= SDHCI_SUPPORT_SDR50;
> +
> +       if (of_property_read_bool(mmc_dev(mmc)->of_node, "sd-uhs-sdr104"))
> +               host->caps1 |= SDHCI_SUPPORT_SDR104;
> +
> +       if (of_property_read_bool(mmc_dev(mmc)->of_node, "sd-uhs-ddr50"))
> +               host->caps1 |= SDHCI_SUPPORT_DDR50;
> +

I don't think you need a separate OF parsing function. Instead the
SDHCI variant drivers may call mmc_of_parse() to parse the generic mmc
OF properties and then read the SDHCI caps registers (in some way or
the other).

As reading the SDHCI caps registers is done in __sdhci_read_caps(),
you could instead check for the OF property
"sdhci-cap-speed-modes-broken" in there,  and if it's set, clear the
related bits. I think that's all you need.

Note, the above code considers only SD speed modes, I assume we should
include eMMC speed modes to be broken as well!?

> +}
> +
>  int sdhci_setup_host(struct sdhci_host *host)
>  {
>         struct mmc_host *mmc;
> @@ -3046,6 +3073,10 @@ int sdhci_setup_host(struct sdhci_host *host)
>                 return ret;
>
>         sdhci_read_caps(host);
> +       if (of_property_read_bool(mmc_dev(mmc)->of_node,
> +                                 "sdhci-cap-speed-modes-broken"))
> +               sdhci_get_speed_caps_from_of(host);
> +
>
>         override_timeout_clk = host->timeout_clk;
>
> --
> 2.7.4
>

Kind regards
Uffe

[1]
http://www.spinics.net/lists/devicetree/msg146401.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
