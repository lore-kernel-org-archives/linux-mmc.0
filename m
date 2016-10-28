From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/2] mmc: sdhci: dt: Add device tree properties sdhci-caps
 and sdhci-caps-mask
Date: Fri, 28 Oct 2016 10:12:33 +0200
Message-ID: <CAPDyKFpKoXd9yuX5vR-CACtXKGysmV0AqKnjxQ+hTGU+kgwceQ@mail.gmail.com>
References: <1477425538-3315-1-git-send-email-zach.brown@ni.com> <1477425538-3315-2-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1477425538-3315-2-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 25 October 2016 at 21:58, Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org> wrote:
> On some systems the sdhci capabilty registers are incorrect for one
> reason or another.
>
> The sdhci-caps-mask property specifies which bits in the registers
> are incorrect and should be turned off before using sdhci-caps to turn
> on bits.
>
> The sdhci-caps property specifies which bits should be turned on.
>
> Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 8a37782..1415aa0 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt

The bindings in this document are common mmc DT bindings, not bindings
specific to a mmc controller.

So unless these bindings are applicable for another controller than
sdhci, I suggest we create a new file to document these.
How about Documentation/devicetree/bindings/mmc/sdhci.txt?

> @@ -52,6 +52,13 @@ Optional properties:
>  - no-sdio: controller is limited to send sdio cmd during initialization
>  - no-sd: controller is limited to send sd cmd during initialization
>  - no-mmc: controller is limited to send mmc cmd during initialization
> +- sdhci-caps-mask: The sdhci capabilities registers are incorrect. This 64bit

/s/registers/register

This applies to some more places below as well.

> +  property corresponds to the bits in the sdhci capabilty registers. If the bit
> +  is on in the mask then the bit is incorrect in the registers and should be
> +  turned off.
> +- sdhci-caps: The sdhci capabilities registers are incorrect. This 64bit
> +  property corresponds to the bits in the sdhci capability registers. If the
> +  bit is on in the property then the bit should be on in the reigsters.

/s/reigsters/register

>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> --
> 2.7.4
>

Overall, I like this idea as it gives us good flexibility. Thus it
should avoid us to having to add any further new similar "sdhci broken
cap" DT binding. We could also decide to start deprecate some of the
existing sdhci bindings, if we think that makes sense.

The downside is that we get a "magic" hex value in the dts. Although,
people could address this issue by providing some comments about what
the bits it means in the dts files themselves.

Let's see what Rob thinks about this.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
