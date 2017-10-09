From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 03/13] mmc: dt-bindings: make compatible explicit
Date: Mon, 9 Oct 2017 16:54:45 +0200
Message-ID: <e4e5fa8b-b6a5-dc70-fbfc-6328493cd073@gmail.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
 <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35124 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754509AbdJIOyu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Oct 2017 10:54:50 -0400
In-Reply-To: <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com



On 10/09/2017 01:35 PM, Chaotian Jing wrote:
> the driver has updated to have an explicit compatible, so update
> binding file according to the driver change.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 3e0a97c..2bb585b 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -8,8 +8,8 @@ and the properties used by the msdc driver.
>   
>   Required properties:
>   - compatible: value should be either of the following.
> -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8173
> +	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> +	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173

You can merge this with patch 1.

>   	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
>   	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
>   - reg: physical base address of the controller and length
> 
