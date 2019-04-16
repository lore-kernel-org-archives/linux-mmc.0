From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 18/24] dt-bindings: timer: mtk-timer: add support for
 MT8516
Date: Tue, 16 Apr 2019 10:09:47 +0200
Message-ID: <e4895191-c267-7b0b-6203-8e4ff44927e0@linaro.org>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-19-fparent@baylibre.com>
 <182f1ae5-9f4f-8ef4-695f-353bbd1966c6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <182f1ae5-9f4f-8ef4-695f-353bbd1966c6@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org

On 16/04/2019 09:54, Matthias Brugger wrote:
> 
> 
> On 23/03/2019 22:16, Fabien Parent wrote:
>> Add binding documentation of mtk-timer for MT8516 SoC.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>>  1 file changed, 1 insertion(+)
> 
> applied to v5.1-next/dts64
> 
> Daniel let me know if you want to take it through your tree and I drop the patch.

It is ok.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> index ff7c567a7972..74c3eadad844 100644
>> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> @@ -17,6 +17,7 @@ Required properties:
>>  	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
>>  	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
>>  	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
>> +	* "mediatek,mt8516-timer" for MT8516 compatible timers (GPT)
>>  	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
>>  
>>  	For those SoCs that use SYST
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
