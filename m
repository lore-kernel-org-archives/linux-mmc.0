Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78EB1990AE
	for <linux-mmc@vger.kernel.org>; Mon, 18 Nov 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931875; cv=none; b=nyVV43vY0subcZdOKyqhdj94u201CrMVePIKvK3og8VR9INepTwAiN4zZTw6wpxw/ckkjcJxntDXQGjvw7v84AtJVxqnypn82yEOJRcyJIkADXjZu/wvVn0UsxrYocOTIgMvfIyXJpxdVyEWjrWt3xd4ILc/4GpmqUtHh6V9Pio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931875; c=relaxed/simple;
	bh=kglXKhzPth9AprGFk5w+/iIaDZi/vBUERLtYnOWT6qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyYml2lMdiW3acooXIzpCm7EzXDUjE9b12sEbU9NJbp+5ppWc2R6tATHfH8PWzKOxJX6Tvsyo+N8twM3jv1ZwqHzWPqhdqH1SyoLwlCy8pqMpoc4VBqUHWHeDLor0D8yWlL+AQiyrn8+cDwFsTTSUN+yH5meWVe7puEX2iDdBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6XJVmqQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6XJVmqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731931874; x=1763467874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kglXKhzPth9AprGFk5w+/iIaDZi/vBUERLtYnOWT6qY=;
  b=M6XJVmqQRkI6b8XA3tmmElwoxM8IyWZDOEZCmDtY3lF8v/qKquncobK2
   NFcYStvWoNlDVUFqj+3xpScpg216N7fjTfUkyOVR13snPnpC45fV/7JC4
   uC7RfwcvBEpoTvUeuBeQhxg5m3y9vffT2QjSwtmV1zTU2U6W4pwFaRzEu
   5fQgmOhQmL9EwMfPUH45XNvDs1izX96yNJTCpyYHC8XbaotXVvnggIQdh
   U+jC9K8To2MWDEtAxSWgQ37pzWQ1aDysGE/QppEPM3lAzipRQcGrvorGd
   IPl0m2ChdhsfhxrJr5ZjgoK/GYH7l3JijRDE/W7JMfiZ7VUeiBo2JEXEI
   Q==;
X-CSE-ConnectionGUID: 5NPPT4eBTfuarJHEnqByNg==
X-CSE-MsgGUID: fneHB8EvRweV/fq3GTPyfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="49422631"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="49422631"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:11:13 -0800
X-CSE-ConnectionGUID: 5OHClgX0QU6wnT3/XI/w3w==
X-CSE-MsgGUID: G1kT11C4SsOuNE/P2aRnSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94263055"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:11:12 -0800
Message-ID: <e01daac8-1914-4630-af8e-efa50434187b@intel.com>
Date: Mon, 18 Nov 2024 14:11:06 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
References: <20241114155611.59577-1-hdegoede@redhat.com>
 <2008ebd5-b1d1-417e-bd88-9d4c0a381e7d@intel.com>
 <1196b26c-e5d3-4f2d-a97b-688e9825c98a@redhat.com>
 <686a5c43-ac82-4506-ade8-e666a538abd5@intel.com>
 <5535807c-ce12-45a7-a7ea-44c03474e692@redhat.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <5535807c-ce12-45a7-a7ea-44c03474e692@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/11/24 13:53, Hans de Goede wrote:
