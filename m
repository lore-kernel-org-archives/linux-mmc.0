From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5 1/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Mon, 14 Nov 2016 19:04:41 +0900
Message-ID: <cfd86f7e-71b1-a878-3486-7ce6e0fa5222@samsung.com>
References: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
 <1478568298-18380-2-git-send-email-jun.nie@linaro.org>
 <b72dcd9c-aa90-a487-dbfb-6682fcdf015b@rock-chips.com>
 <CGME20161114100051epcas5p28b82151aa7572fb76e190e84d40ba344@epcas5p2.samsung.com>
 <CABymUCMWsCDfM58Ezpu8F7=vgpcPf_pzpbgr8OjCjOJ921tCEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51514 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbcKNKEo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 05:04:44 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGM01DUCMNTM920@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 14 Nov 2016 19:04:41 +0900 (KST)
In-reply-to: <CABymUCMWsCDfM58Ezpu8F7=vgpcPf_pzpbgr8OjCjOJ921tCEg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "xie.baoyou" <xie.baoyou@zte.com.cn>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Liu <jason.liu@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 11/14/2016 07:00 PM, Jun Nie wrote:
> 2016-11-14 15:58 GMT+08:00 Shawn Lin <shawn.lin@rock-chips.com>:
>> On 2016/11/8 9:24, Jun Nie wrote:
>>>
>>> Document the device-tree binding of ZTE MMC host on
>>> ZX296718 SoC.
>>>
>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>> ---
>>>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         | 35
>>> ++++++++++++++++++++++
>>>  1 file changed, 35 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>> b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>> new file mode 100644
>>> index 0000000..c175c4b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>> @@ -0,0 +1,35 @@
>>> +* ZTE specific extensions to the Synopsys Designware Mobile Storage
>>> +  Host Controller
>>> +
>>> +The Synopsys designware mobile storage host controller is used to
>>> interface
>>> +a SoC with storage medium such as eMMC or SD/MMC cards. This file
>>> documents
>>> +differences between the core Synopsys dw mshc controller properties
>>> described
>>> +by synopsys-dw-mshc.txt and the properties used by the ZTE specific
>>> +extensions to the Synopsys Designware Mobile Storage Host Controller.
>>> +
>>> +Required Properties:
>>> +
>>> +* compatible: should be
>>> +       - "zte,zx296718-dw-mshc": for ZX SoCs
>>> +
>>> +Example:
>>> +
>>> +       mmc1: mmc@1110000 {
>>> +               compatible = "zte,zx296718-dw-mshc";
>>> +               #address-cells = <1>;
>>> +               #size-cells = <0>;
>>> +               reg = <0x01110000 0x1000>;
>>> +               interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>>> +               fifo-depth = <32>;
>>> +               data-addr = <0x200>;
>>> +               fifo-watermark-aligned;
>>> +               bus-width = <4>;
>>> +               clock-frequency = <50000000>;
>>
>>
>> do you need both clock-frequency and max-frequency here?
> 
> According to dts document, clock-frequency is for clock configuration
> when dw core probe. max-frequency is for mmc core to limit max
> frequency for any cards at any time. Do you have any suggestion? Thank
> you for your time!

As i know, Jun's comment is right. :)
clock-frequency should be used with clk_set_rate().

> 
>>
>>> +               clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
>>> +               clock-names = "biu", "ciu";
>>> +               num-slots = <1>;
>>> +               max-frequency = <50000000>;
>>> +               cap-sdio-irq;
>>> +               cap-sd-highspeed;
>>> +               status = "disabled";
>>> +       };
>>>
>>
>>
>> --
>> Best Regards
>> Shawn Lin
>>
> 
> 
> 

