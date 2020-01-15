Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C06C33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FDD24671
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8vko09S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgAOPcF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:32:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28696 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726132AbgAOPcE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2020 10:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579102324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6A28f/R4NuXA+oSznePb7r+7lEwuidwEVlXRBfTkBQ=;
        b=P8vko09S7yuPsBNVH1YMxIM6OL/UdCRgAF71YF2j8X079S0Tb6zEZDEl1rG719VdYDMl+x
        MgP86ff4hRnH85E+OZGpyHbJQxpGs/lmyRy6lYKWoUUfvrhQtczU9cXxGmdfKRwn86ed6T
        aaI1/HmxCC5YVTs+zyjEgOmdpeOxwjM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-jIkxYYUGM3SqSo-oplvAdQ-1; Wed, 15 Jan 2020 10:32:02 -0500
X-MC-Unique: jIkxYYUGM3SqSo-oplvAdQ-1
Received: by mail-wr1-f71.google.com with SMTP id y7so8156035wrm.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2020 07:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d6A28f/R4NuXA+oSznePb7r+7lEwuidwEVlXRBfTkBQ=;
        b=DZdnhJlGzMYROavr/krZYk/V/GL/dupPR7Kx9n0oY8/RArK1sRWiWLWMEXsUQTysGF
         mobK/S3QzsZvHKgYFvIJ2UbDG3uOwWmShmsZxGH3SDgk7D/4l1e+rkFeAWppsTMH3OHW
         w7GA+ZYwhmtRHgDQyCLSy1BniDVojdMpAPy9zm4/Ge2EBjNx6IcD9P9vx59WQ5ovD86t
         IjkD8zNZbZiIPI3AjpLoTuc5/PGcsOf4qCWv+O2MUmRtHd8H4lA9k0/X8hPf4fj0usfK
         DpVD2aBG8cGZNB6YcDdYemErC/iFOItk4vAiDjE+mtzcNjowtZTC6G5xYMBmrHaFNvEE
         9vBA==
X-Gm-Message-State: APjAAAUFhvDsN06MpmKbx4UJyEwy/YNMS7fJZe7rw4rLiBuT13DR+ei4
        6Z/GuNKCXr06BO2cZ35JtOfQSAxXGy7XfkZHvOWgZHbyeu7j1WjzYzXX62z06Tubgch1CxeBucJ
        Nw8PfnfnRHeFwfeD5V6A3
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr404469wmf.56.1579102321323;
        Wed, 15 Jan 2020 07:32:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8rAVp2OhlrewhyW9Eqwba/msqLgs2Lpbb7JSugsfl/doaEE8BRpG+mgignRn23gDCGitPpg==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr404429wmf.56.1579102321005;
        Wed, 15 Jan 2020 07:32:01 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id z83sm285359wmg.2.2020.01.15.07.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 07:32:00 -0800 (PST)
Subject: Re: [PATCH 1/2] mmc: sdhci-acpi: Disable 1.8V modes on external
 microSD on Lenovo Miix 320
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
References: <20200108093903.57620-1-hdegoede@redhat.com>
 <20200108093903.57620-2-hdegoede@redhat.com>
 <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com>
 <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com>
 <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com>
