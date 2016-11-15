From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 1/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Tue, 15 Nov 2016 15:49:19 +0800
Message-ID: <c0392feb-a634-5e7a-8632-b5c0aa5b9f0a@rock-chips.com>
References: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
 <1478568298-18380-2-git-send-email-jun.nie@linaro.org>
 <b72dcd9c-aa90-a487-dbfb-6682fcdf015b@rock-chips.com>
 <CGME20161114100051epcas5p28b82151aa7572fb76e190e84d40ba344@epcas5p2.samsung.com>
 <CABymUCMWsCDfM58Ezpu8F7=vgpcPf_pzpbgr8OjCjOJ921tCEg@mail.gmail.com>
 <cfd86f7e-71b1-a878-3486-7ce6e0fa5222@samsung.com>
 <935402c2-c0be-252b-89b8-c69e250c58d3@rock-chips.com>
 <983fdc91-5487-3d71-b55c-88edc7b579e7@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:59487 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935408AbcKOHtd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2016 02:49:33 -0500
In-Reply-To: <983fdc91-5487-3d71-b55c-88edc7b579e7@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Jun Nie <jun.nie@linaro.org>
Cc: shawn.lin@rock-chips.com, Shawn Guo <shawn.guo@linaro.org>, "xie.baoyou" <xie.baoyou@zte.com.cn>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Liu <jason.liu@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 2016/11/15 13:21, Jaehoon Chung wrote:
> On 11/15/2016 09:48 AM, Shawn Lin wrote:
>> On 2016/11/14 18:04, Jaehoon Chung wrote:
>>> On 11/14/2016 07:00 PM, Jun Nie wrote:
>>>> 2016-11-14 15:58 GMT+08:00 Shawn Lin <shawn.lin@rock-chips.com>:
>>>>> On 2016/11/8 9:24, Jun Nie wrote:
>>>>>>
>>>>>> Document the device-tree binding of ZTE MMC host on
>>>>>> ZX296718 SoC.
>>>>>>
>>>>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>>>>> ---
>>>>>>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         | 35
>>>>>> ++++++++++++++++++++++
>>>>>>  1 file changed, 35 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>>>>> b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..c175c4b
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>>>>> @@ -0,0 +1,35 @@
>>>>>> +* ZTE specific extensions to the Synopsys Designware Mobile Storage
>>>>>> +  Host Controller
>>>>>> +
>>>>>> +The Synopsys designware mobile storage host controller is used to
>>>>>> interface
>>>>>> +a SoC with storage medium such as eMMC or SD/MMC cards. This file
>>>>>> documents
>>>>>> +differences between the core Synopsys dw mshc controller properties
>>>>>> described
>>>>>> +by synopsys-dw-mshc.txt and the properties used by the ZTE specific
>>>>>> +extensions to the Synopsys Designware Mobile Storage Host Controller.
>>>>>> +
>>>>>> +Required Properties:
>>>>>> +
>>>>>> +* compatible: should be
>>>>>> +       - "zte,zx296718-dw-mshc": for ZX SoCs
>>>>>> +
>>>>>> +Example:
>>>>>> +
>>>>>> +       mmc1: mmc@1110000 {
>>>>>> +               compatible = "zte,zx296718-dw-mshc";
>>>>>> +               #address-cells = <1>;
>>>>>> +               #size-cells = <0>;
>>>>>> +               reg = <0x01110000 0x1000>;
>>>>>> +               interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +               fifo-depth = <32>;
>>>>>> +               data-addr = <0x200>;
>>>>>> +               fifo-watermark-aligned;
>>>>>> +               bus-width = <4>;
>>>>>> +               clock-frequency = <50000000>;
>>>>>
>>>>>
>>>>> do you need both clock-frequency and max-frequency here?
>>>>
>>>> According to dts document, clock-frequency is for clock configuration
>>>> when dw core probe. max-frequency is for mmc core to limit max
>>>> frequency for any cards at any time. Do you have any suggestion? Thank
>>>> you for your time!
>>>
>>> As i know, Jun's comment is right. :)
>>> clock-frequency should be used with clk_set_rate().
>>
>> yup, I was thinking that should we reuse max-frequency instead of
>> clock-frequency in the future?  I saw most of the DT(I didn't check all
>> of them) assign clock-frequency to the same value as max of clock-
>> freq-min-max. I think it's pointless if the clock-frequency is different
>> from max-frequency as both of them will be setted via dw_mmc and finally
>> we only take min(clock-frequency, max-frquency). Was I missing
>> something?
>
> Well, clock-frequency is for setting CMU. but max-frequency is not really used for CMU.
> For example, clock-frequency is 100MHz. Max-frequency is 50MHz.
> It's possible to use. then dwmmc controller should divide to 2 for max-frequency.

yes, but why shouldn't we ask clock unit to generate max-frequency, so
we don't need to divide 2 here?

>
> There are too many cases. Source clock can be 400MHz or 200MHz..etc..
> but maximum clock is decided according to busmode.
>
> I'm not sure because i didn't have HW knowledge..
> but in my experience,
> 1) 400MHz/2 = 200MHz,
> 2) 800MHz/4 = 200MHz.
>
> 1) and 2) are same value as 200MHz. but those clock phase might be a little difference.

clock rate shouldn't be problem but the clock phase maybe according to
the different clock design.

>
> So i want to keep the clock-frequency for setting the initial CMU value.
> What your opinion? :)

it' okay and I was just think that
(1) most of the host drivers direct use max-frequenct(f_max) for
setting clock source rate and use internal divider to generate other 
different rate. Also you can look at mmc_set_clock function.
That impiles they doesn't care the phase or any differences at all.
(2) If clock-frequency may be a little different with max-frequency,
but I now check all the DT using clock-frequency with clock-freq-min-max
before your cleanup and comfirm that all of the clock-frequency(s) are
the same as the max of clock-freq-min-max, namely max-frequency after
your cleanup. That implies that there are no difference between
setting source rate with clock-frequency and with max-frequency.


Anyway, that is just some random thoughts and shouldn't block this
patchset. We could disscuss this topic later. :)

>
> Best Regards,
> Jaehoon Chung
>
>>
>> What is your opinion, Jaehoon and Jun? :)
>>
>>>
>>>>
>>>>>
>>>>>> +               clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
>>>>>> +               clock-names = "biu", "ciu";
>>>>>> +               num-slots = <1>;
>>>>>> +               max-frequency = <50000000>;
>>>>>> +               cap-sdio-irq;
>>>>>> +               cap-sd-highspeed;
>>>>>> +               status = "disabled";
>>>>>> +       };
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Best Regards
>>>>> Shawn Lin
>>>>>
>>>>
>>>>
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

