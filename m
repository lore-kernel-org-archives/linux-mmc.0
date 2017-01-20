From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] dts: mediatek: configure some fixed mmc parameters
Date: Fri, 20 Jan 2017 08:59:08 +0100
Message-ID: <CAPDyKFrHCy7bLb-wDRWpELAB5VxPc4tjyWKd31YufEZC_AQtVA@mail.gmail.com>
References: <1484821156-20565-1-git-send-email-yong.mao@mediatek.com> <1484821156-20565-3-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38345 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdATH74 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 02:59:56 -0500
Received: by mail-wm0-f50.google.com with SMTP id r144so31124698wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 23:59:09 -0800 (PST)
In-Reply-To: <1484821156-20565-3-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 19 January 2017 at 11:19, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> configure some fixed mmc parameters
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Please change the prefix of the commit message header to "ARM64: dts: mt8173:".

Also make sure you send this to the ARM mailing list as well.

In general, I think it's better DTS changes go via the ARM SoC tree,
but I can pick it up if it's trivial and I get an ack from the SoC
maintainer.

> ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index 0ecaad4..403705e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -134,6 +134,9 @@
>         bus-width = <8>;
>         max-frequency = <50000000>;
>         cap-mmc-highspeed;
> +       mtk-hs200-cmd-int-delay=<26>;
> +       mtk-hs400-cmd-int-delay=<14>;
> +       mtk-hs400-cmd-resp-sel=<0>; /* 0:rising, 1:falling */
>         vmmc-supply = <&mt6397_vemc_3v3_reg>;
>         vqmmc-supply = <&mt6397_vio18_reg>;
>         non-removable;
> --
> 1.7.9.5
>

Kind regards
Uffe
