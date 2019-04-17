From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 19/24] dt-bindings: spi: spi-mt65xx: add support for
 MT8516
Date: Wed, 17 Apr 2019 10:19:20 +0200
Message-ID: <de48f4db-2d03-e47a-48ba-45cc884fc088@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-20-fparent@baylibre.com>
 <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com>
 <20190416142814.GB4834@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416142814.GB4834@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com, sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 16/04/2019 16:28, Mark Brown wrote:
> On Tue, Apr 16, 2019 at 09:55:41AM +0200, Matthias Brugger wrote:
>> On 23/03/2019 22:16, Fabien Parent wrote:
>>> Add binding documentation of spi-mt65xx for MT8516 SoC.
> 
>>> Signed-off-by: Fabien Parent <fparent@baylibre.com> --- 
>>> Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 + 1 file
>>> changed, 1 insertion(+)
> 
>> applied to v5.1-next/dts64
> 
>> Mark let me know if you want to take it through your tree and I drop the
>> patch.
> 
> Yes, DT bindings generally get reviewed in the subsystem :(
> 

I already dropped it due to some comments from Lei Liu:
https://patchwork.kernel.org/patch/10867251/

Regards,
Matthias
