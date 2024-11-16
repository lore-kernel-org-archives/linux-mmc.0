Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A50198841
	for <linux-mmc@vger.kernel.org>; Sat, 16 Nov 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756318; cv=none; b=T5kXoiurqo0YMDFTuOs4Qn0Sf3zkihyapEAV1Qfx8mmARJhH1CRAh+halsAWjd2HBiTrHtV6pRFkXdnFwhK1EhcjYhRToUFHEd4Dgfe0y/U79EPBfCgnKQe/8WptutxTJWukDCk2LtsAw48lyNIcW3fXIlNzytzh7J2Z+JwXKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756318; c=relaxed/simple;
	bh=Z5tCr5TvLeYIjsY4z9c2M10VBZmURA4rndCvebuXj8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTbhLWLt+kQyW8QWk3hV2MG4xii805cpfbfI19DEV1Trz7DJA2m4yXF5mS9Macn3aaB6eufjK6Ihb6bM6xzfKrr7gkpeVKplkK4h3pJiV8L4tZnBjfvBR6D/Uw1XKW9AJLc5nCWoCNI4w10my+tf5JngmVtSfUhwonHxfEbMJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6V2QwcA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6V2QwcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731756313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxRkLS80oukV8+4jPUNRl44I6NsljTdEdGFm9DwM5J0=;
	b=h6V2QwcA3dGaEU4JJWZYkfbOWUVH7AV1Ov4QRl3EmrTXG4UQgKooDQUbcLt6nbrSf3BMG1
	fiWjIiGEOYvcNvN3EUa6ME646kdsaoO/hhd+QKen2madAGZYIc8jfJVyu5RZ0aL0KnV9/w
	OVKIx0IdiEdZ8l6AAsoM53TnYrV+nec=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-NE8szjJDPBqkP4ujsAz0LQ-1; Sat, 16 Nov 2024 06:25:11 -0500
X-MC-Unique: NE8szjJDPBqkP4ujsAz0LQ-1
X-Mimecast-MFC-AGG-ID: NE8szjJDPBqkP4ujsAz0LQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a2a81ab82so214763266b.1
        for <linux-mmc@vger.kernel.org>; Sat, 16 Nov 2024 03:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731756310; x=1732361110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxRkLS80oukV8+4jPUNRl44I6NsljTdEdGFm9DwM5J0=;
        b=e4IrOe2cCBt2jCnDZ9LxxVN3D9w+fpNGsMA0lGBckGRt5UNiwuZEK2j6t/TgTtmPJH
         DM8ufVgCu54zLBqrgYJahrcHEIfsla+yIp1CapN1kTuwfVmsTTFvSdyqoPr/QNrdqGHO
         fJDQa04GwRRidIxe4iSf8ZgezWh5VWM2frpSIvGCgp0H27TDigxDxaIzCB0PX/h1Zq8B
         NrN05SZrcsKu/oK//pSPVy1/YxGqZnDeuV3SmLGbt8z6TfmWl07zxJIHoqrwg4TprH0O
         YkbobDiTAXAcxu6AQEKKVpfBnHZTbkyFynEhDSDmOsFourfgdM2C2baTXopuOoLk4cx4
         LlNw==
X-Gm-Message-State: AOJu0YyReBcW7iB6faHvdTG8qMzfi6W/ngdGXjhRkBNW5n2c7d98VPTw
	rVyzVcvC77O7y5eix4y0zh06IgHVcMGNgJCSkygbvUZb5bC6aU6q65AQoZNnhBmNp2ZmNWlPF+L
	AFJICLrSY+96H+ugGPmxLWQHG8Y1urgKjr3bU3R31hiBhnd4m3J9KZoCmww==
X-Received: by 2002:a17:907:31c2:b0:a9e:c4d2:fff0 with SMTP id a640c23a62f3a-aa483527166mr399884166b.45.1731756310577;
        Sat, 16 Nov 2024 03:25:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEh5HNHHf7myj2KReYkRIygkZOuPrHeLXbA5k6s3+WMSipXpBor8dUa4gN+dlfUion0yMmZg==
X-Received: by 2002:a17:907:31c2:b0:a9e:c4d2:fff0 with SMTP id a640c23a62f3a-aa483527166mr399882666b.45.1731756310156;
        Sat, 16 Nov 2024 03:25:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7f49dsm291470866b.91.2024.11.16.03.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 03:25:08 -0800 (PST)
Message-ID: <1196b26c-e5d3-4f2d-a97b-688e9825c98a@redhat.com>
Date: Sat, 16 Nov 2024 12:25:08 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
To: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
References: <20241114155611.59577-1-hdegoede@redhat.com>
 <2008ebd5-b1d1-417e-bd88-9d4c0a381e7d@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2008ebd5-b1d1-417e-bd88-9d4c0a381e7d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Adrian,

