Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF051E545
	for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732083522; cv=none; b=U4B+kiF2+x1Y22pGV02mALzjzopLCQpRTZCp38NkLGAW75V1Y5D8rqJjFPlisdPuHQibrMs6VOpWbL+yXtVK4aHg94ZN48s1+u50uhAkxsxTQfcZYMypaOBA+HalULn5VDiQNTHpSoNf3Q66ERSNNA8EPHwHHSEasqjU8DXTZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732083522; c=relaxed/simple;
	bh=IKC02CbADvu8eHlGlPnVVSWib9PY2OAoxoS4QX7oiyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6ShhPZWEKfOQNEWeoi4gBtRKFElIBdVzFvdXRhV2hYDsQ9dJ4meLmW9n8lZLPZD307cdTAfgTi4nx8n+zaN6oLQLMQOfPBKHIRooG2l9pBZrwtGA2pzhKQTW1n8jqYgcnNr3QaJ6puzAlos7JpBdgOJxLAEDKHltulofXxoWyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epd8GOoc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epd8GOoc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732083521; x=1763619521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IKC02CbADvu8eHlGlPnVVSWib9PY2OAoxoS4QX7oiyY=;
  b=epd8GOocLugb4vw5obqwVkNhP4LwfseR2Da9RYSpqqNJJgZ/e1XxxWHW
   4uueyjKyTIByWIuX0NXLVXNH0wAAav8RTYtsogxDRE34H7B6c7qQFJPf/
   o7dXBrylfXnVTIIdMtfEqMblIFYLIG/fXLZg8yXkWCHNcyJZF40U7Wo2B
   bBUTvy+Y8licqjEQmSQJE3fg9tncNACR4LaOCaAlJAinFhUj3GpWAjJK7
   BBb+2QVNYx+DxoPGWnPV5iNFq8WV0Rksf+0gTZfT2+AoMxLsqyNPrnaCE
   BObLlPVlsI+ofFb3ThIFM+tuZXP/wo2UC/RwQ4ksbeY0XVSBb7CiS3vYk
   A==;
X-CSE-ConnectionGUID: Fksww16hQXOLtSgyH8kEWA==
X-CSE-MsgGUID: pzWu+lOJQl2FNtTTpNkVlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31494018"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="31494018"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 22:18:40 -0800
X-CSE-ConnectionGUID: 4X4y4ZgRTi+Hcq1/Ua85Tw==
X-CSE-MsgGUID: dNaKJmKgSCy7J95tO1S8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="90203110"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 22:18:38 -0800
Message-ID: <56f3ad3c-5fb2-4c5b-b745-84e8e6fd4e6d@intel.com>
Date: Wed, 20 Nov 2024 08:18:34 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
References: <20241118210049.311079-1-hdegoede@redhat.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241118210049.311079-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/11/24 23:00, Hans de Goede wrote:
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
> Changes in v4:
> - Count number of GPIOs in the lookup table instead of assuming it is
>   always 1

Looks good, thank you!

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Changes in v3:
> - Add a cd_gpio_override pointer to sdhci_pci_fixes
> - Add sdhci_pci_add_gpio_lookup_table() helper which kmemdup-s a const
>   struct gpiod_lookup_table to avoid races when using async probing
> 
> Changes in v2:
> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
> - Drop duplicate #include <linux/dmi.h> (already there at the end)
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 72 +++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |  1 +
>  2 files changed, 73 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index ed45ed0bdafd..2e2e15e2d8fb 100644
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
> @@ -1235,6 +1236,29 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>  	.priv_size	= sizeof(struct intel_host),
>  };
>  
> +/* DMI quirks for devices with missing or broken CD GPIO info */
> +static const struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
> +	.dev_id = "0000:00:12.0",
> +	.table = {
> +		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static const struct dmi_system_id sdhci_intel_byt_cd_gpio_override[] = {
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
> +
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>  #ifdef CONFIG_PM_SLEEP
>  	.resume		= byt_resume,
> @@ -1253,6 +1277,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>  	.add_host	= byt_add_host,
>  	.remove_slot	= byt_remove_slot,
>  	.ops		= &sdhci_intel_byt_ops,
> +	.cd_gpio_override = sdhci_intel_byt_cd_gpio_override,
>  	.priv_size	= sizeof(struct intel_host),
>  };
>  
> @@ -2054,6 +2079,42 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static struct gpiod_lookup_table *sdhci_pci_add_gpio_lookup_table(
> +	struct sdhci_pci_chip *chip)
> +{
> +	struct gpiod_lookup_table *cd_gpio_lookup_table;
> +	const struct dmi_system_id *dmi_id = NULL;
> +	size_t count;
> +
> +	if (chip->fixes && chip->fixes->cd_gpio_override)
> +		dmi_id = dmi_first_match(chip->fixes->cd_gpio_override);
> +
> +	if (!dmi_id)
> +		return NULL;
> +
> +	cd_gpio_lookup_table = dmi_id->driver_data;
> +	for (count = 0; cd_gpio_lookup_table->table[count].key; count++)
> +		;
> +
> +	cd_gpio_lookup_table = kmemdup(dmi_id->driver_data,
> +				       /* count + 1 terminating entry */
> +				       struct_size(cd_gpio_lookup_table, table, count + 1),
> +				       GFP_KERNEL);
> +	if (!cd_gpio_lookup_table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	gpiod_add_lookup_table(cd_gpio_lookup_table);
> +	return cd_gpio_lookup_table;
> +}
> +
> +static void sdhci_pci_remove_gpio_lookup_table(struct gpiod_lookup_table *lookup_table)
> +{
> +	if (lookup_table) {
> +		gpiod_remove_lookup_table(lookup_table);
> +		kfree(lookup_table);
> +	}
> +}
> +
>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>  	int slotno)
> @@ -2129,8 +2190,19 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  		device_init_wakeup(&pdev->dev, true);
>  
>  	if (slot->cd_idx >= 0) {
> +		struct gpiod_lookup_table *cd_gpio_lookup_table;
> +
> +		cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
> +		if (IS_ERR(cd_gpio_lookup_table)) {
> +			ret = PTR_ERR(cd_gpio_lookup_table);
> +			goto remove;
> +		}
> +
>  		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>  					   slot->cd_override_level, 0);
> +
> +		sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
> +
>  		if (ret && ret != -EPROBE_DEFER)
>  			ret = mmc_gpiod_request_cd(host->mmc, NULL,
>  						   slot->cd_idx,
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 153704f812ed..4973fa859217 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -156,6 +156,7 @@ struct sdhci_pci_fixes {
>  #endif
>  
>  	const struct sdhci_ops	*ops;
> +	const struct dmi_system_id *cd_gpio_override;
>  	size_t			priv_size;
>  };
>  