Date:   Wed, 15 Jan 2020 16:31:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 15-01-2020 14:48, Adrian Hunter wrote:
> On 15/01/20 3:31 pm, Hans de Goede wrote:
>> Hi,
>>
>> On 15-01-2020 13:57, Adrian Hunter wrote:
>>> On 8/01/20 11:39 am, Hans de Goede wrote:
>>>> Based on a sample of 7 DSDTs from Cherry Trail devices using an AXP288
>>>> PMIC depending on the design one of 2 possible LDOs on the PMIC is used
>>>> for the MMC signalling voltage, either DLDO3 or GPIO1LDO (GPIO1 pin in
>>>> low noise LDO mode).
>>>>
>>>> The Lenovo Miix 320-10ICR uses GPIO1LDO in the SHC1 ACPI device's DSM
>>>> methods to set 3.3 or 1.8 signalling voltage and this appears to work
>>>> as advertised, so presumably the device is actually using GPIO1LDO for
>>>> the external microSD signalling voltage.
>>>>
>>>> But this device has a bug in the _PS0 method of the SHC1 ACPI device,
>>>> the DSM remembers the last set signalling voltage and the _PS0 restores
>>>> this after a (runtime) suspend-resume cycle, but it "restores" the voltage
>>>> on DLDO3 instead of setting it on GPIO1LDO as the DSM method does. DLDO3
>>>> is used for the LCD and setting it to 1.8V causes the LCD to go black.
>>>>
>>>> This issue can be worked around by setting the SDHCI_QUIRK2_NO_1_8_V
>>>> quirk on the sdhci_host so that the DSM never gets used to program the
>>>> signalling voltage to 1.8V.
>>>
>>> Could you instead call the 3.3V DSM at runtime suspend time, then the _PS0
>>> would not "restore" the 1.8V value?  That should allow you to use 1.8V UHS-I
>>> speed modes with SD cards that support them.
>>
>> I have considered doing this, but this means reprogramming the signal
>> voltage to 3.3V at a time when the card does not expect this, is this ok?
> 
> The host controller does not runtime suspend unless the card is runtime
> suspended, so the bus power should be off.
> 
>>
>> We would then also need to recall the DSM to put the voltage back to 1.8V
>> from resume.
> 
> No, the card will be reinitialized at 3.3V and switch back to 1.8V.
> 
>>               I have a feeling that this is probably what Windows does
>> (I guess it moves the entire card back to a more safe IOS mode before
>> suspend), accidentally avoiding the bug.
>>
>> I assume you want to only call the DSM to set the voltage to 3.3V on
>> the affected model, or do you want to do this on all machines ?
> 
> I would stick with the specific machine for now.

Ok I will give this a try. Hopefully I can make some time for this the
coming days.

>> Adding this does seem to introduce more complexity then simply disabling
>> 1.8V modes and given that it is just a single model which is affected
>> I went with the more simple option of just disabling the 1.8V modes.
>>
>> Ideally we would not need any quirks, but if we do we should at least
>> make the work-around as simple as possible. So I've a slight preference
>> for just sticking with DHCI_QUIRK2_NO_1_8_V ...
>>
>> Note that the suspend/resume handling is broken also in the sense that
>> it does not disable the signal voltage during suspend.
> 
> The bus power gets switched off if the card is runtime suspended.  The host
> controller should go to D3cold which means everything off.

Right, what I mean is that the _PS3 method is broken in that it does
not turn off the voltage-regulator providing the signal voltage, as
it does do on other machines with a non buggy implementation.

>>>> So far we have mostly been able to avoid using device specific quirks in
>>>> the sdhci-acpi code, but given that this issue is specific to this one
>>>> model and we certainly do not want to disable 1.8V modes everywhere I
>>>> see no other option.
>>>>
>>>> This commit adds a new mechanism for setting sdhci-acpi specific quirks
>>>> and a matching sdhci-acpi.quirks module parameter to make testing quirks /
>>>> similar issues on other devices easier.
>>>>
>>>> The first quirk supported by this mechanism is SDHCI_ACPI_QUIRK_SD_NO_1_8V,
>>>> which when set causes any slots with the SDHCI_ACPI_SD_CD flag to get the
>>>> SDHCI_QUIRK2_NO_1_8_V quirk set on their sdhci_host.
>>>>
>>>> This commit also adds a DMI table for specifying default quirks for some
>>>> models and adds an entry for the Lenovo Miix 320-10ICR which enables the
>>>> SDHCI_QUIRK2_NO_1_8_V by default on this model, fixing the LCD going black
>>>> when the external microSD slot is used.
>>>>
>>>> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=111294
>>>> BugLink: https://gitlab.freedesktop.org/drm/intel/issues/355
>>>> Reported-by: russianneuromancer <russianneuromancer@ya.ru>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    drivers/mmc/host/sdhci-acpi.c | 39 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 39 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>>>> index 105e73d4a3b9..9f150c73e958 100644
>>>> --- a/drivers/mmc/host/sdhci-acpi.c
>>>> +++ b/drivers/mmc/host/sdhci-acpi.c
>>>> @@ -23,6 +23,7 @@
>>>>    #include <linux/pm.h>
>>>>    #include <linux/pm_runtime.h>
>>>>    #include <linux/delay.h>
>>>> +#include <linux/dmi.h>
>>>>      #include <linux/mmc/host.h>
>>>>    #include <linux/mmc/pm.h>
>>>> @@ -75,6 +76,14 @@ struct sdhci_acpi_host {
>>>>        unsigned long            private[0] ____cacheline_aligned;
>>>>    };
>>>>    +enum {
>>>> +    SDHCI_ACPI_QUIRK_SD_NO_1_8V            = BIT(0),
>>>> +};
>>>> +
>>>> +static int quirks = -1;
>>>> +module_param(quirks, int, 0444);
>>>> +MODULE_PARM_DESC(quirks, "Override sdhci-acpi specific quirks");
>>>
>>> Why is a module parameter needed?
>>
>> The module parameter is purely to make testing if the same quirk(s)
>> help on other devices easier. Like the debug_quirks[2] params in sdhci.c
> 
> Mmm, but we already have SDHCI_QUIRK2_NO_1_8_V

