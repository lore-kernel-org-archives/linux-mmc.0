From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 18/24] dt-bindings: timer: mtk-timer: add support for
 MT8516
Date: Tue, 16 Apr 2019 09:54:46 +0200
Message-ID: <182f1ae5-9f4f-8ef4-695f-353bbd1966c6@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-19-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-19-fparent@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 23/03/2019 22:16, Fabien Parent wrote:
> Add binding documentation of mtk-timer for MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)

applied to v5.1-next/dts64

Daniel let me know if you want to take it through your tree and I drop the patch.

> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index ff7c567a7972..74c3eadad844 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -17,6 +17,7 @@ Required properties:
>  	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
>  	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
>  	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
> +	* "mediatek,mt8516-timer" for MT8516 compatible timers (GPT)
>  	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
>  
>  	For those SoCs that use SYST
> 
