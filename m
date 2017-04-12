From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-acpi: Add DMI fix_up_power_blacklist
Date: Wed, 12 Apr 2017 16:16:29 +0300
Message-ID: <b2dd19bb-18f5-8d85-86cf-0baee20c1c27@intel.com>
References: <20170405130007.5826-1-hdegoede@redhat.com>
 <20170405130007.5826-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:13384 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753552AbdDLNWJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Apr 2017 09:22:09 -0400
In-Reply-To: <20170405130007.5826-3-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

On 05/04/17 16:00, Hans de Goede wrote:
> Add a DMI based blacklist for systems where calling
> acpi_device_fix_up_power() is harmful.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Adjust for changes in mmc: sdhci-acpi: Add fix_up_power_blacklist module option
> -Only use a single fix_up_power_dmi_blacklist for the GPDwin further testing
>  has shown that the DMI strings are unique enough that we do not need the
>  bios-date in there
> ---
>  drivers/mmc/host/sdhci-acpi.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 5a73174..ba9e688 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -36,6 +36,7 @@
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/pm.h>
> @@ -384,6 +385,27 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>  
> +static const struct dmi_system_id fix_up_power_dmi_blacklist[] = {
> +	{
> +		/*
> +		 * Match for the GPDwin which unfortunately uses somewhat
> +		 * generic dmi strings, which is why we test for 4 strings.
> +		 * Comparing against 15 other byt/cht boards, board_vendor
> +		 * and board_name are unique to the GPDwin, where as only one
> +		 * other board has the same board_serial and 2 others have
> +		 * the same default product_name.
> +		 */
> +		.driver_data = "80860F14:2",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
> +			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),

That match is too broad - it looks like defaults from AMI.  Other lazy
manufacturers might also not bother to change the values.

> +		},
> +	},
> +	{ }
> +};
> +
>  static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
>  							 const char *uid)
>  {
> @@ -407,6 +429,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	const char *fix_up_power_bl = fix_up_power_blacklist;
>  	bool fix_up_power = true;
>  	struct acpi_device *device, *child;
> +	const struct dmi_system_id *dmi_id;
>  	struct sdhci_acpi_host *c;
>  	struct sdhci_host *host;
>  	struct resource *iomem;
> @@ -421,6 +444,12 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	hid = acpi_device_hid(device);
>  	uid = device->pnp.unique_id;
>  
> +	if (!fix_up_power_bl) {
> +		dmi_id = dmi_first_match(fix_up_power_dmi_blacklist);
> +		if (dmi_id)
> +			fix_up_power_bl = dmi_id->driver_data;
> +	}
> +
>  	if (sdhci_acpi_compare_hid_uid(fix_up_power_bl, hid, uid))
>  		fix_up_power = false;
>  
> 

