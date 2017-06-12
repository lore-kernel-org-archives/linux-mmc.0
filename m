From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-acpi: Add DMI based blacklist
Date: Mon, 12 Jun 2017 15:11:47 +0300
Message-ID: <515f2626-6224-f913-30e3-71b796fea61b@intel.com>
References: <20170608185500.3317-1-hdegoede@redhat.com>
 <20170608185500.3317-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:53834 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdFLMRu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Jun 2017 08:17:50 -0400
In-Reply-To: <20170608185500.3317-2-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 08/06/17 21:55, Hans de Goede wrote:
> Add a DMI based blacklist for systems where probing some sdio interfaces
> is harmful (e.g. causes pci-e based wifi to not work).
> 
> BugLink: https://bbs.archlinux.org/viewtopic.php?id=224086
> Fixes: db52d4f8a4bd ("mmc: sdhci-acpi: support 80860F14 UID 2 SDIO bus")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Adjust for changes in mmc: sdhci-acpi: Add fix_up_power_blacklist module option
> -Only use a single fix_up_power_dmi_blacklist for the GPDwin further testing
>  has shown that the DMI strings are unique enough that we do not need the
>  bios-date in there
> 
> Changes in v3:
> -Adjust for changes to "mmc: sdhci-acpi: Add blacklist module option"
> 
> Changes in v4:
> -Rename blacklist to dmi_probe_blacklist as it now blacklists probing,
>  rather then calling acpi_device_fix_up_power.
> -Also check bios-date against known bios-dates for the GPD win, to avoid
>  possible false positives due to the use of quite generic DMI strings
> -Add Fixes and BugLink tags
> ---
>  drivers/mmc/host/sdhci-acpi.c | 64 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index ecc3aefd4643..3e12a6a8ad99 100644
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
> @@ -83,6 +84,11 @@ struct sdhci_acpi_host {
>  	bool				use_runtime_pm;
>  };
>  
> +struct dmi_probe_blacklist_data {
> +	const char *hid_uid;
> +	const char * const *bios_dates;
> +};
> +
>  static char *blacklist;
>  
>  static bool sdhci_acpi_compare_hid_uid(const char *match, const char *hid,
> @@ -116,6 +122,34 @@ static bool sdhci_acpi_compare_hid_uid(const char *match, const char *hid,
>  	return false;
>  }
>  
> +static const char *sdhci_acpi_get_dmi_blacklist(const struct dmi_system_id *bl)
> +{
> +	const struct dmi_system_id *dmi_id;
> +	const struct dmi_probe_blacklist_data *bl_data;
> +	const char *bios_date;
> +	int i;
> +
> +	dmi_id = dmi_first_match(bl);
> +	if (!dmi_id)
> +		return NULL;
> +
> +	bl_data = dmi_id->driver_data;
> +
> +	if (!bl_data->bios_dates)
> +		return bl_data->hid_uid;
> +
> +	bios_date = dmi_get_system_info(DMI_BIOS_DATE);
> +	if (!bios_date)
> +		return NULL;
> +
> +	for (i = 0; bl_data->bios_dates[i]; i++) {
> +		if (strcmp(bl_data->bios_dates[i], bios_date) == 0)
> +			return bl_data->hid_uid;
> +	}
> +
> +	return NULL;
> +}
> +
>  static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
>  {
>  	return c->slot && (c->slot->flags & flag);
> @@ -391,6 +425,33 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>  
> +const struct dmi_probe_blacklist_data gpd_win_bl_data = {
> +	.hid_uid = "80860F14:2",
> +	.bios_dates = (const char * const []){
> +		"10/25/2016", "11/18/2016", "02/21/2017", NULL },
> +};
> +
> +static const struct dmi_system_id dmi_probe_blacklist[] = {
> +	{
> +		/*
> +		 * Match for the GPDwin which unfortunately uses somewhat
> +		 * generic dmi strings, which is why we test for 4 strings
> +		 * and a known BIOS date.
> +		 * Comparing against 29 other byt/cht boards, board_name is
> +		 * unique to the GPDwin, where as only 2 other boards have the
> +		 * same board_serial and 3 others have the same board_vendor
> +		 */
> +		.driver_data = (void *)&gpd_win_bl_data,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
> +			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> +		},

To me this is matching by accident rather than by design, which is not
acceptable.

> +	},
> +	{ }
> +};
> +
>  static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
>  							 const char *uid)
>  {
> @@ -427,6 +488,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	hid = acpi_device_hid(device);
>  	uid = device->pnp.unique_id;
>  
> +	if (!bl)
> +		bl = sdhci_acpi_get_dmi_blacklist(dmi_probe_blacklist);
> +
>  	if (sdhci_acpi_compare_hid_uid(bl, hid, uid))
>  		return -ENODEV;
>  
> 

