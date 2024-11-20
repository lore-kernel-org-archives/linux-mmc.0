Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551319F487
	for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108607; cv=none; b=R8t1c4DCyzTNPHBcikjS4nXuvyXfGcYYT7/d07qnTSQS0QngSg9oJzPoUj7p5nUhGHH/YB5RqOgVWuEzsnYvuEvnaFZB5GMDOhAJQ2JJpCmsSN3aY0IQmyxLDB+4bZ6eorluSVsh2CXLZFWOJ89swR9LIRA4ST3I+zNcfKH29Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108607; c=relaxed/simple;
	bh=PDMAmSI6yIVHmooGuirKMiPEiS99n4LezxjvP8256mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJAq5eD6J6cVhxi5UxRkpam+y6W5+YqBa8MuMcR+qZfvad89Ch02KMYIb0E9UTbqhJiZjPYZDt+m6jrsas7MfUmGdrobP5BB2/LP15BshwIYr/KhOkn0spHF9L6i0fglCglHhyCEK2fkATYDWDsq6f1TLw8+yyO38U0r37aty3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVL+nFVI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVL+nFVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732108604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2F/y7AyJblm6EIOp6isiTnhERvqaAs3aAn7aBC9rutM=;
	b=BVL+nFVIcW+cLSSzRlqnXk6T7jaAZreivLs1VKJb/a5L0kkiuJU68nfW8Rt5XTBk26FlVP
	dVmHKTcAphN2qqQYC+PqrODcR78cgdxYGvCa9Bha4bN2dGcFOpYUnlXoO3so4vfV3Hk4Xo
	p4QXTS4gOwEiStC7GqNY6K2B9/ivlJM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-ygCYlcefPJ-DIAnD8PP9_w-1; Wed, 20 Nov 2024 08:16:41 -0500
X-MC-Unique: ygCYlcefPJ-DIAnD8PP9_w-1
X-Mimecast-MFC-AGG-ID: ygCYlcefPJ-DIAnD8PP9_w
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a2ccb77ceso137387366b.2
        for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 05:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732108600; x=1732713400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2F/y7AyJblm6EIOp6isiTnhERvqaAs3aAn7aBC9rutM=;
        b=lQdBokGK8l0usl3XCvCLRYZOLLzh9O+iEOphEfGc81rQWYsOibvHAv60QQxG5dxSoz
         fzFrW9IMT28m5pN7X9hOcQ2z6Bq68B8fEM/fUG8QyBUvNRlisLle5/jQtyiaf1SuKeTX
         j30mrQQjy2cXs9LShsrGj4tmIjtNAuMgj5xU2Lit7fqmqwq4GCi1g6oWHE5OOpBL4j71
         ZID8UUQXqPRwKoGP1Q8zYz7QTLsX99w11fW/A17Yi9p9eaFRDJy0ySRU7e1nhRfiRtEE
         IHVUnbIuQ4j1HjWB3IB6NC+etxj1x27PclKjaJ4hduaeNbmfSP+hb0ZNSfFY6UvN/XhX
         EKCw==
X-Forwarded-Encrypted: i=1; AJvYcCUY20Ov5mdc/j/Xnj0mTbFprnjOs9vFwNXg1usPXkCUKFGPf9o1hwNapGNEdRw92Afkwyii95n+8Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vwOrV641OsxjupAsimvgQ9w7NNorIQKJLN5M6yANfV0PUlg0
	JKUw1YburUcSVS0BWUFL4j4U34PPNrv7luYbHJfd42JE6/L777lJoae/PHKiKzFT6fn3AqdT+cW
	o3j6HZ+cubVTgm0v3wrW+LbsFosXQ1M2Uq6eNDRhDp12Bzvt1G/AAcFDBWw==
X-Received: by 2002:a17:907:7295:b0:a9e:df65:3a81 with SMTP id a640c23a62f3a-aa4dd74cd25mr249832366b.59.1732108600156;
        Wed, 20 Nov 2024 05:16:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6hPTJWMc64WFFFLEpi9yq06FUS6bskew1PrA3EaLdmvdw0G2Fn1z43gj4sb/kbo4SM/1obQ==
X-Received: by 2002:a17:907:7295:b0:a9e:df65:3a81 with SMTP id a640c23a62f3a-aa4dd74cd25mr249829666b.59.1732108599742;
        Wed, 20 Nov 2024 05:16:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df2664csm760622566b.7.2024.11.20.05.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 05:16:39 -0800 (PST)
Message-ID: <29949ef6-9c55-48a3-a96e-67cb78b96766@redhat.com>
Date: Wed, 20 Nov 2024 14:16:38 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
References: <20241118210049.311079-1-hdegoede@redhat.com>
 <CAPDyKFov29aLGq4vmTZB45mfkLEAAsC_NMCv2u858K9XPdCPkg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAPDyKFov29aLGq4vmTZB45mfkLEAAsC_NMCv2u858K9XPdCPkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ulf,

On 20-Nov-24 1:56 PM, Ulf Hansson wrote:
> On Mon, 18 Nov 2024 at 22:01, Hans de Goede <hdegoede@redhat.com> wrote:
>>
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
> 
> I assume we should tag this for stable kernels,

