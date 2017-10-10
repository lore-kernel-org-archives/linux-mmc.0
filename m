From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 03/12] arm64: dts: mt8173: remove "mediatek,mt8135-mmc"
 from mmc nodes
Date: Tue, 10 Oct 2017 12:49:02 +0200
Message-ID: <CAPDyKFrtBr_f2HxsNsLQ1s+-9Toni8pC82gFdVcHY+oQSPqOBA@mail.gmail.com>
References: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com> <1507627831-29323-4-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1507627831-29323-4-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 10 October 2017 at 11:30, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> devicetree bindings has been updated to support multi-platforms,
> so that each platform has its owns compatible name.
> And, this compatible name may used in driver to distinguish with
> other platform.
>
> Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

I assume there is no dependency to the rest or the series on this, so
this can go via arm soc?

Kind regards
Uffe

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index b99a273..26396ef 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -682,8 +682,7 @@
>                 };
>
>                 mmc0: mmc@11230000 {
> -                       compatible = "mediatek,mt8173-mmc",
> -                                    "mediatek,mt8135-mmc";
> +                       compatible = "mediatek,mt8173-mmc";
>                         reg = <0 0x11230000 0 0x1000>;
>                         interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
>                         clocks = <&pericfg CLK_PERI_MSDC30_0>,
> @@ -693,8 +692,7 @@
>                 };
>
>                 mmc1: mmc@11240000 {
> -                       compatible = "mediatek,mt8173-mmc",
> -                                    "mediatek,mt8135-mmc";
> +                       compatible = "mediatek,mt8173-mmc";
>                         reg = <0 0x11240000 0 0x1000>;
>                         interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
>                         clocks = <&pericfg CLK_PERI_MSDC30_1>,
> @@ -704,8 +702,7 @@
>                 };
>
>                 mmc2: mmc@11250000 {
> -                       compatible = "mediatek,mt8173-mmc",
> -                                    "mediatek,mt8135-mmc";
> +                       compatible = "mediatek,mt8173-mmc";
>                         reg = <0 0x11250000 0 0x1000>;
>                         interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
>                         clocks = <&pericfg CLK_PERI_MSDC30_2>,
> @@ -715,8 +712,7 @@
>                 };
>
>                 mmc3: mmc@11260000 {
> -                       compatible = "mediatek,mt8173-mmc",
> -                                    "mediatek,mt8135-mmc";
> +                       compatible = "mediatek,mt8173-mmc";
>                         reg = <0 0x11260000 0 0x1000>;
>                         interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_LOW>;
>                         clocks = <&pericfg CLK_PERI_MSDC30_3>,
> --
> 1.8.1.1.dirty
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
