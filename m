From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/8] mmc: core add the property for hs200
Date: Tue, 28 Jan 2014 19:30:08 +0900
Message-ID: <52E786B0.3010104@samsung.com>
References: <52E76954.1020507@samsung.com>
 <CAPDyKFoSWOknN10v-Tc2NX9LynS8vddRp92XFvZtJ0=nrLaw1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49171 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684AbaA1K3k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 05:29:40 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0300FS0X5EXR90@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Jan 2014 19:29:38 +0900 (KST)
In-reply-to: <CAPDyKFoSWOknN10v-Tc2NX9LynS8vddRp92XFvZtJ0=nrLaw1A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Arnd Bergmann <arnd@arndb.de>

Dear, Ulf.

On 01/28/2014 07:17 PM, Ulf Hansson wrote:
> On 28 January 2014 09:24, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> mmc-hs200-1.8v and mmc-hs200-1.2v can be used to the general capability.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog V2:
>>         - Rename the mmc-hs200-1_8v/1_2v instead of "_caps2_"
>>         - Add the properties into Documentation/devicetree/bindings/mmc/mmc.txt
>>
>>  Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
>>  drivers/mmc/core/host.c                       |    4 ++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>> index 458b57f..4bb3894 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>> @@ -29,6 +29,8 @@ Optional properties:
>>  - cap-power-off-card: powering off the card is safe
>>  - cap-sdio-irq: enable SDIO IRQ signalling on this interface
>>  - full-pwr-cycle: full power cycle of the card is supported
> 
> Why remove above? I guess a typo? :-)
It's not removed. Just symbol in front of sentence. :)

Best Regards,
Jaehoon Chung
> 
>> +- mmc-hs200-1_8v: HS200 mode(1.8V I/O) is supported
>> +- mmc-hs200-1_2v: HS200 mode(1.2V I/O) is supported
>>
>>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 49bc403..5a82e81 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -429,6 +429,10 @@ int mmc_of_parse(struct mmc_host *host)
>>                 host->pm_caps |= MMC_PM_KEEP_POWER;
>>         if (of_find_property(np, "enable-sdio-wakeup", &len))
>>                 host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>> +       if (of_find_property(np, "mmc-hs200-1_8v", NULL))
>> +               host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
>> +       if (of_find_property(np, "mmc-hs200-1_2v", NULL))
>> +               host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>>
>>         return 0;
>>
>> --
>> 1.7.9.5
> 
> Once you fixed the above; you have my ack.
> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

