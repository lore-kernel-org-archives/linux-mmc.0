From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 6/10] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Fri, 25 Nov 2016 16:45:47 +0800
Message-ID: <07e71ce4-a78e-750c-6325-0a88891519d5@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <0390e7a05b6163deabb545f93729ea615eeaaee2.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpqPSqiEi=0UW5LoZmy+y-KHm9nbcGKBSy3RzchdLU9cA@mail.gmail.com>
 <dd230463-04f6-df31-7056-1a185eb6cfc7@marvell.com>
 <CAPDyKFr9uEjVQmTNP0KK8Zj9mxCW3i564E=47vTK0RLvXCjw3Q@mail.gmail.com>
 <76ce72f8-4b86-3b83-544f-b9a7ef871393@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43492 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751227AbcKYIqe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 03:46:34 -0500
In-Reply-To: <76ce72f8-4b86-3b83-544f-b9a7ef871393@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Romain Perier <romain.perier@free-electro>

Hi Ulf,

On 2016/11/24 23:00, Ziji Hu wrote:
> Hi Ulf,
> 
> On 2016/11/24 21:34, Ulf Hansson wrote:
<snip>
>>>>> +
>>>>> +       /*
>>>>> +        * Xenon Specific property:
>>>>> +        * emmc: explicitly indicate whether this slot is for eMMC
>>>>> +        * slotno: the index of slot. Refer to SDHC_SYS_CFG_INFO register
>>>>> +        * tun-count: the interval between re-tuning
>>>>> +        * PHY type: "sdhc phy", "emmc phy 5.0" or "emmc phy 5.1"
>>>>> +        */
>>>>> +       if (of_property_read_bool(np, "marvell,xenon-emmc"))
>>>>> +               priv->emmc_slot = true;
>>>>
>>>> So, you need this because of the eMMC voltage switch behaviour, right?
>>>>
>>>> Then I would rather like to describe this a generic DT bindings for
>>>> the eMMC voltage level support. There have acutally been some earlier
>>>> discussions for this, but we haven't yet made some changes.
>>>>
>>>> I think what is missing is a mmc-ddr-3_3v DT binding, which when set,
>>>> allows the host driver to accept I/O voltage switches to 3.3V. If not
>>>> supported the  ->start_signal_voltage_switch() ops may return -EINVAL.
>>>> This would inform the mmc core to move on to the next supported
>>>> voltage level. There might be some minor additional changes to the mmc
>>>> card initialization sequence, but those should be simple.
>>>>
>>>> I can help out to look into this, unless you want to do it yourself of course!?
>>>>
>>>    Yes. One of the reasons is to provide eMMC specific voltage setting.
>>>    But in my very own opinion, it should be irrelevant to voltage level.
>>>    The eMMC voltage setting on our SDHC is different from SD/SDIO voltage switch.
>>>    It will become more complex with different SOC implementation details.
>>
>> Got it. Although I think we can cope with that fine just by using the
>> different SD/eMMC speed modes settings defined in DT (or from the
>> SDHCI caps register)
>>
>     In my very opinion, I'm not sure if there is any corner case that driver cannot
>     determine the eMMC card type from DT and SDHC caps.
> 
>>>    Unfortunately, MMC driver cannot determine the card type yet when eMMC voltage
>>>    setting should be executed.
>>>    Thus an flag is required here to tell driver to execute eMMC voltage setting.
>>>
>>>    Besides, additional eMMC specific settings might be implemented in future, besides
>>>    voltage setting. Most of them should be completed before MMC driver recognizes the
>>>    card type. Thus I have to keep this flag to indicate current SDHC is for eMMC.
>>
>> I doubt you will need a generic "eMMC" flag, but let's see when we go forward.
>>
>> Currently it's clear you don't need such a flag, so I will submit a
>> change adding a DT binding for "mmc-ddr-3_3v" then we can take it from
>> there, to see if it suits your needs.
>>

    Another reason for a special "xenon-emmc" property is that our host IP usually can
    support both eMMC and SD. Whether a host is used as eMMC or SD depends on the
    final implementation of the actual product.
    Thus our host driver needs to know whether current SDHC is fixed as eMMC or SD.
    So far, It can only get the information from DT.

    After out host driver get the card type information from DT, it can prepare eMMC
    specific voltage, set eMMC specific mmc->caps/caps2 flags and do other
    vendor specific init, before card init procedure.
    Otherwise, our host driver has to wait until card type is determined in mmc_rescan().

    A generic "eMMC" flag is unnecessary. I just require a private property,
    which is only used in our host driver and DT.

    Thank you.

Best regards,
Hu Ziji

> 
>     Actually, our eMMC is usually fixed as 1.8V.
> 
>     The pair "no-sd" + "no-sdio" can provide the similar information.
>     But I'm not sure if it is proper to use those two property in such a way.
> 
>     Thank you.
> 
> Best regards
> Hu Ziji
> 
>> [...]
>>
>> Kind regards
>> Uffe
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
