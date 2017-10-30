From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 00/12] mmc: mediatek: add support of mt2701/mt2712
Date: Mon, 30 Oct 2017 12:39:59 +0100
Message-ID: <CAPDyKFr+Zc_u=YYhtzF0tRS0Pp08cKkGrJwoGDQympOF4M=HwA@mail.gmail.com>
References: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1508118399-21828-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 16 October 2017 at 03:46, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>   This serial of patches are adding support of mt2701/mt2712.
> there are many changes and HW improvement between mt8173 and
> mt2701/mt2712, below is a list of these changes:
>   1. enlarge CLKDIV bits from 8 to 12
>   2. remove the PAD_TUNE register and add a new PAD_TUNE0 register
>   3. add data sync and async fifo feature
>   4. add busy_check feature
>   5. add stop_clk fix
>   6. add enhance_rx support
>   7. add a seperate CG of source clock
>
>   mt2712 supports full of these features, mt2701 supports part of it, and
> add a "mediatek,latch-ck" to work-around as it do not support stop-clk fix.
>
> Note: As Pinctrl/CCF are not ready now, so that current patches do not
> include DTS part.
>
> Changed vs v5:
>   based on Rob's comments, explain why MT8173 no longer compatible with
> driver that supports "mediatek,mt8135-mmc", add more clearly description
> of "mediatek,latch-ck".
>
> Changed vs v4:
>   based on Julien's comment, change the "bool pad_tune0" to "u32 pad_tune_reg".
>
> Changed vs v3:
>   based on Ulf's comments, make the bindings change to be the first patch.
>
> Changed vs v2:
>   based on Matthias's comments, merge binding file changes to one patch,
> add "hs400_tune" flag in dev_comp.
>
> Changed vs v1:
>   based on Ulf/Rob/Matthias's comments of DTS binding file, make the binding
> file clearly and fix probe issue.
>
>
> Chaotian Jing (12):
>   mmc: dt-bindings: Add reg/source_cg/latch-ck for Mediatek MMC bindings
>   mmc: mediatek: add support of mt2701/mt2712
>   arm64: dts: mt8173: remove "mediatek,mt8135-mmc" from mmc nodes
>   mmc: mediatek: make hs400_tune_response only for mt8173
>   mmc: mediatek: add pad_tune0 support
>   mmc: mediatek: add async fifo and data tune support
>   mmc: mediatek: add busy_check support
>   mmc: mediatek: add stop_clk fix and enhance_rx support
>   mmc: mediatek: add support of source_cg clock
>   mmc: mediatek: add latch-ck support
>   mmc: mediatek: improve eMMC hs400 mode read performance
>   mmc: mediatek: perfer to use rise edge latching for cmd line
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |  18 +-
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi         |  12 +-
>  drivers/mmc/host/mtk-sd.c                        | 283 ++++++++++++++++++++---
>  3 files changed, 265 insertions(+), 48 deletions(-)
>

Thanks, applied the hole series on my next branch.

If Matthias wants to pick/ack the DT change (patch3), I either add his
ack or drop that patch from my tree.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
