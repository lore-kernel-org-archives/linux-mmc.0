Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA1149C4D
	for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319646; cv=none; b=m1yJKPKU6tXXv4RAAAfOyWb3dURnRyEa9/ilh0ih4cNJEUUqL5KvGXVCpjd4B3qKdINJNvOjnDaRfT0LNfjc+Ryoxa2oZ0R96dB2CV6D1HvbSBs0M4MW1bgvtjpQYoOeaCmBWR6A7DmMuBEHL9BCotDhKRdnXMxZfpzQHGU7FwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319646; c=relaxed/simple;
	bh=rsuVNb4JS0GNp6LTKxtvVJqNM4I+2tAMMxLfBibTzPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKZVnz5tQqgPVQrTOXFgHXe/dUM7gCFDAgrpUmMcWbyA8302qpuSATmd/fhD36eVy8XwT0plxZ4opplXfkdslNH95snCAdzhJl3sTcyIOhF6T8Azs5Z1xP0/7uvCP8QONw4YeUr+UqVHkANIpkFtOoeZ0oNFL4kF3V11MBkJ/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrQohBQ3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrQohBQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731319645; x=1762855645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rsuVNb4JS0GNp6LTKxtvVJqNM4I+2tAMMxLfBibTzPg=;
  b=DrQohBQ3JRrEaK7SvjAzu2gD8D3eXx2rH0I7PhL3Xm+JlkQ2vCS/xw52
   lMDHpZU1aA3ejhhvKGX8LpeyDBoMXTZqQs0NjSqUPbX9238yvkRyYx/nd
   wsW5KGLcMfWBOMedsUv1qPkNbT+Ss83S9KzBBxUoq+VjpgVRWxMV4crw9
   xjCNFb3AWP1QsP7Zh82zHZ2bCgnouEF4vNw8U0ndd5RXjjKQ7WDWc+4Tg
   beWNZaIRnLgqlvBbdqBWCo/z5GnCLQ5EPBP/6TZqWyXhOibHinUOvTdaf
   ppH8nqvaeV5dvLBGSg+zG0EkIqrjoWtjNu1wBePsslZJuEjbc9SWtDqM7
   A==;
X-CSE-ConnectionGUID: NlznV6X6TACzHlnz0eKrCA==
X-CSE-MsgGUID: ZFksBH+XTJiwMfrnFzDklg==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="18740330"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="18740330"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 02:07:22 -0800
X-CSE-ConnectionGUID: M3RAqvQiQcWURXuk0papmw==
X-CSE-MsgGUID: JytltEGgQQ+6z+NeXd6f/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117774116"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 02:07:20 -0800
Message-ID: <22b456ed-6465-4090-84d8-448a695d80a7@intel.com>
Date: Mon, 11 Nov 2024 12:07:17 +0200
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
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241107100048.11661-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/11/24 12:00, Hans de Goede wrote:
> The Vexia Edu Atla 10 tablet distributed to schools in the Spanish
> Andalucía region has no ACPI fwnode associated with the SDHCI controller
> for its microsd-slot and thus has no ACPI GPIO resource info.
> 
> This causes the following error to be logged and the slot to not work:
> [   10.572113] sdhci-pci 0000:00:12.0: failed to setup card detect gpio
> 
> Add a DMI quirk table for providing gpiod_lookup_tables with manually
> provided CD GPIO info and use this DMI table to provide the CD GPIO info
> on this tablet. This fixes the microsd-slot not working.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
> - Drop duplicate #include <linux/dmi.h> (already there at the end)
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 38 +++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index ed45ed0bdafd..9c2bce5e88d9 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
>  #include <linux/debugfs.h>
> @@ -2054,6 +2055,29 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
>   *                                                                           *
>  \*****************************************************************************/
>  
> +/* DMI quirks for devices with missing or broken CD GPIO info */
> +static struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
> +	.dev_id = "0000:00:12.0",
> +	.table = {
> +		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static const struct dmi_system_id sdhci_pci_dmi_cd_gpio_overrides[] = {
> +	{
> +		/* Vexia Edu Atla 10 tablet 9V version */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
> +			/* Above strings are too generic, also match on BIOS date */
> +			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
> +		},
> +		.driver_data = (void *)&vexia_edu_atla10_cd_gpios,
> +	},
> +	{ }
> +};

Can this be in struct sdhci_pci_fixes?

> +
>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>  	int slotno)
> @@ -2129,8 +2153,22 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  		device_init_wakeup(&pdev->dev, true);
>  
>  	if (slot->cd_idx >= 0) {
> +		struct gpiod_lookup_table *cd_gpio_lookup_table = NULL;
> +		const struct dmi_system_id *dmi_id;
> +
> +		dmi_id = dmi_first_match(sdhci_pci_dmi_cd_gpio_overrides);
> +		if (dmi_id)
> +			cd_gpio_lookup_table = dmi_id->driver_data;
> +
> +		if (cd_gpio_lookup_table)
> +			gpiod_add_lookup_table(cd_gpio_lookup_table);

If we were probing asynchronously, gpiod_add_lookup_table() and
gpiod_remove_lookup_table() could race.

I'd suggest making vexia_edu_atla10_cd_gpios const and kmemdup'ing
and freeing it.

Add helper functions something like:

		cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
		if (IS_ERR(cd_gpio_lookup_table)) {
			etc
		}

		...

		sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);

> +
>  		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>  					   slot->cd_override_level, 0);
> +
> +		if (cd_gpio_lookup_table)
> +			gpiod_remove_lookup_table(cd_gpio_lookup_table);
> +
>  		if (ret && ret != -EPROBE_DEFER)
>  			ret = mmc_gpiod_request_cd(host->mmc, NULL,
>  						   slot->cd_idx,

