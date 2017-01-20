From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v3 1/3] mmc: dt-bindings: update Mediatek MMC bindings
Date: Fri, 20 Jan 2017 15:43:41 +0800
Message-ID: <CAGS+omAmnAmE-90MHCmbyTBVRmpTRLzqsYMvHjXAZ9sGDZbuvA@mail.gmail.com>
References: <1484821156-20565-1-git-send-email-yong.mao@mediatek.com> <1484821156-20565-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484821156-20565-2-git-send-email-yong.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 19, 2017 at 6:19 PM, Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> Add description for mtk-hs200-cmd-int-delay
> Add description for mtk-hs400-cmd-int-delay
> Add description for mtk-hs400-cmd-resp-sel
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
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
> +- mtk-hs400-cmd-int-delay: HS400 command internal delay setting
> +                          The value is an integer from 0 to 31

I think last time Rob meant that you should add a vendor prefixes like this:
  mediatek,hs200-cmd-int-delay

> +- mtk-hs400-cmd-resp-sel:  HS400 command response sample selection
> +                          The value is an integer from 0 to 1

Last time Rob stated this looks like a boolean, and to state that and
make the default the more common case.

So, this could be something like:

  mediatek,hs200-cmd-resp-sample-rising: A boolean.
      If present, HS400 command responses are sampled on rising edges.
      If not present, HS400 command responses are sampled on falling edges.


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
>  };
> --
> 1.7.9.5
>
