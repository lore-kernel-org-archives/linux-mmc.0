Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3E17DFE3
	for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320782; cv=none; b=raBGJ+K+JVELPP1EFz9KgBPZr/6FCRa/OztG1C5KXeLWk6vdehstp0zdG55oOZ9gVDi16HnNpOdPT/0onY33NM5AX4U2hbEYQfEQVegXZPLUG2hWh+1uONiL249ut4kGY66JzsnnR+TRfhoBzB2SfLslMq55panbdPeYE1xqfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320782; c=relaxed/simple;
	bh=WJHbTTlaus8HDexmkMppMLLxArV/QZXcmMILQj7jb6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWD3aq+piERW1hBdEuE34yZQEn0efkpxu9T0yJeHJYsCVIiIui3QvgZ/cSvHcw+1VPpFjDaEwRKanuLETcUveYGGFPAeUG7aaAlEduVpZD9Risute/iaIp30/hfTL+cklep5wM2mI/JQ5leymmh/Et8ergInwE25YGkp+PkVSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fS68fycc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fS68fycc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731320779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KkiOi/QiS/IGNoLZvCrkaKU1MAIjb4DKWvcFpXD3fE=;
	b=fS68fyccqM3HruWPpmH/U8mfB5cDySk+O9nSBGVdvcvq9ez9Riufx2aw4Zn6HpyGSLhvZn
	MoaovtP/9SOqGhx+EmLJYW2dneCbLvjdxkKcTrb/un4oJT2Jkvipo4QunAS/1d5ulP+G7G
	7UgeXUfFxmh2j+OCWm9B/GpO7mXF+g8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-8XxuaApeP7uqrXZYoGleGQ-1; Mon, 11 Nov 2024 05:26:18 -0500
X-MC-Unique: 8XxuaApeP7uqrXZYoGleGQ-1
X-Mimecast-MFC-AGG-ID: 8XxuaApeP7uqrXZYoGleGQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a157d028aso363558766b.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2024 02:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731320776; x=1731925576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KkiOi/QiS/IGNoLZvCrkaKU1MAIjb4DKWvcFpXD3fE=;
        b=mYxVniDpZAjRiscV+d21ENKt1qhV7+hY5byeJJLPfu6Elqs3PV/waq12kfIvyrCvXk
         7R3nrj4fn0uG+dRJQZ33EzNjheo4YNEOfBQ3rp+1sPYGPrbEh/pbA1r3wIh/zQOhKZhM
         tDmFE/kNThWnkhsqu4QpnX6Dm9tsegUPV+jNcwf8hpzebbb3//mEI3lN/Oy0353auvXf
         L45BG4XzwP8C5WTFyshbdahtyGZuBigGOs0mg5b7VHui67tSDBXKk6izDnfx7FhSe5C0
         C0sR01cxOfNOerPd8Ux4ftbshlSIw6LC846yw4nTzBwscirbesMjhmOvweocdsZdIt5I
         /+1Q==
X-Gm-Message-State: AOJu0Yz0HHOBUvCN3nMpwpF+QpNJGFVfFtrq80JyRhElP7eSKq6LSJ2z
	ZEAYSTYbdrVlAXRTsFHKnR5rJDwuu/5B9CQ/cx4rNN1+uH1gN4KJ1Hm3/+46BPNeUeECF56MpoP
	Lcx0YAd+iUk9/H6vanJm6Vg74PybNsEK9uIlEHIVHmh86TM17R2GVhjCeE4LVpS8wZQ==
X-Received: by 2002:a17:907:70b:b0:a9a:230b:ff2c with SMTP id a640c23a62f3a-a9eeff38619mr1009363166b.30.1731320776549;
        Mon, 11 Nov 2024 02:26:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFexL7tNQ7MAv2+XRpq4leQZgKKaoOAnKmyWGgF3VLKAv5k3d4r9ZfRS8hACyOMhYGoalW4UA==
X-Received: by 2002:a17:907:70b:b0:a9a:230b:ff2c with SMTP id a640c23a62f3a-a9eeff38619mr1009361466b.30.1731320776083;
        Mon, 11 Nov 2024 02:26:16 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2eb33sm587277466b.186.2024.11.11.02.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 02:26:15 -0800 (PST)
Message-ID: <010c6dff-6daf-4379-909e-6ba466076ba1@redhat.com>
Date: Mon, 11 Nov 2024 11:26:15 +0100
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
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <22b456ed-6465-4090-84d8-448a695d80a7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Adrian,

Thank you for the review.

