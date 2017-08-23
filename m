From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Wed, 23 Aug 2017 15:07:54 +0200
Message-ID: <CAPDyKFp7gchVQ+JPNqv4LktvHRm2Lzx6KakOw85zEZxDEX0OhA@mail.gmail.com>
References: <20170821142132.GH6008@atomide.com> <20170823054246.23927-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170823054246.23927-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2017 at 07:42, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> Add binding for the TI's sdhci-omap controller. This now includes only
> a subset of properties documented in ti-omap-hsmmc.txt but will eventually
> include all the properties.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
> Changes from v2:
> *) Fixed example to use the updated compatible
>
> Changes from v1:
> *) Create a new sdhci-omap.txt document for TI's sdhci-omap controller instead
>    of using the ti-omap-hsmmc.txt as suggested by Tony
>  .../devicetree/bindings/mmc/sdhci-omap.txt         | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> new file mode 100644
> index 000000000000..139695ad2d58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> @@ -0,0 +1,22 @@
> +* TI OMAP SDHCI Controller
> +
> +Refer to mmc.txt for standard MMC bindings.
> +
> +Required properties:
> +- compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
> +- ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
> +
> +Optional properties:
> +- ti,dual-volt: boolean, supports dual voltage cards
> +- ti,non-removable: non-removable slot (like eMMC)
> +
> +Example:
> +       mmc1: mmc@0x4809c000 {
> +               compatible = "ti,dra7-sdhci";
> +               reg = <0x4809c000 0x400>;
> +               ti,hwmods = "mmc1";
> +               ti,dual-volt;
> +               bus-width = <4>;
> +               vmmc-supply = <&vmmc>; /* phandle to regulator node */
> +               ti,non-removable;
> +       };
> --
> 2.11.0
>

I am wondering a bit on the long term plan here.

Ideally at some point in future, we would like to remove the old
omap_hsmmc driver, but from compatible string point of view, that
means we first needs to deprecate the old ones for a while. Right?

That said, what is then the reason to why we should bring over the
existing omap_hsmmc bindings to the sdhci-omap bindings?

For example, "ti,dual-volt" can likely be replaced with something
better that already exists (either a common mmc binding or an sdhci
binding). For "ti,non-removable", we already have a common mmc binding
"non-removable" for this.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
