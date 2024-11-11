Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F571474B9
	for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2024 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322585; cv=none; b=kDrhUgWDMHsTSsbh5dDpL4S6TUSSYS+onFNN7rDZ48G5558AINuLLzjY3bQSmPhgSanrozSBqvpxlNxFdnr5OSeDMXNS4nVD58fCIstDpOVRcT6CAFq24LCSeqJqO23KCV2Es0AQnRDPnvZRyJslQOawOOsgwLU1Ah5xKIN6YrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322585; c=relaxed/simple;
	bh=MrBtQbnev5GMu3a0H70ToTnWrc2k6Snnh0Pux1k+lJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFvC/akXSmnhwlwd7UrDQqN3PfTgiJBNcGxK/IGoSQkbmqWHq/46UPJaX9vYIMl66fSTWuPIeDqnaPKpd2hDHOnYJW4uorbOFu1oHOeHrKA+9hW21qW7TCbNhdXL2mvUKM3Bo4MT1TpwOtx6nSiKQmtCeDIF0NLWBC5RpwpjszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4aMXpmG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4aMXpmG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731322582; x=1762858582;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MrBtQbnev5GMu3a0H70ToTnWrc2k6Snnh0Pux1k+lJE=;
  b=m4aMXpmGzxq45a+IWumCPYyaTE07ipbeq8GWYEuSibTxdoof4KukDNQh
   1JWRfrNd0Cn3UpAzaxONPob0yWlOjrm1Qg31OMSgmkitiPEsnYf4WJ+HD
   5sJD0iPuYUIS68IjTMJ/ghOZnK/5rF71UCfeRYOSawlbgpKIyOzVOM03Z
   GtUPiI+Hof88dgx3b4tifc22C16rjIJbxI9dNsxWVRRGkEsxl1nO7tM9Q
   o3AjZQ6z2XJBCPhJ4HYyTiSRfGzOndNqTr7U0W5ruI/wuFAe1Cp981KTh
   sgQOhGV8wxq/WboxxLByfp/nKcDqWtX4isSX+OaSbn9quprinoXe5mErw
   g==;
X-CSE-ConnectionGUID: 5Mrpb47ZRzmlh8/OCd5fuw==
X-CSE-MsgGUID: d3PbXP2OTP6QA/7mOnWsoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="30521402"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="30521402"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 02:56:20 -0800
X-CSE-ConnectionGUID: c9lIGPeZQZWMG2RJIY40Ow==
X-CSE-MsgGUID: losXy6AYSQ2cRFwpnKU40Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="86820609"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 02:56:20 -0800
Message-ID: <44885e7b-5828-4a54-9985-e1f438950d24@intel.com>
Date: Mon, 11 Nov 2024 12:56:16 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
References: <20241107100048.11661-1-hdegoede@redhat.com>
 <22b456ed-6465-4090-84d8-448a695d80a7@intel.com>
 <010c6dff-6daf-4379-909e-6ba466076ba1@redhat.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <010c6dff-6daf-4379-909e-6ba466076ba1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/24 12:26, Hans de Goede wrote:
> Hi Adrian,
> 
> Thank you for the review.
> 
> On 11-Nov-24 11:07 AM, Adrian Hunter wrote:
>> On 7/11/24 12:00, Hans de Goede wrote:
>>> The Vexia Edu Atla 10 tablet distributed to schools in the Spanish
>>> Andalucía region has no ACPI fwnode associated with the SDHCI controller
>>> for its microsd-slot and thus has no ACPI GPIO resource info.
>>>
>>> This causes the following error to be logged and the slot to not work:
>>> [   10.572113] sdhci-pci 0000:00:12.0: failed to setup card detect gpio
>>>
>>> Add a DMI quirk table for providing gpiod_lookup_tables with manually
>>> provided CD GPIO info and use this DMI table to provide the CD GPIO info
>>> on this tablet. This fixes the microsd-slot not working.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
>>> - Drop duplicate #include <linux/dmi.h> (already there at the end)
>>> ---
>>>  drivers/mmc/host/sdhci-pci-core.c | 38 +++++++++++++++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>> index ed45ed0bdafd..9c2bce5e88d9 100644
>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>> @@ -21,6 +21,7 @@
>>>  #include <linux/io.h>
>>>  #include <linux/iopoll.h>
>>>  #include <linux/gpio.h>
>>> +#include <linux/gpio/machine.h>
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/pm_qos.h>
>>>  #include <linux/debugfs.h>
>>> @@ -2054,6 +2055,29 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
>>>   *                                                                           *
>>>  \*****************************************************************************/
>>>  
>>> +/* DMI quirks for devices with missing or broken CD GPIO info */
>>> +static struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
>>> +	.dev_id = "0000:00:12.0",
>>> +	.table = {
>>> +		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
>>> +		{ }
>>> +	},
>>> +};
>>> +
>>> +static const struct dmi_system_id sdhci_pci_dmi_cd_gpio_overrides[] = {
>>> +	{
>>> +		/* Vexia Edu Atla 10 tablet 9V version */
>>> +		.matches = {
>>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>>> +			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
>>> +			/* Above strings are too generic, also match on BIOS date */
>>> +			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
>>> +		},
>>> +		.driver_data = (void *)&vexia_edu_atla10_cd_gpios,
>>> +	},
>>> +	{ }
>>> +};
>>
>> Can this be in struct sdhci_pci_fixes?
> 
> You mean at a "struct gpiod_lookup_table *cd_gpio_lookup_table" member
> to struct sdhci_pci_fixes and then set that for this tablet from say
> byt_sd_probe_slot() based on the DMI match (1) ?

