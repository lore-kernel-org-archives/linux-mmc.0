From: lei liu <leilk.liu@mediatek.com>
Subject: Re: [PATCH 19/24] dt-bindings: spi: spi-mt65xx: add support for
 MT8516
Date: Tue, 16 Apr 2019 16:25:51 +0800
Message-ID: <1555403151.7441.4.camel@mhfsdcap03>
References: <20190323211612.860-1-fparent@baylibre.com>
         <20190323211612.860-20-fparent@baylibre.com>
         <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, ryder.lee@mediatek.com, linux-watchdog@vger.kernel.org, jjian.zhou@mediatek.com, wenzhen.yu@mediatek.com, stephane.leprovost@mediatek.com, sean.wang@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, yong.mao@mediatek.com, linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, hsin-hsiung.wang@mediatek.com, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, chaotian.jing@mediatek.com, linux-i2c@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2019-04-16 at 09:55 +0200, Matthias Brugger wrote:
> 
> On 23/03/2019 22:16, Fabien Parent wrote:
> > Add binding documentation of spi-mt65xx for MT8516 SoC.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> 
> applied to v5.1-next/dts64
> 
> Mark let me know if you want to take it through your tree and I drop the patch.
> 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > index 69c356767cf8..69ac5976b952 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > @@ -10,6 +10,7 @@ Required properties:
> >      - mediatek,mt8135-spi: for mt8135 platforms
> >      - mediatek,mt8173-spi: for mt8173 platforms
> >      - mediatek,mt8183-spi: for mt8183 platforms
> > +    - "mediatek,mt8516-spi", "mediatek,mt2701-spi": for mt8516 platforms
Hi Fabien,
mt8516 SPI design comes from mt2712 and it's different from mt2701. Here
it should compatible with mt2712.

> >  
> >  - #address-cells: should be 1.
> >  
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
