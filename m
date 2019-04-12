From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 03/24] dt-bindings: pwrap: mediatek: add pwrap support for
 MT8516
Date: Fri, 12 Apr 2019 19:44:05 +0200
Message-ID: <effcf905-92c9-0181-2518-5a8e943f36ac@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-4-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-4-fparent@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 23/03/2019 22:15, Fabien Parent wrote:
> Add binding documentation of pwrap for MT8516 SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>  1 file changed, 1 insertion(+)

applied to v5.1-next/soc

Thanks!

> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> index 5a2ef1726e2a..7a32404c6114 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> @@ -25,6 +25,7 @@ Required properties in pwrap device node.
>  	"mediatek,mt8135-pwrap" for MT8135 SoCs
>  	"mediatek,mt8173-pwrap" for MT8173 SoCs
>  	"mediatek,mt8183-pwrap" for MT8183 SoCs
> +	"mediatek,mt8516-pwrap" for MT8516 SoCs
>  - interrupts: IRQ for pwrap in SOC
>  - reg-names: Must include the following entries:
>    "pwrap": Main registers base
> 
