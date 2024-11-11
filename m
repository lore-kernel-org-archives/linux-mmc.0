Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F51411DE
	for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2024 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322857; cv=none; b=Bo1v8MEO+2JtU0IAt8x+I/RShAAHa6IdmzNJSR44piTAqzq1h4MHZ2HPmN5GPCkPdK12+MYKMSMO2xXlV6Xo8cFRrYvcAs8FKihq2cIICZfMnjoXN2KjumpkkSx6yH2mQjgrsOMObdSF11j6TMcKZzZiS0byENieoe2RQsrL9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322857; c=relaxed/simple;
	bh=zlEG1Om1211BInoegXbmrvnQOMj3Z2PjaIvOe1Xak9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyyHmNgg2h4UFY9BK+KS8eSx2lrrLM3yg20cHS/gy16paMddnCU8ECAwUR+fvH1nb5TTx8J8AZy/YMdAyNspRIALA6FqOhss/wQpLyUK91ZxCr+QMl8zmxUk2jB7h7ZJCVv5Nt5EuaPyvdfH2HhUteE5NGX+Bjz4kA8I8Z75muk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcoYzgW6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcoYzgW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731322854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3dAQsMTEssgat9lKjEyXzETRdpf0Qfu7w0Uux5ih7U=;
	b=CcoYzgW6MSYJp/ottqvHXua/1Fs2X5glf/xLXhHfxd0egLt2ivqx+xBdcVS+a6sjADHQCI
	tpdKQKZfss2XGpz4wtACKHDD4Ba35CayH3GFevSqeQJ9+Uc/BDCrWSMA+tTtntE8Eedg2w
	bkE55D3VYpCOZY3oZUW5mQKZimF725Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-IKciUA1rNzaCvphJQneRUw-1; Mon, 11 Nov 2024 06:00:53 -0500
X-MC-Unique: IKciUA1rNzaCvphJQneRUw-1
X-Mimecast-MFC-AGG-ID: IKciUA1rNzaCvphJQneRUw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a273e4251so395694066b.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2024 03:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322852; x=1731927652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3dAQsMTEssgat9lKjEyXzETRdpf0Qfu7w0Uux5ih7U=;
        b=FdIYDB0r3REKKA2b5DazAcy/v2bmHc+S3LTZOU3IpofJNLu+dlgciYqsI/SKzEGuXt
         QztF0wV1rkteZhAJFsKQHcDh7QwZIH/9laqv4UW9af9asWnED8DyZ7BAZ0zlOXqUxhAO
         iUC+2G2dIAjhKSE/lbMQEXLuGNXrK4U6ze5Wkhvtrn4dli8wQ/T8csQZBAm9Kj2LH1Qs
         Ar9xWt8Ir6OvJekJerUUGMLqfOMV5vILktf+EUSnWlmIgyuU8cunPpVHLu5nVDk1IIxU
         l4od/IFQn5ZLmi4S96GsqPBtrWwcd4Sgqqz4/pwDmGoM9frvDX70Yb/OLwrQOYVlocTi
         UHAw==
X-Gm-Message-State: AOJu0YyzXtub8pqhHVUwcpcvHU8wxgPr4nfOL5idcPsdoaq5oRmDabCS
	FCh2tTTgWn5FCO8FLxvOahqsa+LA/t7aubXWyPOlNvCS9HQd9PPEUtmdMamaLCWSRBZzYQ84L9T
	g3y/v2yyuGr9k9HPFmRxVOUDn1yHPfZpB90RUQ6toEtD5X9ii1/vNUBJKZg==
X-Received: by 2002:a17:907:98d:b0:a99:ee42:1f38 with SMTP id a640c23a62f3a-a9eeff37876mr1021941666b.31.1731322850282;
        Mon, 11 Nov 2024 03:00:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcyQo6igyVXQmUW0SwOSufSG0/2Oh2JDo9ATa+BRishjrO11x6Z7P6xLGgnLuaUC+qN6TFGg==
