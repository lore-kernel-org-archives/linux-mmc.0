From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 resend 3/3] mmc: sdhci-acpi: Add DMI based blacklist
Date: Wed, 7 Jun 2017 16:09:16 +0300
Message-ID: <79b5300b-11a2-33f1-439d-e09a2047d6f3@intel.com>
References: <20170524104755.25274-1-hdegoede@redhat.com>
 <20170524104755.25274-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:14987 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbdFGNPP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Jun 2017 09:15:15 -0400
In-Reply-To: <20170524104755.25274-4-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 24/05/17 13:47, Hans de Goede wrote:
> Add a DMI based blacklist for systems where probing some sdio interfaces
> is harmful (e.g. causes pci-e based wifi to not work).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Adjust for changes in mmc: sdhci-acpi: Add fix_up_power_blacklist module option
> -Only use a single fix_up_power_dmi_blacklist for the GPDwin further testing
>  has shown that the DMI strings are unique enough that we do not need the
>  bios-date in there
> Changes in v3:
> -Adjust for changes to "mmc: sdhci-acpi: Add blacklist module option"
> ---
>  drivers/mmc/host/sdhci-acpi.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 3a7d979a306d..45455abc7ca6 100644
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
> @@ -381,6 +382,28 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>  
> +static const struct dmi_system_id fix_up_power_dmi_blacklist[] = {
> +	{
> +		/*
> +		 * Match for the GPDwin which unfortunately uses somewhat
> +		 * generic dmi strings, which is why we test for 4 strings.
> +		 * Comparing against 23 other byt/cht boards, board_vendor
> +		 * and board_name are unique to the GPDwin, where as only one
> +		 * other board has the same board_serial and 3 others have
> +		 * the same default product_name. Also the GPDwin is the
> +		 * only device to have both board_ and product_name not set.
> +		 */
> +		.driver_data = "80860F14:2",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
> +			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),

I can't accept that this is an accurate way to identify the board.