On 11-Nov-24 11:07 AM, Adrian Hunter wrote:
> On 7/11/24 12:00, Hans de Goede wrote:
>> The Vexia Edu Atla 10 tablet distributed to schools in the Spanish
>> Andalucía region has no ACPI fwnode associated with the SDHCI controller
>> for its microsd-slot and thus has no ACPI GPIO resource info.
>>
>> This causes the following error to be logged and the slot to not work:
>> [   10.572113] sdhci-pci 0000:00:12.0: failed to setup card detect gpio
>>
>> Add a DMI quirk table for providing gpiod_lookup_tables with manually
>> provided CD GPIO info and use this DMI table to provide the CD GPIO info
>> on this tablet. This fixes the microsd-slot not working.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
>> - Drop duplicate #include <linux/dmi.h> (already there at the end)
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 38 +++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index ed45ed0bdafd..9c2bce5e88d9 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/io.h>
>>  #include <linux/iopoll.h>
>>  #include <linux/gpio.h>
>> +#include <linux/gpio/machine.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pm_qos.h>
>>  #include <linux/debugfs.h>
>> @@ -2054,6 +2055,29 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
>>   *                                                                           *
>>  \*****************************************************************************/
>>  
>> +/* DMI quirks for devices with missing or broken CD GPIO info */
>> +static struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
>> +	.dev_id = "0000:00:12.0",
>> +	.table = {
>> +		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
>> +		{ }
>> +	},
>> +};
>> +
>> +static const struct dmi_system_id sdhci_pci_dmi_cd_gpio_overrides[] = {
>> +	{
>> +		/* Vexia Edu Atla 10 tablet 9V version */
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
>> +			/* Above strings are too generic, also match on BIOS date */
>> +			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
>> +		},
>> +		.driver_data = (void *)&vexia_edu_atla10_cd_gpios,
>> +	},
>> +	{ }
>> +};
> 
> Can this be in struct sdhci_pci_fixes?

You mean at a "struct gpiod_lookup_table *cd_gpio_lookup_table" member
to struct sdhci_pci_fixes and then set that for this tablet from say
byt_sd_probe_slot() based on the DMI match (1) ?

Before you ask I just checked and the PCI subsystem ids are generic
(which matches how broken the firmware is on this device in general).

I did consider that, but that would require un-constifying 
"struct sdhci_pci_fixes sdhci_intel_byt_sd" so that byt_sd_probe_slot()
can modify it.

I went with the current approach to be able to keep that struct const.
With your async probing argument from below I think making
byt_sd_probe_slot() set cd_gpio_lookup_table in sdhci_pci_fixes
is a good idea, even if it does require removing the const from
"struct sdhci_pci_fixes sdhci_intel_byt_sd".

1) Before you ask I just checked and the PCI subsystem ids are generic,
which matches how broken the firmware is on this device in general.


>> +
>>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>  	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>>  	int slotno)
>> @@ -2129,8 +2153,22 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>  		device_init_wakeup(&pdev->dev, true);
>>  
>>  	if (slot->cd_idx >= 0) {
>> +		struct gpiod_lookup_table *cd_gpio_lookup_table = NULL;
>> +		const struct dmi_system_id *dmi_id;
>> +
>> +		dmi_id = dmi_first_match(sdhci_pci_dmi_cd_gpio_overrides);
>> +		if (dmi_id)
>> +			cd_gpio_lookup_table = dmi_id->driver_data;
>> +
>> +		if (cd_gpio_lookup_table)
>> +			gpiod_add_lookup_table(cd_gpio_lookup_table);
> 
> If we were probing asynchronously, gpiod_add_lookup_table() and
> gpiod_remove_lookup_table() could race.

That is a good point.

> I'd suggest making vexia_edu_atla10_cd_gpios const and kmemdup'ing
> and freeing it.
> 
> Add helper functions something like:
> 
> 		cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
> 		if (IS_ERR(cd_gpio_lookup_table)) {
> 			etc
> 		}
> 
> 		...
> 
> 		sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
> 
>> +
>>  		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>>  					   slot->cd_override_level, 0);
>> +
>> +		if (cd_gpio_lookup_table)
>> +			gpiod_remove_lookup_table(cd_gpio_lookup_table);
>> +
>>  		if (ret && ret != -EPROBE_DEFER)
>>  			ret = mmc_gpiod_request_cd(host->mmc, NULL,
>>  						   slot->cd_idx,
> 

That should work yes, I do wonder after adding cd_gpio_lookup_table to
sdhci_pci_fixes only 1 controller will have it set (only the one for
the external slot, not the SDIO wifi and eMMC controllers).
So I think that this race goes away then, avoiding the need to kmemdup ?

Note I'm fine with proceeding either way, just wondering if we cannot
keep things a bit more simple after adding cd_gpio_lookup_table to
sdhci_pci_fixes ?

Regards,

Hans