On 15-Nov-24 8:33 AM, Adrian Hunter wrote:
> On 14/11/24 17:56, Hans de Goede wrote:
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
>> Changes in v3:
>> - Add a cd_gpio_override pointer to sdhci_pci_fixes
>> - Add sdhci_pci_add_gpio_lookup_table() helper which kmemdup-s a const
>>   struct gpiod_lookup_table to avoid races when using async probing
>>
>> Changes in v2:
>> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
>> - Drop duplicate #include <linux/dmi.h> (already there at the end)
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 67 +++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sdhci-pci.h      |  1 +
>>  2 files changed, 68 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index ed45ed0bdafd..a2ddbe3d8742 100644
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
>> @@ -1235,6 +1236,29 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>>  	.priv_size	= sizeof(struct intel_host),
>>  };
>>  
>> +/* DMI quirks for devices with missing or broken CD GPIO info */
>> +static const struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
>> +	.dev_id = "0000:00:12.0",
>> +	.table = {
>> +		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
>> +		{ }
>> +	},
>> +};
> 
> This is good but I feel like we should make it more difficult
> to get the size wrong.  Could introduce another struct to hold
> the size:
> 
> struct sdhci_pci_gpio_data {
> 	const struct gpiod_lookup_table *gpios;
> 	size_t size;
> };
> 
> static const struct sdhci_pci_gpio_data vexia_edu_atla10_cd_gpio_data = {
> 	.gpios = &vexia_edu_atla10_cd_gpios,
> 	.size  = sizeof(vexia_edu_atla10_cd_gpios),
> };
> 
> So:
> 		.driver_data = (void *)&vexia_edu_atla10_cd_gpio_data,
> and
> 	struct sdhci_pci_gpio_data *data;
> 	...
> 	data = dmi_id->driver_data;
> 
> 	cd_gpio_lookup_table = kmemdup(data->gpios, data->size, GFP_KERNEL);

Interesting idea. But I'm afraid that sizeof(variable-name) on a struct
with a flexible array member returns the same as just sizeof(struct struct-name)
I added the following debug print to verify this:

 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
+ pr_info("sizeof(vexia_edu_atla10_cd_gpios) %lu sizeof(struct gpiod_lookup_table) %lu\n",
+         sizeof(vexia_edu_atla10_cd_gpios), sizeof(struct gpiod_lookup_table));
        byt_probe_slot(slot);
        slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
                                 MMC_CAP_AGGRESSIVE_PM | MMC_CAP_CD_WAKE;

And that prints:

[   10.459681] sizeof(vexia_edu_atla10_cd_gpios) 24 sizeof(struct gpiod_lookup_table) 24

So using sizeof(vexia_edu_atla10_cd_gpios) to get the size including the 2
flexible array members does not work since sizeof() does not take into
account the size of the flexible array members.

Regards,

Hans




> 
>> +
>> +static const struct dmi_system_id sdhci_intel_byt_cd_gpio_override[] = {
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
>> +
>>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>>  #ifdef CONFIG_PM_SLEEP
>>  	.resume		= byt_resume,
>> @@ -1253,6 +1277,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>>  	.add_host	= byt_add_host,
>>  	.remove_slot	= byt_remove_slot,
>>  	.ops		= &sdhci_intel_byt_ops,
>> +	.cd_gpio_override = sdhci_intel_byt_cd_gpio_override,
>>  	.priv_size	= sizeof(struct intel_host),
>>  };
>>  
>> @@ -2054,6 +2079,37 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
>>   *                                                                           *
>>  \*****************************************************************************/
>>  
>> +static struct gpiod_lookup_table *sdhci_pci_add_gpio_lookup_table(
>> +	struct sdhci_pci_chip *chip)
> 
> Let's not line wrap until 100 columns
> 
>> +{
>> +	struct gpiod_lookup_table *cd_gpio_lookup_table;
>> +	const struct dmi_system_id *dmi_id = NULL;
>> +
>> +	if (chip->fixes && chip->fixes->cd_gpio_override)
>> +		dmi_id = dmi_first_match(chip->fixes->cd_gpio_override);
>> +
>> +	if (!dmi_id)
>> +		return NULL;
>> +
>> +	cd_gpio_lookup_table = kmemdup(dmi_id->driver_data,
>> +				       /* 1 GPIO lookup entry + 1 terminating entry */
>> +				       struct_size(cd_gpio_lookup_table, table, 2),
>> +				       GFP_KERNEL);
>> +	if (!cd_gpio_lookup_table)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	gpiod_add_lookup_table(cd_gpio_lookup_table);
>> +	return cd_gpio_lookup_table;
>> +}
>> +
>> +static void sdhci_pci_remove_gpio_lookup_table(struct gpiod_lookup_table *lookup_table)
>> +{
>> +	if (lookup_table) {
>> +		gpiod_remove_lookup_table(lookup_table);
>> +		kfree(lookup_table);
>> +	}
>> +}
>> +
>>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>  	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>>  	int slotno)
>> @@ -2129,8 +2185,19 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>  		device_init_wakeup(&pdev->dev, true);
>>  
>>  	if (slot->cd_idx >= 0) {
>> +		struct gpiod_lookup_table *cd_gpio_lookup_table;
>> +
>> +		cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
>> +		if (IS_ERR(cd_gpio_lookup_table)) {
>> +			ret = PTR_ERR(cd_gpio_lookup_table);
>> +			goto remove;
>> +		}
>> +
>>  		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>>  					   slot->cd_override_level, 0);
>> +
>> +		sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
>> +
>>  		if (ret && ret != -EPROBE_DEFER)
>>  			ret = mmc_gpiod_request_cd(host->mmc, NULL,
>>  						   slot->cd_idx,
>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
>> index 153704f812ed..4973fa859217 100644
>> --- a/drivers/mmc/host/sdhci-pci.h
>> +++ b/drivers/mmc/host/sdhci-pci.h
>> @@ -156,6 +156,7 @@ struct sdhci_pci_fixes {
>>  #endif
>>  
>>  	const struct sdhci_ops	*ops;
>> +	const struct dmi_system_id *cd_gpio_override;
>>  	size_t			priv_size;
>>  };
>>  
> 