Yes please.

> but can we find a fixes tag too?

This is really a hw / firmware bug not a kernel issue, so I cannot
really come up with a specific commit to point to as being fixed by
this.

Regards,

Hans




>> ---
>> Changes in v4:
>> - Count number of GPIOs in the lookup table instead of assuming it is
>>   always 1
>>
>> Changes in v3:
>> - Add a cd_gpio_override pointer to sdhci_pci_fixes
>> - Add sdhci_pci_add_gpio_lookup_table() helper which kmemdup-s a const
>>   struct gpiod_lookup_table to avoid races when using async probing
>>
>> Changes in v2:
>> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
>> - Drop duplicate #include <linux/dmi.h> (already there at the end)
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 72 +++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sdhci-pci.h      |  1 +
>>  2 files changed, 73 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index ed45ed0bdafd..2e2e15e2d8fb 100644
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
>>         .priv_size      = sizeof(struct intel_host),
>>  };
>>
>> +/* DMI quirks for devices with missing or broken CD GPIO info */
>> +static const struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
>> +       .dev_id = "0000:00:12.0",
>> +       .table = {
>> +               GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
>> +               { }
>> +       },
>> +};
>> +
>> +static const struct dmi_system_id sdhci_intel_byt_cd_gpio_override[] = {
>> +       {
>> +               /* Vexia Edu Atla 10 tablet 9V version */
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +                       DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
>> +                       /* Above strings are too generic, also match on BIOS date */
>> +                       DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
>> +               },
>> +               .driver_data = (void *)&vexia_edu_atla10_cd_gpios,
>> +       },
>> +       { }
>> +};
>> +
>>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>>  #ifdef CONFIG_PM_SLEEP
>>         .resume         = byt_resume,
>> @@ -1253,6 +1277,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>>         .add_host       = byt_add_host,
>>         .remove_slot    = byt_remove_slot,
>>         .ops            = &sdhci_intel_byt_ops,
>> +       .cd_gpio_override = sdhci_intel_byt_cd_gpio_override,
>>         .priv_size      = sizeof(struct intel_host),
>>  };
>>
>> @@ -2054,6 +2079,42 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
>>   *                                                                           *
>>  \*****************************************************************************/
>>
>> +static struct gpiod_lookup_table *sdhci_pci_add_gpio_lookup_table(
>> +       struct sdhci_pci_chip *chip)
>> +{
>> +       struct gpiod_lookup_table *cd_gpio_lookup_table;
>> +       const struct dmi_system_id *dmi_id = NULL;
>> +       size_t count;
>> +
>> +       if (chip->fixes && chip->fixes->cd_gpio_override)
>> +               dmi_id = dmi_first_match(chip->fixes->cd_gpio_override);
>> +
>> +       if (!dmi_id)
>> +               return NULL;
>> +
>> +       cd_gpio_lookup_table = dmi_id->driver_data;
>> +       for (count = 0; cd_gpio_lookup_table->table[count].key; count++)
>> +               ;
>> +
>> +       cd_gpio_lookup_table = kmemdup(dmi_id->driver_data,
>> +                                      /* count + 1 terminating entry */
>> +                                      struct_size(cd_gpio_lookup_table, table, count + 1),
>> +                                      GFP_KERNEL);
>> +       if (!cd_gpio_lookup_table)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       gpiod_add_lookup_table(cd_gpio_lookup_table);
>> +       return cd_gpio_lookup_table;
>> +}
>> +
>> +static void sdhci_pci_remove_gpio_lookup_table(struct gpiod_lookup_table *lookup_table)
>> +{
>> +       if (lookup_table) {
>> +               gpiod_remove_lookup_table(lookup_table);
>> +               kfree(lookup_table);
>> +       }
>> +}
>> +
>>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>         struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>>         int slotno)
>> @@ -2129,8 +2190,19 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>                 device_init_wakeup(&pdev->dev, true);
>>
>>         if (slot->cd_idx >= 0) {
>> +               struct gpiod_lookup_table *cd_gpio_lookup_table;
>> +
>> +               cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
>> +               if (IS_ERR(cd_gpio_lookup_table)) {
>> +                       ret = PTR_ERR(cd_gpio_lookup_table);
>> +                       goto remove;
>> +               }
>> +
>>                 ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>>                                            slot->cd_override_level, 0);
>> +
>> +               sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
>> +
>>                 if (ret && ret != -EPROBE_DEFER)
>>                         ret = mmc_gpiod_request_cd(host->mmc, NULL,
>>                                                    slot->cd_idx,
>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
>> index 153704f812ed..4973fa859217 100644
>> --- a/drivers/mmc/host/sdhci-pci.h
>> +++ b/drivers/mmc/host/sdhci-pci.h
>> @@ -156,6 +156,7 @@ struct sdhci_pci_fixes {
>>  #endif
>>
>>         const struct sdhci_ops  *ops;
>> +       const struct dmi_system_id *cd_gpio_override;
>>         size_t                  priv_size;
>>  };
>>
>> --
>> 2.47.0
>>
> 