I was thinking of adding sdhci_pci_dmi_cd_gpio_overrides to
sdhci_pci_fixes and the whole lot can be const.  Can also add the same
overrides to multiple sdhci_pci_fixes instances because it is just
a pointer.

struct sdhci_pci_fixes {

	const struct dmi_system_id *dmi_cd_gpio_overrides;

};

> 
> Before you ask I just checked and the PCI subsystem ids are generic
> (which matches how broken the firmware is on this device in general).
> 
> I did consider that, but that would require un-constifying 
> "struct sdhci_pci_fixes sdhci_intel_byt_sd" so that byt_sd_probe_slot()
> can modify it.
> 
> I went with the current approach to be able to keep that struct const.
> With your async probing argument from below I think making
> byt_sd_probe_slot() set cd_gpio_lookup_table in sdhci_pci_fixes
> is a good idea, even if it does require removing the const from
> "struct sdhci_pci_fixes sdhci_intel_byt_sd".
> 
> 1) Before you ask I just checked and the PCI subsystem ids are generic,
> which matches how broken the firmware is on this device in general.
> 
> 
>>> +
>>>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>  	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>>>  	int slotno)
>>> @@ -2129,8 +2153,22 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>  		device_init_wakeup(&pdev->dev, true);
>>>  
>>>  	if (slot->cd_idx >= 0) {
>>> +		struct gpiod_lookup_table *cd_gpio_lookup_table = NULL;
>>> +		const struct dmi_system_id *dmi_id;
>>> +
>>> +		dmi_id = dmi_first_match(sdhci_pci_dmi_cd_gpio_overrides);
>>> +		if (dmi_id)
>>> +			cd_gpio_lookup_table = dmi_id->driver_data;
>>> +
>>> +		if (cd_gpio_lookup_table)
>>> +			gpiod_add_lookup_table(cd_gpio_lookup_table);
>>
>> If we were probing asynchronously, gpiod_add_lookup_table() and
>> gpiod_remove_lookup_table() could race.
> 
> That is a good point.
> 
>> I'd suggest making vexia_edu_atla10_cd_gpios const and kmemdup'ing
>> and freeing it.
>>
>> Add helper functions something like:
>>
>> 		cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
>> 		if (IS_ERR(cd_gpio_lookup_table)) {
>> 			etc
>> 		}
>>
>> 		...
>>
>> 		sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
>>
>>> +
>>>  		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>>>  					   slot->cd_override_level, 0);
>>> +
>>> +		if (cd_gpio_lookup_table)
>>> +			gpiod_remove_lookup_table(cd_gpio_lookup_table);
>>> +
>>>  		if (ret && ret != -EPROBE_DEFER)
>>>  			ret = mmc_gpiod_request_cd(host->mmc, NULL,
>>>  						   slot->cd_idx,
>>
> 
> That should work yes, I do wonder after adding cd_gpio_lookup_table to
> sdhci_pci_fixes only 1 controller will have it set (only the one for
> the external slot, not the SDIO wifi and eMMC controllers).
> So I think that this race goes away then, avoiding the need to kmemdup ?

Practically speaking, I guess, but I would prefer things to be correct
no matter what/how hardware presents itself.

> 
> Note I'm fine with proceeding either way, just wondering if we cannot
> keep things a bit more simple after adding cd_gpio_lookup_table to
> sdhci_pci_fixes ?

Shouldn't be too bad.  Instead of sdhci_pci_dmi_cd_gpio_overrides being
global it would be chip->fixes->dmi_cd_gpio_overrides, and add kmemdup
and an error path for it.

> 
> Regards,
> 
> Hans
> 
> 

