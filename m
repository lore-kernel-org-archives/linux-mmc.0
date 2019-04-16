From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 22/24] dt-bindings: i2c: i2c-mtk: add support for MT8516
Date: Tue, 16 Apr 2019 09:58:09 +0200
Message-ID: <2a384e4b-a23d-450b-ee37-57af8c097bae@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-23-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-23-fparent@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com, Wolfram Sang <wsa@the-dreams.de>
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 23/03/2019 22:16, Fabien Parent wrote:
> Add binding documentation of i2c-mtk for MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
>  1 file changed, 1 insertion(+)
> 


applied to v5.1-next/dts64

Wolfram let me know if you want to take it through your tree and I drop the patch.

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> index ee4c32454198..aac7b56f251f 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> @@ -12,6 +12,7 @@ Required properties:
>        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
>        "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
>        "mediatek,mt8173-i2c": for MediaTek MT8173
> +      "mediatek,mt8516-i2c", "mediatek,mt2712-i2c": for MediaTek MT8516
>    - reg: physical base address of the controller and dma base, length of memory
>      mapped region.
>    - interrupts: interrupt number to the cpu.
> 