X-Received: by 2002:a17:907:98d:b0:a99:ee42:1f38 with SMTP id a640c23a62f3a-a9eeff37876mr1021928266b.31.1731322848305;
        Mon, 11 Nov 2024 03:00:48 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e3ffsm589798766b.183.2024.11.11.03.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 03:00:47 -0800 (PST)
Message-ID: <5d2afa86-73e0-4f4b-a1fc-953b647ada62@redhat.com>
Date: Mon, 11 Nov 2024 12:00:47 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
To: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
References: <20241107100048.11661-1-hdegoede@redhat.com>
 <22b456ed-6465-4090-84d8-448a695d80a7@intel.com>
 <010c6dff-6daf-4379-909e-6ba466076ba1@redhat.com>
 <44885e7b-5828-4a54-9985-e1f438950d24@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <44885e7b-5828-4a54-9985-e1f438950d24@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 11-Nov-24 11:56 AM, Adrian Hunter wrote:
> On 11/11/24 12:26, Hans de Goede wrote:
>> Hi Adrian,
>>
>> Thank you for the review.
>>
>> On 11-Nov-24 11:07 AM, Adrian Hunter wrote:
>>> On 7/11/24 12:00, Hans de Goede wrote:
>>>> The Vexia Edu Atla 10 tablet distributed to schools in the Spanish
>>>> Andalucía region has no ACPI fwnode associated with the SDHCI controller
>>>> for its microsd-slot and thus has no ACPI GPIO resource info.
>>>>
>>>> This causes the following error to be logged and the slot to not work:
>>>> [   10.572113] sdhci-pci 0000:00:12.0: failed to setup card detect gpio
>>>>
>>>> Add a DMI quirk table for providing gpiod_lookup_tables with manually
>>>> provided CD GPIO info and use this DMI table to provide the CD GPIO info
>>>> on this tablet. This fixes the microsd-slot not working.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> Changes in v2:
>>>> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
>>>> - Drop duplicate #include <linux/dmi.h> (already there at the end)
>>>> ---
>>>>  drivers/mmc/host/sdhci-pci-core.c | 38 +++++++++++++++++++++++++++++++
>>>>  1 file changed, 38 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>>> index ed45ed0bdafd..9c2bce5e88d9 100644
>>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>>> @@ -21,6 +21,7 @@
>>>>  #include <linux/io.h>
>>>>  #include <linux/iopoll.h>
>>>>  #include <linux/gpio.h>
>>>> +#include <linux/gpio/machine.h>
>>>>  #include <linux/pm_runtime.h>
>>>>  #include <linux/pm_qos.h>
>>>>  #include <linux/debugfs.h>
>>>> @@ -2054,6 +2055,29 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
>>>>   *                                                                           *
>>>>  \*****************************************************************************/
>>>>  
>>>> +/* DMI quirks for devices with missing or broken CD GPIO info */
>>>> +static struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
>>>> +	.dev_id = "0000:00:12.0",
>>>> +	.table = {
>>>> +		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
>>>> +		{ }
>>>> +	},
>>>> +};
>>>> +
>>>> +static const struct dmi_system_id sdhci_pci_dmi_cd_gpio_overrides[] = {
>>>> +	{
>>>> +		/* Vexia Edu Atla 10 tablet 9V version */
>>>> +		.matches = {
>>>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>>>> +			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
>>>> +			/* Above strings are too generic, also match on BIOS date */
>>>> +			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
>>>> +		},
>>>> +		.driver_data = (void *)&vexia_edu_atla10_cd_gpios,
>>>> +	},
>>>> +	{ }
>>>> +};
>>>
>>> Can this be in struct sdhci_pci_fixes?
>>
>> You mean at a "struct gpiod_lookup_table *cd_gpio_lookup_table" member
>> to struct sdhci_pci_fixes and then set that for this tablet from say
>> byt_sd_probe_slot() based on the DMI match (1) ?
> 
> I was thinking of adding sdhci_pci_dmi_cd_gpio_overrides to
> sdhci_pci_fixes and the whole lot can be const.  Can also add the same
> overrides to multiple sdhci_pci_fixes instances because it is just
> a pointer.
> 
> struct sdhci_pci_fixes {
> 
> 	const struct dmi_system_id *dmi_cd_gpio_overrides;
> 
> };

