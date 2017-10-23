From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH v6 01/12] mmc: dt-bindings: Add reg/source_cg/latch-ck
 for Mediatek MMC bindings
Date: Mon, 23 Oct 2017 10:31:44 +0800
Message-ID: <1508725904.19789.19.camel@mhfsdcap03>
References: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
         <1508118399-21828-2-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:51403 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750869AbdJWCby (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Oct 2017 22:31:54 -0400
In-Reply-To: <1508118399-21828-2-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com

Hi Rob & Ulf,

Gentle ping...
Any other comments about this series of patch ?
On Mon, 2017-10-16 at 09:46 +0800, Chaotian Jing wrote:
> Change the comptiable for support of multi-platform
> Make compatible explicit, as MMC host of mt8173 has difference with
> mt8135(mt8173 supports hs400 and hs400_tune),so that need separate
> mt8173/mt8135 compatible name.
> Add description for reg
> Add description for source_cg
> Add description for mediatek,latch-ck
> Note that source_cg and mediatek,latch-ck are optional for some projects,
> eg, MT2701 do not have source_cg, and MT2712 do not need
> mediatek,latch-ck
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 4182ea3..72d2a73 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -7,10 +7,18 @@ This file documents differences between the core properties in mmc.txt
>  and the properties used by the msdc driver.
>  
>  Required properties:
> -- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
> +- compatible: value should be either of the following.
> +	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> +	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> +	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> +	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> +- reg: physical base address of the controller and length
>  - interrupts: Should contain MSDC interrupt number
> -- clocks: MSDC source clock, HCLK
> -- clock-names: "source", "hclk"
> +- clocks: Should contain phandle for the clock feeding the MMC controller
> +- clock-names: Should contain the following:
> +	"source" - source clock (required)
> +	"hclk" - HCLK which used for host (required)
> +	"source_cg" - independent source clock gate (required for MT2712)
>  - pinctrl-names: should be "default", "state_uhs"
>  - pinctrl-0: should contain default/high speed pin ctrl
>  - pinctrl-1: should contain uhs mode pin ctrl
> @@ -30,6 +38,10 @@ Optional properties:
>  - mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
>  				       If present,HS400 command responses are sampled on rising edges.
>  				       If not present,HS400 command responses are sampled on falling edges.
> +- mediatek,latch-ck: Some SoCs do not support enhance_rx, need set correct latch-ck to avoid data crc
> +		     error caused by stop clock(fifo full)
> +		     Valid range = [0:0x7]. if not present, default value is 0.
> +		     applied to compatible "mediatek,mt2701-mmc".
>  
>  Examples:
>  mmc0: mmc@11230000 {


