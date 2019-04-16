From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 19/24] dt-bindings: spi: spi-mt65xx: add support for
 MT8516
Date: Tue, 16 Apr 2019 09:55:41 +0200
Message-ID: <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-20-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-20-fparent@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com, Mark Brown <broonie@kernel.org>
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 23/03/2019 22:16, Fabien Parent wrote:
> Add binding documentation of spi-mt65xx for MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 


applied to v5.1-next/dts64

Mark let me know if you want to take it through your tree and I drop the patch.

> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> index 69c356767cf8..69ac5976b952 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -10,6 +10,7 @@ Required properties:
>      - mediatek,mt8135-spi: for mt8135 platforms
>      - mediatek,mt8173-spi: for mt8173 platforms
>      - mediatek,mt8183-spi: for mt8183 platforms
> +    - "mediatek,mt8516-spi", "mediatek,mt2701-spi": for mt8516 platforms
>  
>  - #address-cells: should be 1.
>  
> 