I see, will do for v3.

>> Before you ask I just checked and the PCI subsystem ids are generic
>> (which matches how broken the firmware is on this device in general).
>>
>> I did consider that, but that would require un-constifying 
>> "struct sdhci_pci_fixes sdhci_intel_byt_sd" so that byt_sd_probe_slot()
>> can modify it.
>>
>> I went with the current approach to be able to keep that struct const.
>> With your async probing argument from below I think making
>> byt_sd_probe_slot() set cd_gpio_lookup_table in sdhci_pci_fixes
>> is a good idea, even if it does require removing the const from
>> "struct sdhci_pci_fixes sdhci_intel_byt_sd".
>>
>> 1) Before you ask I just checked and the PCI subsystem ids are generic,
>> which matches how broken the firmware is on this device in general.
>>
>>
>>>> +
>>>>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>>  	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>>>>  	int slotno)
>>>> @@ -2129,8 +2153,22 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>>  		device_init_wakeup(&pdev->dev, true);
>>>>  
>>>>  	if (slot->cd_idx >= 0) {
>>>> +		struct gpiod_lookup_table *cd_gpio_lookup_table = NULL;
>>>> +		const struct dmi_system_id *dmi_id;
>>>> +
>>>> +		dmi_id = dmi_first_match(sdhci_pci_dmi_cd_gpio_overrides);
>>>> +		if (dmi_id)
>>>> +			cd_gpio_lookup_table = dmi_id->driver_data;
>>>> +
>>>> +		if (cd_gpio_lookup_table)
>>>> +			gpiod_add_lookup_table(cd_gpio_lookup_table);
>>>
>>> If we were probing asynchronously, gpiod_add_lookup_table() and
>>> gpiod_remove_lookup_table() could race.
>>
>> That is a good point.
>>
>>> I'd suggest making vexia_edu_atla10_cd_gpios const and kmemdup'ing
>>> and freeing it.
>>>
>>> Add helper functions something like:
>>>
>>> 		cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
>>> 		if (IS_ERR(cd_gpio_lookup_table)) {
>>> 			etc
>>> 		}
>>>
>>> 		...
>>>
>>> 		sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
>>>
>>>> +
>>>>  		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>>>>  					   slot->cd_override_level, 0);
>>>> +
>>>> +		if (cd_gpio_lookup_table)
>>>> +			gpiod_remove_lookup_table(cd_gpio_lookup_table);
>>>> +
>>>>  		if (ret && ret != -EPROBE_DEFER)
>>>>  			ret = mmc_gpiod_request_cd(host->mmc, NULL,
>>>>  						   slot->cd_idx,
>>>
>>
>> That should work yes, I do wonder after adding cd_gpio_lookup_table to
>> sdhci_pci_fixes only 1 controller will have it set (only the one for
>> the external slot, not the SDIO wifi and eMMC controllers).
>> So I think that this race goes away then, avoiding the need to kmemdup ?
> 
> Practically speaking, I guess, but I would prefer things to be correct
> no matter what/how hardware presents itself.
> 
>>
>> Note I'm fine with proceeding either way, just wondering if we cannot
>> keep things a bit more simple after adding cd_gpio_lookup_table to
>> sdhci_pci_fixes ?
> 
> Shouldn't be too bad.  Instead of sdhci_pci_dmi_cd_gpio_overrides being
> global it would be chip->fixes->dmi_cd_gpio_overrides, and add kmemdup
> and an error path for it.

Ok, I'll add the kmemdump helper for v3.

Regards,

Hans


