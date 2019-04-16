From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 20/24] dt-bindings: serial: mtk-uart: add support for
 MT8516
Date: Tue, 16 Apr 2019 09:56:39 +0200
Message-ID: <7c5789bc-a0b5-0ecf-9e1a-3d819c7e8285@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-21-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-21-fparent@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 23/03/2019 22:16, Fabien Parent wrote:
> Add binding documentation of mtk-uart for MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
>  1 file changed, 1 insertion(+)
> 


applied to v5.1-next/dts64

Thanks.

> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index 742cb470595b..1af981f7a33b 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -16,6 +16,7 @@ Required properties:
>    * "mediatek,mt8127-uart" for MT8127 compatible UARTS
>    * "mediatek,mt8135-uart" for MT8135 compatible UARTS
>    * "mediatek,mt8173-uart" for MT8173 compatible UARTS
> +  * "mediatek,mt8516-uart" for MT8516 compatible UARTS
>    * "mediatek,mt6577-uart" for MT6577 and all of the above
>  
>  - reg: The base address of the UART register bank.
> 
