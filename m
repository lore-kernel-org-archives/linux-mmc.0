From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v2 6/6] arm64: allwinner: a64: Increase the MMC max frequency
Date: Tue, 10 Jan 2017 01:01:20 +0800
Message-ID: <CAGb2v67JoOAtHjMJboNUdCDX=+=Hf+zOWr234rT7GEiUmPb=nQ@mail.gmail.com>
References: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
 <3689701f93c8426bfa476e9a5f31c3642a8a898e.1483980339.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3689701f93c8426bfa476e9a5f31c3642a8a898e.1483980339.git-series.maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 10, 2017 at 12:46 AM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> All the controllers can have a maximum frequency of 200MHz.
>
> Since older SoCs cannot go that high, we cannot change the default maximum
> frequency, but fortunately for us we have a property for that in the DT.
>
> This also has the side effect of allowing to use the MMC HS200 mode for the
> boards that support it (with either 1.2v or 1.8v IOs).
>
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
>  1 file changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 8e149498e096..f46ae965cf5b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -332,6 +332,7 @@
>                         resets = <&ccu RST_BUS_MMC0>;
>                         reset-names = "ahb";
>                         interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +                       max-frequency = <200000000>;

You also have to set one of MMC_CAP2_HS200* in the driver,
or mmc-hs200-1_8v or mmc-hs200-1_2v in the device tree to
actually use HS200, right?

ChenYu

>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -345,6 +346,7 @@
>                         resets = <&ccu RST_BUS_MMC1>;
>                         reset-names = "ahb";
>                         interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +                       max-frequency = <200000000>;
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -358,6 +360,7 @@
>                         resets = <&ccu RST_BUS_MMC2>;
>                         reset-names = "ahb";
>                         interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +                       max-frequency = <200000000>;
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> --
> git-series 0.8.11
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
