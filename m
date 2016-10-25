From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH 3/5] Documentation: synopsys-dw-mshc: add binding for fifo quirks
Date: Tue, 25 Oct 2016 16:33:15 +0800
Message-ID: <CABymUCNPeYXaA9su2iS15SwKsZ4R8diUmJCAfi8zZDM7Ddi-0w@mail.gmail.com>
References: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
 <1477300316-1420-4-git-send-email-jun.nie@linaro.org> <CGME20161024121937epcas1p3f78185f24e1bcfad677ed5971d91e1fa@epcas1p3.samsung.com>
 <02e88f2e-d87b-c999-a148-65cfe5cf84d0@rock-chips.com> <39dbfa10-03fc-0f8b-c947-0f8da5dae60b@samsung.com>
 <c7fea328-45a9-77cd-39a5-37681ea2bc7a@rock-chips.com> <5c0758f5-420c-55e5-86e3-a9dfef73b52e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33519 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932541AbcJYIdR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2016 04:33:17 -0400
Received: by mail-qt0-f169.google.com with SMTP id s49so137513625qta.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2016 01:33:16 -0700 (PDT)
In-Reply-To: <5c0758f5-420c-55e5-86e3-a9dfef73b52e@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Shawn Guo <shawn.guo@linaro.org>, "xie.baoyou" <xie.baoyou@zte.com.cn>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Liu <jason.liu@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

2016-10-25 16:09 GMT+08:00 Jaehoon Chung <jh80.chung@samsung.com>:
> On 10/25/2016 01:17 PM, Shawn Lin wrote:
>> On 2016/10/25 10:16, Jaehoon Chung wrote:
>>> On 10/24/2016 09:19 PM, Shawn Lin wrote:
>>>> On 2016/10/24 17:11, Jun Nie wrote:
>>>>> Add fifo-addr-override property and fifo-watermark-quirk property to
>>>>> synopsys-dw-mshc bindings. It is intended to provide workarounds to
>>>>> support more SoCs that break current assumption.
>>>>>
>>>>> See Documentation/devicetree/bindings/reset/reset.txt for details.
>>>>>
>>>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 13 +++++++++++++
>>>>>  1 file changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>>>> index 4e00e85..eb64921 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>>>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>>>> @@ -76,6 +76,17 @@ Optional properties:
>>>>>
>>>>>  * broken-cd: as documented in mmc core bindings.
>>>>>
>>>>> +* fifo-addr-override: Override fifo address with value provided by DT. The FIFO
>>>>> +  reg offset of version 0x210A break current assumption that 0x100 (version < 0x240A)
>>>>> +  and 0x200(version >= 0x240A) in some implementation. So this property serves as
>>>>> +  workaround.
>>>>
>>>> Can we hardcode this to the code by checking the host version?
>>>
>>> I think it should be not workaround..According to TRM, Address is equal or greater than 0x100.
>>> It means address can be 0x200, right?
>>> If you needs to overwrite the DATA register offset for your target, just can add the property for this.
>>>
>>
>> I can't follow yours here as I don't have 210A TRM. Do you mean the TRM
>> for 210A say: "Address  is equal or greater than 0x100"  ?
>
> Upper version than IP 2.40a is used the offset 0x100 as other purpose.
> For preventing to use wrong register. we put to check host->verid.
>
> Yes, can set the address to any value 0x100 or greater.
> If some soc needs to use 0x200, why not?
>
> But it's not true that FIFO reg offset of version 2.10a break.
> I have checked 2.10a TRM..It's DATA offset >= 0x100.
>
> Best Regards,
> Jaehoon Chung

OK, will change property name to "fifo-addr" to set fifo reg address
via property in next version. I do not have 2.10a TRM and had assumed
current code is following the TRM.

Jun

>
>>
>>>>
>>>>> +
>>>>> +* fifo-watermark-quirk: Data done irq is expected if data length is less than
>>>>> +  watermark in PIO mode. But fifo watermark is requested to be aligned with data
>>>>> +  length in some SoC so that TX/RX irq can be generated with data done irq. Add the
>>>>> +  watermark quirk to mark this requirement and force fifo watermark setting
>>>>> +  accordingly.
>>>>
>>>> I would like to know if this limitation is *really* related to some
>>>> Socs or the version of 210A dw_mmc?
>>>>
>>>>
>>>>> +
>>>>>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>>>>>    specified we'll defer probe until we can find this regulator.
>>>>>
>>>>> @@ -103,6 +114,8 @@ board specific portions as listed below.
>>>>>          interrupts = <0 75 0>;
>>>>>          #address-cells = <1>;
>>>>>          #size-cells = <0>;
>>>>> +        fifo-addr-override = <0x200>;
>>>>> +        fifo-watermark-quirk;
>>>>>      };
>>>>>
>>>>>  [board specific internal DMA resources]
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>
>>
>>
>
