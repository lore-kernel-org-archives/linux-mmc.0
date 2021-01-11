Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B04C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 21:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC43722CAF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 21:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbhAKVom (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 16:44:42 -0500
Received: from foss.arm.com ([217.140.110.172]:36576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbhAKVol (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 11 Jan 2021 16:44:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6DEE101E;
        Mon, 11 Jan 2021 13:43:55 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 451C53F66E;
        Mon, 11 Jan 2021 13:43:55 -0800 (PST)
Subject: Re: [PATCH] mmc: sdhci-iproc: Add ACPI bindings for the rpi4
To:     Stefan Wahren <stefan.wahren@i2se.com>, linux-mmc@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com,
        sbranden@broadcom.com, rjui@broadcom.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <20210108211339.1724769-1-jeremy.linton@arm.com>
 <ab3b5788-1148-636a-751f-0a31c87dda33@i2se.com>
 <cd7c5d78-af92-84b9-8bbf-f480f63005e0@arm.com>
 <2d92e093-a6f2-ac2c-d7e3-2d0172e1047c@i2se.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <be996d25-7421-a5d3-0861-18b9e6502382@arm.com>
Date:   Mon, 11 Jan 2021 15:43:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <2d92e093-a6f2-ac2c-d7e3-2d0172e1047c@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 1/11/21 6:23 AM, Stefan Wahren wrote:
> Hi,
> 
> Am 11.01.21 um 04:39 schrieb Jeremy Linton:
>> Hi,
>>
>> On 1/9/21 5:07 AM, Stefan Wahren wrote:
>>> Hi Jeremy,
>>>
>>> +add Nicolas
>>>
>>> Am 08.01.21 um 22:13 schrieb Jeremy Linton:
>>>> The rpi4 has a Arasan controller it carries over
>>>> from the rpi3, and a newer eMMC2 controller.
>>>> Because of a couple "quirks" it seems wiser to bind
>>>> these controllers to the same driver that DT is using
>>>> on this platform rather than the generic sdhci_acpi
>>>> driver with PNP0D40.
>>>>
>>>> So, we use BCM2847 for the older Arasan and BRCME88C
>>>> for the newer eMMC2.
>>>>
>>>> With this change linux is capable of utilizing the
>>>> SD card slot, and the wifi on this platform
>>>> with linux.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>    drivers/mmc/host/sdhci-iproc.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-iproc.c
>>>> b/drivers/mmc/host/sdhci-iproc.c
>>>> index c9434b461aab..f79d97b41805 100644
>>>> --- a/drivers/mmc/host/sdhci-iproc.c
>>>> +++ b/drivers/mmc/host/sdhci-iproc.c
>>>> @@ -250,6 +250,14 @@ static const struct sdhci_pltfm_data
>>>> sdhci_bcm2835_pltfm_data = {
>>>>        .ops = &sdhci_iproc_32only_ops,
>>>>    };
>>>>    +static const struct sdhci_pltfm_data sdhci_bcm_arasan_data = {
>>>> +    .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>>>> +          SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>>>> +          SDHCI_QUIRK_NO_HISPD_BIT,
>>>> +    .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>>> +    .ops = &sdhci_iproc_32only_ops,
>>>> +};
>>
>> First, thanks for taking a look at this!
>>
>>
>>> Why do we need an almost exact copy of bcm2835_data which works fine for
>>> all Raspberry Pi boards?
>>
>> The short answer to the remainder of this email is that i'm trying to
>> continue supporting existing OSs (windows) using the ACPI tables on
>> the rpi3/rpi4 while adding rpi4+Linux support.
>>
>> An even shorter answer is they don't work because ACPI doesn't provide
>> the same clock/attributes/etc controls that exist with DT.
>>
>> So, what happened here is that I got this controller "working" with
>> the generic PNP0D40 sdhci_acpi driver. I managed this only by
>> controlling the sdhci_caps/masks in the firmware. In theory this
>> minimizes the amount of work needed on the other OS which are booting
>> on the same ACPI tables (*bsds). They should only need to quirk the
>> bcm/arasan specific functionality, rather than some of the quirking
>> which change the caps behavior. But because we don't know which if any
>> of the older rpi/arasan quirks are still needed the safest solution is
>> to use the _iproc driver and just drop the quirk flags known to be
>> worked around by the firmware caps override.
> 
> okay, thanks for the explanation. I was also confused by bcm_arasan,
> because there is already an Arasan specific sdhci driver. But now it's
> clear to me.
> 
> Could you please add a short comment (above sdhci_bcm_arasan_data) why
> we cannot use bcm2835_data?

Sure.

> 
> Btw the subject isn't complete. The patch is also related to the rpi3.

Only via the historical ACPI tables. There isn't any attempt to get 
ACPI+Linux working on the rpi3. Its to far away from BSA. For starters 
it doesn't have a GIC. So while one could bind this driver on the rpi3, 
that would require being able to boot Linux on the rpi3 in ACPI mode.

Thanks again!



> 
> Best regards
> Stefan
> 
> 

