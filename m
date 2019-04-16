From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 22/24] dt-bindings: i2c: i2c-mtk: add support for MT8516
Date: Tue, 16 Apr 2019 10:53:24 +0200
Message-ID: <120787ce-7f83-a828-89df-196edd400143@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-23-fparent@baylibre.com>
 <2a384e4b-a23d-450b-ee37-57af8c097bae@gmail.com>
 <20190416081433.GA1012@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416081433.GA1012@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com, sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 16/04/2019 10:14, Wolfram Sang wrote:
> On Tue, Apr 16, 2019 at 09:58:09AM +0200, Matthias Brugger wrote:
>> 
>> 
>> On 23/03/2019 22:16, Fabien Parent wrote:
>>> Add binding documentation of i2c-mtk for MT8516 SoC.
>>> 
>>> Signed-off-by: Fabien Parent <fparent@baylibre.com> --- 
>>> Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 + 1 file changed,
>>> 1 insertion(+)
>>> 
>> 
>> 
>> applied to v5.1-next/dts64
>> 
>> Wolfram let me know if you want to take it through your tree and I drop
>> the patch.
> 
> I'd like to take it via my tree to reduce conflicts. It already needs 
> rebasing on top of i2c/for-next because of Qii's MT8183 patches.
> 

Ok, dropped, the patch is all yours :)
