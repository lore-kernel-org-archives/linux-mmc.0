Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5A3C10F25
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 14:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36C920866
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 14:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJpyTFpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgCFOK0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:10:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726974AbgCFOKY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Mar 2020 09:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583503823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4fpKOyMk2x04Cjd1kPcfMbY5aQcit6vBDIK28GeYw8=;
        b=QJpyTFpaaKrPq6E1biuC5klUXjZ8fxnLyNjcf+netlXwLxTGEg2Jk7bdT7tACziyRU97qT
        OOV1Q3e3kFVuh29+Ty+XcdESDeM0tk0rT17QtPw/CuWXcsAsOb5iOGNRL8Y/VqBJWzVouM
        Ev/mcPy9WImooRB2DHr3ZUldaEm8HfQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352--pCEMcyGMtif1mwZM8g8pg-1; Fri, 06 Mar 2020 09:10:17 -0500
X-MC-Unique: -pCEMcyGMtif1mwZM8g8pg-1
Received: by mail-wm1-f71.google.com with SMTP id p4so3819386wmp.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2020 06:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a4fpKOyMk2x04Cjd1kPcfMbY5aQcit6vBDIK28GeYw8=;
        b=gfvh7c7CdCllwgP7Qi0i0LuISPSjxmPcQnXFRsUlqLxk2ofVJkproVd1HmiaU7N91D
         G+OIYk8RltJScDrm+GqUW+9JFYJyb2ADyyVDtN+90C2h0fLRpEW9AukMBXsYrAbGx6GY
         Ox2n8hscEm5Jx/q2NXgxt9jxlAQTlxTK4rNwpcvIulfvXerT5NOHGERaEhZDShdluHyx
         l/Z5g3G3naoIppS3is28yRACNspgkDEP+KY2Z2pSiF9OWpH+IuddGWyvLYXbY+Gi/iLv
         io+j3gHJKycYnxvi0jhSYiq1uO5ADLQL7e4fP7M7LWbyUZnyyyx0o0CmPqdTbbZv4Pcf
         8BpA==
X-Gm-Message-State: ANhLgQ2PTzUB5SryHDShkSZnIzvQ6mcWL5N9q6G3yM9xjteV2wkdW72k
        xNpgRGrFTt+pY9crb/Lii2YTeFAHEkujyUKEO/UzAPna1nUH6wpIFPNIQi9ycVLRvQ7aC/UGkJM
        DGMQseVB6Kye6R1d71xq1
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr4181650wru.127.1583503815730;
        Fri, 06 Mar 2020 06:10:15 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsNColWVx2PD4YJRb7Pu2WfRiRp33y1Gv7GL79VHJfbFmsBCDvqBDs6FMzyltdqf/Ucb0Owlw==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr4181620wru.127.1583503815334;
        Fri, 06 Mar 2020 06:10:15 -0800 (PST)
Received: from x1.localdomain ([2a0e:5700:4:11:42c0:3c5d:2f33:1a6c])
        by smtp.gmail.com with ESMTPSA id h17sm50267861wro.52.2020.03.06.06.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:10:13 -0800 (PST)
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
Message-ID: <23a84fd3-bed2-eb8c-fabf-e56979e100f1@redhat.com>
Date:   Fri, 6 Mar 2020 15:10:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
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

On 1/15/20 2:48 PM, Adrian Hunter wrote:
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

Ok I've prepared a new version of the patch for this, which resets the
signal voltage to 3.3V at the end of the (runtime)suspend handler using
the Intel DSM and this is only done on the affected model.

I can confirm that this workaround fixes the LCD going black, while
keeping UHS modes working.

I'll send out v2 of this patch-series soon.

Regards,

Hans



> 
>>
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
> 
>>
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