True, but this only applies to the sdcard slot and not to the eMMC,
also you are asking for this to be changed to:

SDHCI_ACPI_QUIRK_SD_SET_SIGNAL_3_3V_ON_SUSPEND

Which is not duplicate. Anyways if you dislike the module parameter
bits I can drop them and make this only available through the DMI quirks.

Regards,

Hans



> 
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>>> +
>>>>    static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
>>>>    {
>>>>        return (void *)c->private;
>>>> @@ -647,6 +656,24 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>>>>    };
>>>>    MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>>>>    +static const struct dmi_system_id sdhci_acpi_quirks[] = {
>>>> +    {
>>>> +        /*
>>>> +         * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
>>>> +         * the SHC1 ACPI device, this bug causes it to reprogram the
>>>> +         * wrong LDO (DLDO3) to 1.8V if 1.8V modes are used and the
>>>> +         * card is (runtime) suspended + resumed. DLDO3 is used for
>>>> +         * the LCD and setting it to 1.8V causes the LCD to go black.
>>>> +         */
>>>> +        .matches = {
>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>> +            DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
>>>> +        },
>>>> +        .driver_data = (void *)SDHCI_ACPI_QUIRK_SD_NO_1_8V,
>>>> +    },
>>>> +    {} /* Terminating entry */
>>>> +};
>>>> +
>>>>    static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct
>>>> acpi_device *adev)
>>>>    {
>>>>        const struct sdhci_acpi_uid_slot *u;
>>>> @@ -663,6 +690,7 @@ static int sdhci_acpi_probe(struct platform_device
>>>> *pdev)
>>>>        struct device *dev = &pdev->dev;
>>>>        const struct sdhci_acpi_slot *slot;
>>>>        struct acpi_device *device, *child;
>>>> +    const struct dmi_system_id *id;
>>>>        struct sdhci_acpi_host *c;
>>>>        struct sdhci_host *host;
>>>>        struct resource *iomem;
>>>> @@ -670,6 +698,14 @@ static int sdhci_acpi_probe(struct platform_device
>>>> *pdev)
>>>>        size_t priv_size;
>>>>        int err;
>>>>    +    if (quirks == -1) {
>>>> +        id = dmi_first_match(sdhci_acpi_quirks);
>>>> +        if (id)
>>>> +            quirks = (long)id->driver_data;
>>>> +        else
>>>> +            quirks = 0;
>>>> +    }
>>>> +
>>>>        device = ACPI_COMPANION(dev);
>>>>        if (!device)
>>>>            return -ENODEV;
>>>> @@ -759,6 +795,9 @@ static int sdhci_acpi_probe(struct platform_device
>>>> *pdev)
>>>>                dev_warn(dev, "failed to setup card detect gpio\n");
>>>>                c->use_runtime_pm = false;
>>>>            }
>>>> +
>>>> +        if (quirks & SDHCI_ACPI_QUIRK_SD_NO_1_8V)
>>>> +            host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>>>        }
>>>>          err = sdhci_setup_host(host);
>>>>
>>>
>>
> 