> Hi,
> 
> On 18-Nov-24 11:10 AM, Adrian Hunter wrote:
>> On 16/11/24 13:25, Hans de Goede wrote:
>>> Hi Adrian,
>>>
>>> On 15-Nov-24 8:33 AM, Adrian Hunter wrote:
>>>> On 14/11/24 17:56, Hans de Goede wrote:
>>>>> The Vexia Edu Atla 10 tablet distributed to schools in the Spanish
>>>>> Andalucía region has no ACPI fwnode associated with the SDHCI controller
>>>>> for its microsd-slot and thus has no ACPI GPIO resource info.
>>>>>
>>>>> This causes the following error to be logged and the slot to not work:
>>>>> [   10.572113] sdhci-pci 0000:00:12.0: failed to setup card detect gpio
>>>>>
>>>>> Add a DMI quirk table for providing gpiod_lookup_tables with manually
>>>>> provided CD GPIO info and use this DMI table to provide the CD GPIO info
>>>>> on this tablet. This fixes the microsd-slot not working.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>> Changes in v3:
>>>>> - Add a cd_gpio_override pointer to sdhci_pci_fixes
>>>>> - Add sdhci_pci_add_gpio_lookup_table() helper which kmemdup-s a const
>>>>>   struct gpiod_lookup_table to avoid races when using async probing
>>>>>
>>>>> Changes in v2:
>>>>> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
>>>>> - Drop duplicate #include <linux/dmi.h> (already there at the end)
>>>>> ---
>>>>>  drivers/mmc/host/sdhci-pci-core.c | 67 +++++++++++++++++++++++++++++++
>>>>>  drivers/mmc/host/sdhci-pci.h      |  1 +
>>>>>  2 files changed, 68 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>>>> index ed45ed0bdafd..a2ddbe3d8742 100644
>>>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>>>> @@ -21,6 +21,7 @@
>>>>>  #include <linux/io.h>
>>>>>  #include <linux/iopoll.h>
>>>>>  #include <linux/gpio.h>
>>>>> +#include <linux/gpio/machine.h>
>>>>>  #include <linux/pm_runtime.h>
>>>>>  #include <linux/pm_qos.h>
>>>>>  #include <linux/debugfs.h>
>>>>> @@ -1235,6 +1236,29 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>>>>>  	.priv_size	= sizeof(struct intel_host),
>>>>>  };
>>>>>  
>>>>> +/* DMI quirks for devices with missing or broken CD GPIO info */
>>>>> +static const struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
>>>>> +	.dev_id = "0000:00:12.0",
>>>>> +	.table = {
>>>>> +		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
>>>>> +		{ }
>>>>> +	},
>>>>> +};
>>>>
>>>> This is good but I feel like we should make it more difficult
>>>> to get the size wrong.  Could introduce another struct to hold
>>>> the size:
>>>>
>>>> struct sdhci_pci_gpio_data {
>>>> 	const struct gpiod_lookup_table *gpios;
>>>> 	size_t size;
>>>> };
>>>>
>>>> static const struct sdhci_pci_gpio_data vexia_edu_atla10_cd_gpio_data = {
>>>> 	.gpios = &vexia_edu_atla10_cd_gpios,
>>>> 	.size  = sizeof(vexia_edu_atla10_cd_gpios),
>>>> };
>>>>
>>>> So:
>>>> 		.driver_data = (void *)&vexia_edu_atla10_cd_gpio_data,
>>>> and
>>>> 	struct sdhci_pci_gpio_data *data;
>>>> 	...
>>>> 	data = dmi_id->driver_data;
>>>>
>>>> 	cd_gpio_lookup_table = kmemdup(data->gpios, data->size, GFP_KERNEL);
>>>
>>> Interesting idea. But I'm afraid that sizeof(variable-name) on a struct
>>> with a flexible array member returns the same as just sizeof(struct struct-name)
>>> I added the following debug print to verify this:
>>>
>>>  static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
>>>  {
>>> + pr_info("sizeof(vexia_edu_atla10_cd_gpios) %lu sizeof(struct gpiod_lookup_table) %lu\n",
>>> +         sizeof(vexia_edu_atla10_cd_gpios), sizeof(struct gpiod_lookup_table));
>>>         byt_probe_slot(slot);
>>>         slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
>>>                                  MMC_CAP_AGGRESSIVE_PM | MMC_CAP_CD_WAKE;
>>>
>>> And that prints:
>>>
>>> [   10.459681] sizeof(vexia_edu_atla10_cd_gpios) 24 sizeof(struct gpiod_lookup_table) 24
>>>
>>> So using sizeof(vexia_edu_atla10_cd_gpios) to get the size including the 2
>>> flexible array members does not work since sizeof() does not take into
>>> account the size of the flexible array members.
>>
>> Thanks for spotting that!
>>
>> Perhaps we should check the table size then?
>> e.g.
>> 	struct gpiod_lookup_table *table;
>> 	size_t count;
>>
>> 	...
>>
>> 	table = dmi_id->driver_data;
>> 	for (count = 0; table->table[count].key; count++)
>> 		;
>> 	if (count != 1)
>> 		return ERR_PTR(-EINVAL);
> 
> That works for me, but why not just use the found count instead of
> returning -EINVAL ?

I was thinking it avoids the count == 0 case, but I guess it
doesn't actually matter.

The kmemdup size would need to use count + 1

> 
> Regards,
> 
> Hans
> 
> 
> 
>>
>>>>
>>>>> +
>>>>> +static const struct dmi_system_id sdhci_intel_byt_cd_gpio_override[] = {
>>>>> +	{
>>>>> +		/* Vexia Edu Atla 10 tablet 9V version */
>>>>> +		.matches = {
>>>>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>>>>> +			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
>>>>> +			/* Above strings are too generic, also match on BIOS date */
>>>>> +			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
>>>>> +		},
>>>>> +		.driver_data = (void *)&vexia_edu_atla10_cd_gpios,
>>>>> +	},
>>>>> +	{ }
>>>>> +};
>>>>> +
>>>>>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>>>>>  #ifdef CONFIG_PM_SLEEP
>>>>>  	.resume		= byt_resume,
>>>>> @@ -1253,6 +1277,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>>>>>  	.add_host	= byt_add_host,
>>>>>  	.remove_slot	= byt_remove_slot,
>>>>>  	.ops		= &sdhci_intel_byt_ops,
>>>>> +	.cd_gpio_override = sdhci_intel_byt_cd_gpio_override,
>>>>>  	.priv_size	= sizeof(struct intel_host),
>>>>>  };
>>>>>  
>>>>> @@ -2054,6 +2079,37 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
>>>>>   *                                                                           *
>>>>>  \*****************************************************************************/
>>>>>  
>>>>> +static struct gpiod_lookup_table *sdhci_pci_add_gpio_lookup_table(
>>>>> +	struct sdhci_pci_chip *chip)
>>>>
>>>> Let's not line wrap until 100 columns
>>>>
>>>>> +{
>>>>> +	struct gpiod_lookup_table *cd_gpio_lookup_table;
>>>>> +	const struct dmi_system_id *dmi_id = NULL;
>>>>> +
>>>>> +	if (chip->fixes && chip->fixes->cd_gpio_override)
>>>>> +		dmi_id = dmi_first_match(chip->fixes->cd_gpio_override);
>>>>> +
>>>>> +	if (!dmi_id)
>>>>> +		return NULL;
>>>>> +
>>>>> +	cd_gpio_lookup_table = kmemdup(dmi_id->driver_data,
>>>>> +				       /* 1 GPIO lookup entry + 1 terminating entry */
>>>>> +				       struct_size(cd_gpio_lookup_table, table, 2),
>>>>> +				       GFP_KERNEL);
>>>>> +	if (!cd_gpio_lookup_table)
>>>>> +		return ERR_PTR(-ENOMEM);
>>>>> +
>>>>> +	gpiod_add_lookup_table(cd_gpio_lookup_table);
>>>>> +	return cd_gpio_lookup_table;
>>>>> +}
>>>>> +
>>>>> +static void sdhci_pci_remove_gpio_lookup_table(struct gpiod_lookup_table *lookup_table)
>>>>> +{
>>>>> +	if (lookup_table) {
>>>>> +		gpiod_remove_lookup_table(lookup_table);
>>>>> +		kfree(lookup_table);
>>>>> +	}
>>>>> +}
>>>>> +
>>>>>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>>>  	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>>>>>  	int slotno)
>>>>> @@ -2129,8 +2185,19 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>>>  		device_init_wakeup(&pdev->dev, true);
>>>>>  
>>>>>  	if (slot->cd_idx >= 0) {
>>>>> +		struct gpiod_lookup_table *cd_gpio_lookup_table;
>>>>> +
>>>>> +		cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
>>>>> +		if (IS_ERR(cd_gpio_lookup_table)) {
>>>>> +			ret = PTR_ERR(cd_gpio_lookup_table);
>>>>> +			goto remove;
>>>>> +		}
>>>>> +
>>>>>  		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>>>>>  					   slot->cd_override_level, 0);
>>>>> +
>>>>> +		sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
>>>>> +
>>>>>  		if (ret && ret != -EPROBE_DEFER)
>>>>>  			ret = mmc_gpiod_request_cd(host->mmc, NULL,
>>>>>  						   slot->cd_idx,
>>>>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
>>>>> index 153704f812ed..4973fa859217 100644
>>>>> --- a/drivers/mmc/host/sdhci-pci.h
>>>>> +++ b/drivers/mmc/host/sdhci-pci.h
>>>>> @@ -156,6 +156,7 @@ struct sdhci_pci_fixes {
>>>>>  #endif
>>>>>  
>>>>>  	const struct sdhci_ops	*ops;
>>>>> +	const struct dmi_system_id *cd_gpio_override;
>>>>>  	size_t			priv_size;
>>>>>  };
>>>>>  
>>>>
>>>
>>
> 

