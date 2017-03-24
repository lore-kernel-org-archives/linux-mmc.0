From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/3] mmc: dt-bindings: update Mediatek MMC bindings
Date: Fri, 24 Mar 2017 08:18:14 +0100
Message-ID: <CAPDyKFpj=xU_-sR_2kPnfmjGLGjWm+Zw1G3mB2naMz09jHJcAw@mail.gmail.com>
References: <1489562800-27431-1-git-send-email-yong.mao@mediatek.com> <1489562800-27431-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489562800-27431-2-git-send-email-yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 15 March 2017 at 08:26, Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> From: yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>
> Add description for mediatek,hs200-cmd-int-delay
> Add description for mediatek,hs400-cmd-int-delay
> Add description for mediatek,hs400-cmd-resp-sel-rising
>
> Signed-off-by: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 0120c7f..4182ea3 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -21,6 +21,15 @@ Optional properties:
>  - assigned-clocks: PLL of the source clock
>  - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
>  - hs400-ds-delay: HS400 DS delay setting
> +- mediatek,hs200-cmd-int-delay: HS200 command internal delay setting.
> +                               This field has total 32 stages.
> +                               The value is an integer from 0 to 31.
> +- mediatek,hs400-cmd-int-delay: HS400 command internal delay setting
> +                               This field has total 32 stages.
> +                               The value is an integer from 0 to 31.
> +- mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
> +                                      If present,HS400 command responses are sampled on rising edges.
> +                                      If not present,HS400 command responses are sampled on falling edges.
>
>  Examples:
>  mmc0: mmc@11230000 {
> @@ -38,4 +47,7 @@ mmc0: mmc@11230000 {
>         assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
>         assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
>         hs400-ds-delay = <0x14015>;
> +       mediatek,hs200-cmd-int-delay = <26>;
> +       mediatek,hs400-cmd-int-delay = <14>;
> +       mediatek,hs400-cmd-resp-sel-rising;
>  };
> --
> 1.7.9.5
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
