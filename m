From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dt-bindings: update Mediatek MMC bindings
Date: Thu, 12 Jan 2017 11:15:27 +0100
Message-ID: <CAPDyKFoVaoC=1VP4g0kC+1i1pNfTfRezyOGmkALXCFZFoUBFEQ@mail.gmail.com>
References: <1484215490-7494-1-git-send-email-yong.mao@mediatek.com> <1484215490-7494-3-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34952 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdALKPo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 05:15:44 -0500
Received: by mail-wm0-f46.google.com with SMTP id r126so12655347wmr.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 02:15:29 -0800 (PST)
In-Reply-To: <1484215490-7494-3-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mediatek@lists.infradead.org

-trimmed cc list (future wise, I suggest you be more careful whom to
keep on cc/to)

On 12 January 2017 at 11:04, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> Add description for hs200-cmd-int-delay
> Add description for hs400-cmd-int-delay
> Add description for cmd-resp-sel
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

The changes to DTS bindings should come prior the actual code change
using the bindings. Please make this patch 1 instead.

Otherwise this looks good to me.

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 0120c7f..2dbb3b0 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -21,6 +21,9 @@ Optional properties:
>  - assigned-clocks: PLL of the source clock
>  - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
>  - hs400-ds-delay: HS400 DS delay setting
> +- hs200-cmd-int-delay: HS200 command internal delay setting
> +- hs400-cmd-int-delay: HS400 command internal delay setting
> +- cmd-resp-sel: command response sample selection
>
>  Examples:
>  mmc0: mmc@11230000 {
> @@ -38,4 +41,7 @@ mmc0: mmc@11230000 {
>         assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
>         assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
>         hs400-ds-delay = <0x14015>;
> +       hs200-cmd-int-delay = <26>;
> +       hs400-cmd-int-delay = <14>;
> +       cmd-resp-sel = <0>; /* 0: rising, 1: falling */
>  };
> --
> 1.7.9.5
>
