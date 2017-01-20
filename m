From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mmc: dt-bindings: update Mediatek MMC bindings
Date: Fri, 20 Jan 2017 08:52:25 +0100
Message-ID: <CAPDyKFpXA_fDDQi+gqf2f3dFxkjH6D+7drTPuimuJafWxoCirg@mail.gmail.com>
References: <1484821156-20565-1-git-send-email-yong.mao@mediatek.com>
 <1484821156-20565-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1484821156-20565-2-git-send-email-yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

+devicetree, Rob

On 19 January 2017 at 11:19, Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> From: yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>
> Add description for mtk-hs200-cmd-int-delay
> Add description for mtk-hs400-cmd-int-delay
> Add description for mtk-hs400-cmd-resp-sel
>
> Signed-off-by: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 0120c7f..149f472 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -21,6 +21,12 @@ Optional properties:
>  - assigned-clocks: PLL of the source clock
>  - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
>  - hs400-ds-delay: HS400 DS delay setting
> +- mtk-hs200-cmd-int-delay: HS200 command internal delay setting.
> +                          The value is an integer from 0 to 31

Please change to:

mediatek,hs200-cmd-delay

... and if there is a unit, like ns or us, please add that a suffix.

> +- mtk-hs400-cmd-int-delay: HS400 command internal delay setting
> +                          The value is an integer from 0 to 31

mediatek,hs400-cmd-delay and add unit if applicable.

> +- mtk-hs400-cmd-resp-sel:  HS400 command response sample selection
> +                          The value is an integer from 0 to 1

mediatek,hs400-cmd-resp-sel

And make it a boolean value instead!

>
>  Examples:
>  mmc0: mmc@11230000 {
> @@ -38,4 +44,7 @@ mmc0: mmc@11230000 {
>         assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
>         assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
>         hs400-ds-delay = <0x14015>;
> +       mtk-hs200-cmd-int-delay = <26>;
> +       mtk-hs400-cmd-int-delay = <14>;
> +       mtk-hs400-cmd-resp-sel = <0>; /* 0: rising, 1: falling */

The rising/falling information belongs in description of the binding a
few lines above. Please move it there.

>  };
> --
> 1.7.9.5
>

Kind regards
Uffe
