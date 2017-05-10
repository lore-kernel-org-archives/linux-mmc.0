From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 2/3] ARM64: dts: mediatek: configure some fixed mmc
 parameters
Date: Wed, 10 May 2017 11:50:33 +0200
Message-ID: <488ca9b8-f1f1-6db2-118f-58ac924c0c0b@gmail.com>
References: <1489562800-27431-1-git-send-email-yong.mao@mediatek.com>
 <1489562800-27431-3-git-send-email-yong.mao@mediatek.com>
 <CAPDyKFp=VjTe0NQ2a4QN4CE1+n+fJJa=kMVNc-zZQUaO8-nrYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp=VjTe0NQ2a4QN4CE1+n+fJJa=kMVNc-zZQUaO8-nrYw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Yong Mao <yong.mao@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 24/03/17 08:17, Ulf Hansson wrote:
> +Mattias
> 
> On 15 March 2017 at 08:26, Yong Mao <yong.mao@mediatek.com> wrote:
>> From: yong mao <yong.mao@mediatek.com>
>>
>> configure some fixed mmc parameters
>>
>> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> 
> This one is for Mattias Brugger to pick up - unless I get an ack then
> I can pick it.
> 

I merged it in v4.11-next/fixes
Thanks,
Matthias

> Kind regards
> Uffe
> 
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> index 0ecaad4..1c3634f 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> @@ -134,6 +134,9 @@
>>          bus-width = <8>;
>>          max-frequency = <50000000>;
>>          cap-mmc-highspeed;
>> +       mediatek,hs200-cmd-int-delay=<26>;
>> +       mediatek,hs400-cmd-int-delay=<14>;
>> +       mediatek,hs400-cmd-resp-sel-rising;
>>          vmmc-supply = <&mt6397_vemc_3v3_reg>;
>>          vqmmc-supply = <&mt6397_vio18_reg>;
>>          non-removable;
>> --
>> 1.7.9.5
>>
