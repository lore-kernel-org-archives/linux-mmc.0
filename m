From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 21/24] dt-bindings: irq: mtk,sysirq: add support for
 MT8516
Date: Tue, 16 Apr 2019 09:57:18 +0200
Message-ID: <ba07743d-39a2-f219-fdef-f857bee1e38b@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-22-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-22-fparent@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 23/03/2019 22:16, Fabien Parent wrote:
> Add binding documentation of mediatek,sysirq for MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/interrupt-controller/mediatek,sysirq.txt          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied to v5.1-next/dts64

Thanks
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> index c5d589108a94..deaaba70d548 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> @@ -1,10 +1,11 @@
> -+Mediatek MT65xx/MT67xx/MT81xx sysirq
> ++Mediatek MT65xx/MT67xx/MT81xx/MT85xx sysirq
>  
>  Mediatek SOCs sysirq support controllable irq inverter for each GIC SPI
>  interrupt.
>  
>  Required properties:
>  - compatible: should be
> +	"mediatek,mt8516-sysirq", "mediatek,mt6577-sysirq": for MT8516
>  	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
>  	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
>  	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
> 
